unit exhibits;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  FMUtils, Edit_Exhibits, Image, LCLType;

type

  { TFormExhibits }

  TFormExhibits = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PopupMenuEnfant: TPopupMenu;
    TableauExhibits: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure TableauExhibitsDblClick(Sender: TObject);
    procedure TableauExhibitsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure TableauExhibitsSelection(Sender: TObject; aCol, aRow: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateExhibits(Tableau:TStringGrid;Code:string;no:string);

var
  FormExhibits: TFormExhibits;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormExhibits }

procedure TFormExhibits.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauExhibits as TStringGrid,4);
end;

procedure TFormExhibits.FormResize(Sender: TObject);
begin
  TableauExhibits.Width := (Sender as Tform).Width;
  TableauExhibits.Height := (Sender as Tform).Height;
  TableauExhibits.Columns[1].Width := (Sender as Tform).Width-122;
end;

procedure TFormExhibits.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[65]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  TableauExhibits.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauExhibits.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauExhibits.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[201]);
  GetFormPosition(Sender as TForm,0,0,200,200);
  GetGridPosition(FormExhibits.TableauExhibits as TStringGrid,4);
  PopulateExhibits(TableauExhibits,'I',Principale.Individu.Caption);
end;

procedure TFormExhibits.MenuItem1Click(Sender: TObject);
begin
  if TableauExhibits.Cells[3,TableauExhibits.row]='I' then
     begin
     Principale.Query1.SQL.Clear;
     If TableauExhibits.Cells[1,TableauExhibits.row]='*' then
        Principale.Query1.SQL.Add('UPDATE X SET X=0 WHERE X.no='+
                                  TableauExhibits.Cells[0,TableauExhibits.row])
     else
        begin
        Principale.Query1.SQL.Add('UPDATE X SET X=0 WHERE X.A=''I'' AND X.N='+
                                  Principale.Individu.Caption);
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE X SET X=1 WHERE X.no='+
                                  TableauExhibits.Cells[0,TableauExhibits.row]);
     end;
     Principale.Query1.ExecSQL;
     // Modifie la date de modification
     SaveModificationTime(Principale.Individu.Caption);
     PopulateExhibits(TableauExhibits,'I',Principale.Individu.Caption);
  end
  else
     ShowMessage(AnsitoUTF8(Principale.Traduction.Items[61]));
end;

procedure TFormExhibits.MenuItem3Click(Sender: TObject);
begin
  // Ajouter un exhibit
  PutCode('I',Principale.Individu.Text);
  PutCode('A',Principale.Individu.Text);
  If EditExhibits.Showmodal=mrOK then
      PopulateExhibits(TableauExhibits,'I',Principale.Individu.Caption);
end;

