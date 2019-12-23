unit Parents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  FMUtils, Edit_Parents, LCLType;

type

  { TFormParents }

  TFormParents = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    PopupMenuParent: TPopupMenu;
    TableauParents: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure TableauParentsDblClick(Sender: TObject);
    procedure TableauParentsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TableauParentsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TableauParentsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure TableauParentsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateParents;

var
  FormParents: TFormParents;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormParents }

procedure PopulateParents;
var
  row:integer;
  naissance,deces:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT r.no, X, Y, B FROM r JOIN i ON r.B=i.no WHERE A='+Principale.Individu.Caption+' ORDER BY X DESC, i.S DESC, SD, Y, B');
  Principale.Query1.Open;
  Principale.Query1.First;
  row:=1;
  FormParents.TableauParents.RowCount:=Principale.Query1.RecordCount+1;
  While not Principale.Query1.EOF do
  begin
     FormParents.TableauParents.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     if Principale.Query1.Fields[1].AsBoolean then
        FormParents.TableauParents.Cells[1,row]:='*'
     else
        FormParents.TableauParents.Cells[1,row]:='';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT T FROM Y WHERE no='+Principale.Query1.Fields[2].AsString);
     Principale.Query2.Open;
     FormParents.TableauParents.Cells[2,row]:=Principale.Query2.Fields[0].AsString;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT N, I3, I4 FROM N WHERE X=1 AND I='+Principale.Query1.Fields[3].AsString);
     Principale.Query2.Open;
     if Copy(Principale.Query2.Fields[1].AsString,1,1)='1' then
        naissance:=Copy(Principale.Query2.Fields[1].AsString,2,4)
     else
        naissance:='';
     if Copy(Principale.Query2.Fields[2].AsString,1,1)='1' then
        deces:=Copy(Principale.Query2.Fields[2].AsString,2,4)
     else
        deces:='';
     FormParents.TableauParents.Cells[3,row]:=DecodeName(Principale.Query2.Fields[0].AsString,1)+' ('+
                                              naissance+' - '+deces+')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT Q FROM C WHERE Y=''R'' AND N='+FormParents.TableauParents.Cells[0,row]+' ORDER BY Q DESC');
     Principale.Query2.Open;
     FormParents.TableauParents.Cells[4,row]:=Principale.Query2.Fields[0].AsString;
     FormParents.TableauParents.Cells[5,row]:=Principale.Query1.Fields[3].AsString;
     Principale.Query1.Next;
     row:=row+1;
  end;
  FormParents.Caption:=AnsitoUTF8(Principale.Traduction.Items[130])+' ('+IntToStr(FormParents.TableauParents.RowCount-1)+')';
end;

procedure TFormParents.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauParents as TStringGrid,4);
end;

procedure TFormParents.FormResize(Sender: TObject);
begin
  TableauParents.Width := (Sender as Tform).Width;
  TableauParents.Height := (Sender as Tform).Height;
  TableauParents.Columns[2].Width := (Sender as Tform).Width-131;
end;

procedure TFormParents.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[130]);
  TableauParents.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauParents.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[216]);
  TableauParents.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[222]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(TableauParents as TStringGrid,4);
  PopulateParents;
end;

procedure TFormParents.MenuItem1Click(Sender: TObject);
begin
   if TableauParents.Row>0 then
      Principale.Individu.Caption:=TableauParents.Cells[5,TableauParents.Row];
end;

procedure TFormParents.MenuItem2Click(Sender: TObject);
var
  s:string;
begin
     If TableauParents.Cells[1,TableauParents.row]='*' then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE R SET X=0 WHERE no='+
                                  TableauParents.Cells[0,TableauParents.row]);
        Principale.Query1.ExecSQL;
        // Modifie la date de modification
        SaveModificationTime(TableauParents.Cells[5,TableauParents.row]);
        SaveModificationTime(Principale.Individu.Caption);
        PopulateParents;
     end
     else
        begin
        Principale.Query1.SQL.Clear;
        // Trouve le parent primaire du meme sexe et l'enlève
        Principale.Query1.SQL.Add('SELECT I.S FROM I WHERE I.no='+
                                  TableauParents.Cells[5,TableauParents.row]);
        Principale.Query1.Open;
        If not Principale.Query1.EOF then
           begin
           S:=Principale.Query1.Fields[0].AsString;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT R.no, R.B FROM R JOIN I ON R.B=I.no WHERE I.S='''+
                                     S+''' AND R.X=1 AND R.A='+Principale.Individu.Caption);
           Principale.Query1.Open;
           If not Principale.Query1.EOF then
              begin
              Principale.Query2.SQL.Clear;
              Principale.Query2.SQL.Add('UPDATE R SET X=0 WHERE no='+
                                    Principale.Query1.Fields[0].AsString);
              Principale.Query2.ExecSQL;
              SaveModificationTime(Principale.Query1.Fields[1].AsString);
           end;
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE R SET X=1 WHERE no='+
                                  TableauParents.Cells[0,TableauParents.row]);
        Principale.Query1.ExecSQL;
        // Modifie la date de modification
        SaveModificationTime(TableauParents.Cells[5,TableauParents.row]);
        SaveModificationTime(Principale.Individu.Caption);
        PopulateParents;
     end;
end;

procedure TFormParents.MenuItem5Click(Sender: TObject);
begin
  // Ajouter un parent
  PutCode('P','0');
  PutCode('A','0');
  if EditParents.Showmodal = mrOK then
     begin
     PopulateParents;
  end;
end;

procedure TFormParents.MenuItem7Click(Sender: TObject);
begin
  // Supprimer un parent
  if TableauParents.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[131])+
           TableauParents.Cells[3,TableauParents.Row]+
           AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        SaveModificationTime(TableauParents.Cells[5,TableauParents.Row]);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM C WHERE Y=''R'' AND N='+TableauParents.Cells[0,TableauParents.Row]);
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM R WHERE no='+TableauParents.Cells[0,TableauParents.Row]);
        Principale.Query1.ExecSQL;
        TableauParents.DeleteRow(TableauParents.Row);
        SaveModificationTime(Principale.Individu.Text);
     end;
end;

procedure TFormParents.TableauParentsDblClick(Sender: TObject);
begin
  if TableauParents.Row>0 then
     begin
     PutCode('P','0');
     If EditParents.Showmodal=mrOK then
        PopulateParents;
  end;
end;

procedure TFormParents.TableauParentsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  // Fin de drag, démarre une nouvelle relation avec le draggé comme parent
 PutCode('P',Principale.DragValue.Caption);
 PutCode('A','0');
 Principale.DragValue.Caption:='0';
 Principale.DragName.Caption:='0';
 if EditParents.Showmodal = mrOK then
    begin
    PopulateParents;
 end;
end;

procedure TFormParents.TableauParentsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   accept := (StrToInt(Principale.DragValue.Caption)>0);
end;

procedure TFormParents.TableauParentsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if ((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol=3) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormParents.TableauParentsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  startCol, startRow : integer;
begin
  if Button=mbLeft then
     begin
     TableauParents.MouseToCell(x,y,startCol,StartRow);
     if StartRow>0 then
        begin
        TableauParents.Row:=StartRow;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT R.no, R.B, R.A, N.no FROM R JOIN N on R.B=N.I WHERE N.X=1 AND R.no='+TableauParents.Cells[0,StartRow]);
        Principale.Query1.Open;
        Principale.Query1.First;
        Principale.DragList.Caption:='';
        Principale.DragValue.Caption:=Principale.Query1.Fields[1].AsString;
        Principale.DragName.Caption:=Principale.Query1.Fields[3].AsString;
     end;
  end;
end;


end.

