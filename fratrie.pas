unit Fratrie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  FMUtils;

type

  { TFormFratrie }

  TFormFratrie = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PopupMenuFratrie: TPopupMenu;
    TableauFratrie: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateFratrie;

var
  FormFratrie: TFormFratrie;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormFratrie }

procedure PopulateFratrie;
var
  row, nbmarriage:integer;
  naissance,deces,p1,p2,conjoint,temp:string;
begin
// Cherche les parents principaux P1 et P2
  p1:='0';
  p2:='0';
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT R.B FROM R WHERE X=1 AND A='+Principale.Individu.Caption+' ORDER BY SD');
  Principale.Query1.Open;
  if not Principale.Query1.EOF then
     begin
     p1:=Principale.Query1.Fields[0].AsString;
     Principale.Query1.Next;
  end;
  if not Principale.Query1.EOF then
     p2:=Principale.Query1.Fields[0].AsString;
  Principale.Query1.SQL.Clear;
  if (strtoint(p1)>0) then
     if (strtoint(p2)>0) then
        Principale.Query1.SQL.add('SELECT R.no, R.A, N.N, N.I3, N.I4 FROM R JOIN N on N.I=R.A WHERE N.X=1 AND R.X=1 AND (R.B='+
                                  p1+' OR R.B='+p2+') ORDER BY R.SD, N.I')
     else
        Principale.Query1.SQL.add('SELECT R.no, R.A, N.N, N.I3, N.I4 FROM R JOIN N on N.I=R.A WHERE N.X=1 AND R.X=1 AND (R.B='+
                                  p1+') ORDER BY R.SD, N.I')
  else
     if (strtoint(p2)>0) then
        Principale.Query1.SQL.add('SELECT R.no, R.A, N.N, N.I3, N.I4 FROM R JOIN N on N.I=R.A WHERE N.X=1 AND R.X=1 AND (R.B='+
                                  p2+') ORDER BY R.SD, N.I')
     else
        Principale.Query1.SQL.add('SELECT no FROM I WHERE no=''A''');
  Principale.Query1.Open;
  Principale.Query1.First;
  row:=1;
  FormFratrie.TableauFratrie.RowCount:=Principale.Query1.RecordCount+1;
  While not Principale.Query1.EOF do
  begin
     // Enlève les doublons et le sujet
     if (not (Principale.Query1.Fields[1].AsString=Principale.Individu.Caption)) and
        (not (Principale.Query1.Fields[1].AsString=FormFratrie.TableauFratrie.Cells[2,row-1])) then
        begin
        FormFratrie.TableauFratrie.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
        if Copy(Principale.Query1.Fields[3].AsString,1,1)='1' then
           naissance:=Copy(Principale.Query1.Fields[3].AsString,2,4)
        else
           naissance:='';
        if Copy(Principale.Query1.Fields[4].AsString,1,1)='1' then
           deces:=Copy(Principale.Query1.Fields[4].AsString,2,4)
        else
           deces:='';
        // Trouver conjoint + nombre de conjoints
        conjoint:='';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.add('SELECT E.no FROM (E JOIN Y on E.Y=Y.no) JOIN W on W.E=E.no WHERE W.X=1 AND E.X=1 AND Y.Y=''M'' AND W.I='+Principale.Query1.Fields[1].AsString);
        Principale.Query2.Open;
        nbmarriage:=Principale.Query2.RecordCount;
        if not Principale.Query2.EOF then
           begin
           temp:=Principale.Query2.Fields[0].AsString;
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.add('SELECT W.I, N.N FROM W JOIN N on W.I=N.I WHERE W.X=1 AND N.X=1 AND W.E='+temp+
                                     ' AND NOT W.I='+Principale.Query1.Fields[1].AsString);
           Principale.Query2.Open;
           conjoint:=DecodeName(Principale.Query2.Fields[1].AsString,1);
        end;
        if length(conjoint)>0 then
           FormFratrie.TableauFratrie.Cells[1,row]:=DecodeName(Principale.Query1.Fields[2].AsString,1)+
                                                    ' ('+naissance+' - '+deces+
                                                    ') & '+conjoint+' (1 de '+
                                                    IntToStr(nbmarriage)+')'
        else
           FormFratrie.TableauFratrie.Cells[1,row]:=DecodeName(Principale.Query1.Fields[2].AsString,1)+' ('+
                                                    naissance+' - '+deces+')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.add('SELECT Q FROM C WHERE Y=''R'' AND N='+FormFratrie.TableauFratrie.Cells[0,row]+' ORDER BY Q DESC');
        Principale.Query2.Open;
        FormFratrie.TableauFratrie.Cells[2,row]:=Principale.Query1.Fields[1].AsString;
        FormFratrie.TableauFratrie.Cells[3,row]:=Principale.Query2.Fields[0].AsString;
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.add('SELECT no FROM R WHERE X=1 AND B='+Principale.Query1.Fields[1].AsString);
        Principale.Query2.Open;
        If (not Principale.Query2.EOF) then
           FormFratrie.TableauFratrie.Cells[4,row]:='+'
        else
           FormFratrie.TableauFratrie.Cells[4,row]:='';
        row:=row+1;
     end
     else
        FormFratrie.TableauFratrie.RowCount:=FormFratrie.TableauFratrie.RowCount-1;
     Principale.Query1.Next;
  end;
  FormFratrie.Caption:=AnsitoUTF8(Principale.Traduction.Items[116])+' ('+IntToStr(FormFratrie.TableauFratrie.RowCount-1)+')';
end;

procedure TFormFratrie.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauFratrie as TStringGrid,4);
end;

procedure TFormFratrie.FormResize(Sender: TObject);
begin
  TableauFratrie.Width := (Sender as Tform).Width;
  TableauFratrie.Height := (Sender as Tform).Height;
  TableauFratrie.Columns[0].Width := (Sender as Tform).Width-62;
end;

procedure TFormFratrie.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[116]);
  TableauFratrie.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[205]);
  TableauFratrie.Cells[2,0]:='#';
  TableauFratrie.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[222]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(FormFratrie.TableauFratrie as TStringGrid,4);
  PopulateFratrie;
end;

procedure TFormFratrie.MenuItem1Click(Sender: TObject);
begin
   if TableauFratrie.Row>0 then
      Principale.Individu.Caption:=TableauFratrie.Cells[2,TableauFratrie.Row];
end;

end.
