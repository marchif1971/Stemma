unit Enfants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  FMUtils, Edit_Parents, LCLType;

type

  { TFormEnfants }

  TFormEnfants = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PopupMenuEnfant: TPopupMenu;
    TableauEnfants: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure TableauEnfantsDblClick(Sender: TObject);
    procedure TableauEnfantsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TableauEnfantsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TableauEnfantsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure TableauEnfantsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateEnfants;

var
  FormEnfants: TFormEnfants;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormEnfants }

procedure PopulateEnfants;
var
  row, principaux:integer;
  naissance,deces:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT R.no, R.X, R.Y, R.A, N.N, N.I3, N.I4 FROM R JOIN N on N.I=R.A WHERE N.X=1 AND R.B='+
                            Principale.Individu.Caption+' ORDER BY R.X DESC, R.SD, R.Y, N.I3');
  Principale.Query1.Open;
  Principale.Query1.First;
  row:=1;
  principaux:=0;
  FormEnfants.TableauEnfants.RowCount:=Principale.Query1.RecordCount+1;
  While not Principale.Query1.EOF do
  begin
     FormEnfants.TableauEnfants.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     if Principale.Query1.Fields[1].AsBoolean then
        begin
        FormEnfants.TableauEnfants.Cells[1,row]:='*';
        principaux:=principaux+1;
     end
     else
        FormEnfants.TableauEnfants.Cells[1,row]:='';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT T FROM Y WHERE no='+Principale.Query1.Fields[2].AsString);
     Principale.Query2.Open;
     FormEnfants.TableauEnfants.Cells[2,row]:=Principale.Query2.Fields[0].AsString;
     if Copy(Principale.Query1.Fields[5].AsString,1,1)='1' then
        naissance:=Copy(Principale.Query1.Fields[5].AsString,2,4)
     else
        naissance:='';
     if Copy(Principale.Query1.Fields[6].AsString,1,1)='1' then
        deces:=Copy(Principale.Query1.Fields[6].AsString,2,4)
     else
        deces:='';
     FormEnfants.TableauEnfants.Cells[3,row]:=DecodeName(Principale.Query1.Fields[4].AsString,1)+' ('+
                                              naissance+' - '+deces+')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT Q FROM C WHERE Y=''R'' AND N='+FormEnfants.TableauEnfants.Cells[0,row]+' ORDER BY Q DESC');
     Principale.Query2.Open;
     FormEnfants.TableauEnfants.Cells[4,row]:=Principale.Query2.Fields[0].AsString;
     FormEnfants.TableauEnfants.Cells[5,row]:=Principale.Query1.Fields[3].AsString;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT no FROM R WHERE X=1 AND B='+Principale.Query1.Fields[3].AsString);
     Principale.Query2.Open;
     If (not Principale.Query2.EOF) then
        FormEnfants.TableauEnfants.Cells[6,row]:='+'
     else
        FormEnfants.TableauEnfants.Cells[6,row]:='';
     Principale.Query1.Next;
     row:=row+1;
  end;
  FormEnfants.Caption:=AnsitoUTF8(Principale.Traduction.Items[57])+' ('+IntToStr(principaux)+' & '+IntToStr(FormEnfants.TableauEnfants.RowCount-1-principaux)+')'
end;

procedure TFormEnfants.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauEnfants as TStringGrid,6);
end;

procedure TFormEnfants.FormResize(Sender: TObject);
begin
  TableauEnfants.Width := (Sender as Tform).Width;
  TableauEnfants.Height := (Sender as Tform).Height;
  TableauEnfants.Columns[2].Width := (Sender as Tform).Width-142;
end;

procedure TFormEnfants.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[57]);
  TableauEnfants.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauEnfants.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[200]);
  TableauEnfants.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[222]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(TableauEnfants as TStringGrid,6);
  PopulateEnfants;
end;

procedure TFormEnfants.MenuItem1Click(Sender: TObject);
begin
  If TableauEnfants.Row>0 then
     Principale.Individu.Caption:=TableauEnfants.Cells[5,TableauEnfants.Row];
end;

procedure TFormEnfants.MenuItem3Click(Sender: TObject);
begin
  // Ajouter un enfant
  PutCode('E','0');
  PutCode('A','0');
  if EditParents.Showmodal = mrOK then
     begin
     PopulateEnfants;
  end;
end;

procedure TFormEnfants.MenuItem5Click(Sender: TObject);
begin
  // Supprimer un enfant
  if TableauEnfants.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[58])+
           TableauEnfants.Cells[3,TableauEnfants.Row]+
           AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        SaveModificationTime(TableauEnfants.Cells[5,TableauEnfants.Row]);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM C WHERE Y=''R'' AND N='+TableauEnfants.Cells[0,TableauEnfants.Row]);
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM R WHERE no='+TableauEnfants.Cells[0,TableauEnfants.Row]);
        Principale.Query1.ExecSQL;
        TableauEnfants.DeleteRow(TableauEnfants.Row);
        SaveModificationTime(Principale.Individu.Text);
     end;
end;

procedure TFormEnfants.TableauEnfantsDblClick(Sender: TObject);
begin
  If TableauEnfants.Row>0 then
     begin
     PutCode('E','0');
     If EditParents.Showmodal=mrOK then
        PopulateEnfants;
  end;
end;

procedure TFormEnfants.TableauEnfantsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  // Fin de drag, démarre une nouvelle relation avec le draggé comme enfant
 PutCode('E',Principale.DragValue.Caption);
 PutCode('A','0');
 Principale.DragValue.Caption:='0';
 Principale.DragName.Caption:='0';
 if EditParents.Showmodal = mrOK then
    begin
    PopulateEnfants;
 end;
end;

procedure TFormEnfants.TableauEnfantsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragValue.Caption)>0);
end;

procedure TFormEnfants.TableauEnfantsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if ((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol=3) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormEnfants.TableauEnfantsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  startCol, startRow : integer;
begin
  if Button=mbLeft then
     begin
     TableauEnfants.MouseToCell(x,y,startCol,StartRow);
     if StartRow>0 then
        begin
        TableauEnfants.Row:=StartRow;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT R.no, R.B, R.A, N.no FROM R JOIN N on R.A=N.I WHERE N.X=1 AND R.no='+TableauEnfants.Cells[0,StartRow]);
        Principale.Query1.Open;
        Principale.Query1.First;
        Principale.DragValue.Caption:=Principale.Query1.Fields[2].AsString;
        Principale.DragName.Caption:=Principale.Query1.Fields[3].AsString;
     end;
  end;
end;

end.