procedure TFormExhibits.MenuItem5Click(Sender: TObject);
begin
  // Supprimer un exhibit
  if TableauExhibits.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[62])+
        TableauExhibits.Cells[2,TableauExhibits.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM X WHERE no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
        Principale.Query1.ExecSQL;
        TableauExhibits.DeleteRow(TableauExhibits.Row);
        if Principale.MenuItem26.Checked then
           begin
           if TableauExhibits.Row>0 then
              TableauExhibitsSelection(Sender,0,TableauExhibits.Row)
           else
              FormImage.Im.Picture.Clear;
        end;
        SaveModificationTime(Principale.Individu.Text);
     end;
end;

procedure TFormExhibits.TableauExhibitsDblClick(Sender: TObject);
begin
  If TableauExhibits.Row>0 then
     begin
     PutCode('E',TableauExhibits.Cells[0,TableauExhibits.Row]);
     If EditExhibits.Showmodal=mrOK then
        PopulateExhibits(TableauExhibits,'I',Principale.Individu.Caption);
     end;
end;

procedure TFormExhibits.TableauExhibitsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if ((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol=2) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormExhibits.TableauExhibitsSelection(Sender: TObject; aCol,
  aRow: Integer);
begin
  if TableauExhibits.Cells[1,aRow]='*' then
     PopulateImage(0)
  else
     PopulateImage(StrToInt(TableauExhibits.Cells[0,aRow]));
end;

procedure PopulateExhibits(Tableau:TStringGrid;code:string;no:string);
var
  row:integer;
  titre,desc:string;
begin
  row:=1;
  if code='I' then
     begin
     Principale.Query1.SQL.Clear;
     // Ajouter les exhibits de l'individu
     Principale.Query1.SQL.add('SELECT X.no, X.X, X.T, X.D, X.F, X.A FROM X WHERE (X.A=''I'' AND X.N='+
                               no+')'+' ORDER BY X.T');
     Principale.Query1.Open;
     Principale.Query1.First;
     Tableau.RowCount:=Principale.Query1.RecordCount+1;
     While not Principale.Query1.EOF do
     begin
        Tableau.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
        if Principale.Query1.Fields[1].AsBoolean then
           Tableau.Cells[1,row]:='*'
        else
           Tableau.Cells[1,row]:='';
        titre:=Principale.Query1.Fields[2].AsString;
        desc:=Principale.Query1.Fields[3].AsString;
        if length(titre)=0 then
           if length(desc)=0 then
              Tableau.Cells[2,row]:=AnsitoUTF8(Principale.Traduction.Items[63])
           else
              Tableau.Cells[2,row]:=desc
        else
           if length(desc)=0 then
              Tableau.Cells[2,row]:=titre
           else
              Tableau.Cells[2,row]:=titre+', '+desc;
        Tableau.Cells[3,row]:=Principale.Query1.Fields[5].AsString;
        if length(Principale.Query1.Fields[4].AsString)=0 then
           Tableau.Cells[4,row]:=AnsitoUTF8(Principale.Traduction.Items[34])
        else
           Tableau.Cells[4,row]:=AnsitoUTF8(Principale.Traduction.Items[64]);
        Principale.Query1.Next;
        row:=row+1;
     end;
  end
  else
    Tableau.RowCount:=1;
  // Ajouter les exhibits des événements
  Principale.Query1.SQL.Clear;
  if code='I' then
     Principale.Query1.SQL.add('SELECT X.no, X.X, X.T, X.D, X.F, X.A FROM (X JOIN E on X.N=E.no) JOIN W on W.E=E.no WHERE (X.A=''E'' AND W.I='+
                               no+')'+' ORDER BY X.T');
  if code='E' then
     Principale.Query1.SQL.add('SELECT X.no, X.X, X.T, X.D, X.F, X.A FROM X WHERE X.A=''E'' AND X.N='+
                               no+' ORDER BY X.T');
  if code='S' then
     Principale.Query1.SQL.add('SELECT X.no, X.X, X.T, X.D, X.F, X.A FROM X WHERE X.A=''S'' AND X.N='+
                               no+' ORDER BY X.T');
  Principale.Query1.Open;
  Principale.Query1.First;
  Tableau.RowCount:=Tableau.RowCount+Principale.Query1.RecordCount;
  While not Principale.Query1.EOF do
  begin
     Tableau.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     Tableau.Cells[1,row]:='';
     titre:=Principale.Query1.Fields[2].AsString;
     desc:=Principale.Query1.Fields[3].AsString;
     if length(titre)=0 then
        if length(desc)=0 then
           Tableau.Cells[2,row]:=AnsitoUTF8(Principale.Traduction.Items[63])
        else
           Tableau.Cells[2,row]:=desc
     else
        if length(desc)=0 then
           Tableau.Cells[2,row]:=titre
        else
           Tableau.Cells[2,row]:=titre+', '+desc;
     Tableau.Cells[3,row]:=Principale.Query1.Fields[5].AsString;
     if length(Principale.Query1.Fields[4].AsString)=0 then
        Tableau.Cells[4,row]:=AnsitoUTF8(Principale.Traduction.Items[34])
     else
        Tableau.Cells[4,row]:=AnsitoUTF8(Principale.Traduction.Items[64]);
     Principale.Query1.Next;
     row:=row+1;
  end;
  if code='I' then
     FormExhibits.Caption:=AnsitoUTF8(Principale.Traduction.Items[65])+' ('+IntToStr(Tableau.RowCount-1)+')';
end;
end.

