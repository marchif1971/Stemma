unit Depots;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Menus, FMUtils, StrUtils, LCLType;

type

  { TFormDepots }

  TFormDepots = class(TForm)
    Button1: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem8: TMenuItem;
    PopupMenu1: TPopupMenu;
    TableauDepots: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure TableauDepotsDblClick(Sender: TObject);
    procedure TableauDepotsEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormDepots: TFormDepots;

implementation

uses
  unit1, utilisation;

{ TFormDepots }

procedure TFormDepots.TableauDepotsDblClick(Sender: TObject);
begin
  if TableauDepots.Row>0 then
     if StrToInt(TableauDepots.Cells[0,TableauDepots.Row])>0 then
        Principale.Individu.Text:=TableauDepots.Cells[0,TableauDepots.Row];
end;

procedure TFormDepots.TableauDepotsEditingDone(Sender: TObject);
var
  temp:string;
  depot:boolean;
begin
  Principale.Query1.SQL.Clear;
  temp:=TableauDepots.Cells[5,TableauDepots.Row];
  depot:=false;
  if (length(temp)>0) then
     if (temp[1] in ['0'..'9']) then
        depot:=StrtoInt(temp)>0;
  if (not depot) and (strtoint(TableauDepots.Cells[0,TableauDepots.Row])>0) then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+TableauDepots.Cells[0,TableauDepots.Row]);
     Principale.Query2.Open;
     depot:=(DecodeName(Principale.Query2.Fields[1].AsString,1)+' ('+TableauDepots.Cells[0,TableauDepots.Row]+')')=
            (TableauDepots.Cells[5,TableauDepots.Row]);
     temp:=TableauDepots.Cells[0,TableauDepots.Row];
     end;
  if depot then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+temp);
     Principale.Query2.Open;
     TableauDepots.Cells[5,TableauDepots.Row]:=DecodeName(Principale.Query2.Fields[1].AsString,1)+
                                                                   ' ('+temp+')';
     TableauDepots.Cells[0,TableauDepots.Row]:=temp;
     if TableauDepots.Cells[1,TableauDepots.Row]='0' then
        Principale.Query1.SQL.Add('INSERT INTO D (T,D,M,I) VALUES ('''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[3,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[4,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', '+TableauDepots.Cells[0,TableauDepots.Row]+')')
     else
        Principale.Query1.SQL.Add('UPDATE D SET T='''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', D='''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[3,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', M='''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[4,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', I='+TableauDepots.Cells[0,TableauDepots.Row]+
           ' WHERE no='+TableauDepots.Cells[1,TableauDepots.Row]);
  end
  else
     begin
     TableauDepots.Cells[5,TableauDepots.Row]:='0';
     TableauDepots.Cells[0,TableauDepots.Row]:='0';
     if TableauDepots.Cells[1,TableauDepots.Row]='0' then
        Principale.Query1.SQL.Add('INSERT INTO D (T,D,M,I) VALUES ('''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[3,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[4,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
           ''', 0)')
     else
        Principale.Query1.SQL.Add('UPDATE D SET T='''+
          AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
          ''', D='''+
          AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[3,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
          ''', M='''+
          AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[4,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
          ''', I=0 WHERE no='+TableauDepots.Cells[1,TableauDepots.Row]);
  end;
  Principale.Query1.ExecSQL;
  if TableauDepots.Cells[1,TableauDepots.Row]='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''D''');
     Principale.Query1.Open;
     Principale.Query1.First;
     TableauDepots.Cells[1,TableauDepots.Row]:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  TableauDepots.SortColRow(true,3);
end;

procedure TFormDepots.FormResize(Sender: TObject);
begin
  TableauDepots.Width := (Sender as Tform).Width-16;
  TableauDepots.Height := (Sender as Tform).Height-51;
  Button1.Top:= (Sender as Tform).Height-35;
  Button1.Left:= (Sender as Tform).Width-80;
end;

procedure TFormDepots.FormShow(Sender: TObject);
var
  i:integer;
  MyCursor: TCursor;
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[153]);
  TableauDepots.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauDepots.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauDepots.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[156]);
  TableauDepots.Cells[5,0]:=AnsitoUTF8(Principale.Traduction.Items[157]);
  TableauDepots.Cells[6,0]:=AnsitoUTF8(Principale.Traduction.Items[158]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[223]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Principale.ProgressBar.Position:=0;
  Principale.ProgressBar.Visible:=True;
  Application.Processmessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT D.no, D.T, D.D, D.M, D.I, COUNT(A.D) FROM D LEFT JOIN A on D.no=A.D GROUP by D.no ORDER BY D.D');
  Principale.Query1.Open;
  Principale.Query1.First;
  TableauDepots.RowCount:=Principale.Query1.RecordCount+1;
  Principale.ProgressBar.Max:=TableauDepots.RowCount;
  i:=0;
  While not Principale.Query1.Eof do
     begin
     i:=i+1;
     TableauDepots.Cells[0,i]:=Principale.Query1.Fields[4].AsString;
     TableauDepots.Cells[1,i]:=Principale.Query1.Fields[0].AsString;
     TableauDepots.Cells[2,i]:=Principale.Query1.Fields[1].AsString;
     TableauDepots.Cells[3,i]:=Principale.Query1.Fields[2].AsString;
     TableauDepots.Cells[4,i]:=Principale.Query1.Fields[3].AsString;
     if StrToInt(TableauDepots.Cells[0,i])>0 then
        begin
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+TableauDepots.Cells[0,i]);
        Principale.Query2.Open;
        Principale.Query2.First;
        TableauDepots.Cells[5,i]:=DecodeName(Principale.Query2.Fields[0].AsString,1)+
                                  ' ('+TableauDepots.Cells[0,i]+')';
     end
     else
        TableauDepots.Cells[5,i]:='0';
     TableauDepots.Cells[6,i]:=Principale.Query1.Fields[5].AsString;
     Principale.Query1.Next;
     Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  Principale.ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
end;

procedure TFormDepots.MenuItem2Click(Sender: TObject);
begin
  // Ajouter un Dépot
  TableauDepots.RowCount:=TableauDepots.RowCount+1;
  TableauDepots.Row:=TableauDepots.RowCount-1;
  TableauDepots.Cells[0,TableauDepots.Row]:='0';
  TableauDepots.Cells[1,TableauDepots.Row]:='0';
  TableauDepots.Cells[6,TableauDepots.Row]:='0';
end;

procedure TFormDepots.MenuItem3Click(Sender: TObject);
begin
  // Supprimer un Dépot
  if TableauDepots.Row>0 then
     if TableauDepots.Cells[6,TableauDepots.Row]='0' then
        if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[27])+
           TableauDepots.Cells[2,TableauDepots.Row]+
           AnsitoUTF8(Principale.Traduction.Items[28])),Pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
           begin
           // Supprimer toutes les associations dépots de cette source
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM A WHERE D='+TableauDepots.Cells[1,TableauDepots.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM D WHERE no='+TableauDepots.Cells[1,TableauDepots.Row]);
           Principale.Query1.ExecSQL;
           TableauDepots.DeleteRow(TableauDepots.Row);
        end;
end;

procedure TFormDepots.MenuItem8Click(Sender: TObject);
begin
  PutCode('D',TableauDepots.Cells[1,TableauDepots.Row]);
  FormUtilisation.ShowModal;
end;

{$R *.lfm}

end.

