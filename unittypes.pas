unit unitTypes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  StdCtrls,StrUtils, LCLType;

type

  { TFormTypes }

  TFormTypes = class(TForm)
    Button1: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem8: TMenuItem;
    PopupMenu1: TPopupMenu;
    TableauTypes: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure TableauTypesEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormTypes: TFormTypes;

implementation

uses
  unit1, utilisation, edit_type, FMUtils;

{$R *.lfm}

{ TFormTypes }

procedure TFormTypes.FormResize(Sender: TObject);
begin
  TableauTypes.Width := (Sender as Tform).Width-16;
  TableauTypes.Height := (Sender as Tform).Height-51;
  Button1.Top:= (Sender as Tform).Height-35;
  Button1.Left:= (Sender as Tform).Width-80;
end;

procedure TFormTypes.FormShow(Sender: TObject);
var
  i:integer;
  MyCursor: TCursor;
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[220]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  TableauTypes.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauTypes.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauTypes.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[221]);
  TableauTypes.Cells[5,0]:=AnsitoUTF8(Principale.Traduction.Items[158]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[223]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Principale.ProgressBar.Position:=0;
  Principale.ProgressBar.Visible:=True;
  Application.Processmessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT Y.no, Y.T, Y.Y, Y.P FROM Y ORDER BY Y.T');
  Principale.Query1.Open;
  Principale.Query1.First;
  TableauTypes.RowCount:=Principale.Query1.RecordCount+1;
  Principale.ProgressBar.Max:=TableauTypes.RowCount;
  i:=0;
  While not Principale.Query1.Eof do
     begin
     i:=i+1;
     TableauTypes.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
     TableauTypes.Cells[1,i]:=Principale.Query1.Fields[0].AsString;
     TableauTypes.Cells[2,i]:=Principale.Query1.Fields[1].AsString;
     TableauTypes.Cells[3,i]:=Principale.Query1.Fields[2].AsString;
     TableauTypes.Cells[4,i]:=Principale.Query1.Fields[3].AsString;
// Aller chercher les utilisation
     Principale.Query2.SQL.Clear;
     if TableauTypes.Cells[3,i]='R' then
        Principale.Query2.SQL.add('SELECT COUNT(R.Y) FROM R WHERE R.Y='+Principale.Query1.Fields[0].AsString)
     else
       if TableauTypes.Cells[3,i]='N' then
          Principale.Query2.SQL.add('SELECT COUNT(N.Y) FROM N WHERE N.Y='+Principale.Query1.Fields[0].AsString)
       else
         Principale.Query2.SQL.add('SELECT COUNT(E.Y) FROM E WHERE E.Y='+Principale.Query1.Fields[0].AsString);
     Principale.Query2.Open;
     Principale.Query2.First;
     TableauTypes.Cells[5,i]:=Principale.Query2.Fields[0].AsString;
     Principale.Query1.Next;
     Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  Principale.ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
end;

procedure TFormTypes.MenuItem2Click(Sender: TObject);    // Ajouter
begin
     PutCode('A','0');
     if EditType.Showmodal = mrOK then
        begin
        FormShow(Sender);
     end;
end;

procedure TFormTypes.MenuItem3Click(Sender: TObject);    // Supprimer
begin
  if TableauTypes.Row>0 then
     if StrtoInt(TableauTypes.Cells[5,TableauTypes.Row])=0 then
        if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[133])+
           TableauTypes.Cells[2,TableauTypes.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
           begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('DELETE FROM Y WHERE no='+TableauTypes.Cells[1,TableauTypes.Row]);
              Principale.Query1.ExecSQL;
              TableauTypes.DeleteRow(TableauTypes.Row);
        end;
end;

procedure TFormTypes.MenuItem4Click(Sender: TObject);      // Modifier
begin
  if TableauTypes.Row>0 then
     if EditType.Showmodal = mrOK then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('SELECT Y.no, Y.T, Y.Y, Y.P FROM Y WHERE Y.no='+
           TableauTypes.Cells[0,TableauTypes.Row]);
        Principale.Query1.Open;
        Principale.Query1.First;
        TableauTypes.Cells[2,TableauTypes.Row]:=Principale.Query1.Fields[1].AsString;
        TableauTypes.Cells[3,TableauTypes.Row]:=Principale.Query1.Fields[2].AsString;
        TableauTypes.Cells[4,TableauTypes.Row]:=Principale.Query1.Fields[3].AsString;
        // Aller chercher les utilisation
        Principale.Query2.SQL.Clear;
        if TableauTypes.Cells[3,TableauTypes.Row]='R' then
           Principale.Query2.SQL.add('SELECT COUNT(R.Y) FROM R WHERE R.Y='+Principale.Query1.Fields[0].AsString)
        else
          if TableauTypes.Cells[3,TableauTypes.Row]='N' then
             Principale.Query2.SQL.add('SELECT COUNT(N.Y) FROM N WHERE N.Y='+Principale.Query1.Fields[0].AsString)
          else
             Principale.Query2.SQL.add('SELECT COUNT(E.Y) FROM E WHERE E.Y='+Principale.Query1.Fields[0].AsString);
        Principale.Query2.Open;
        Principale.Query2.First;
        TableauTypes.Cells[5,TableauTypes.Row]:=Principale.Query2.Fields[0].AsString;
     end;
end;

procedure TFormTypes.MenuItem8Click(Sender: TObject);
begin
  if TableauTypes.Row>0 then
     if StrtoInt(TableauTypes.Cells[5,TableauTypes.Row])>0 then
        begin
        PutCode('T',TableauTypes.Cells[1,TableauTypes.Row]);
        FormUtilisation.ShowModal;
     end;
end;

procedure TFormTypes.TableauTypesEditingDone(Sender: TObject);
var
  temp, role, roles:string;
  pos1,pos2:integer;
begin
  roles:='';
  temp:=(Sender as TStringGrid).Cells[4,(Sender as TStringGrid).Row];
  while ANSIPos('<R=',temp)>0 do
     begin
     pos1:=ANSIPos('<R=',temp);
     temp:=Copy(temp,pos1+3,length(temp));
     pos2:=ANSIPos('>',temp);
     role:=uppercase(Copy(temp,1,pos2-1));
     if ANSIPos(role,roles)<=0 then
        if length(roles)>0 then
           roles:=roles+'|'+role
        else
           roles:=role;
     temp:=Copy(temp,pos2+1,length(temp));
  end;
  temp:=(Sender as TStringGrid).Cells[4,(Sender as TStringGrid).Row];
  while ANSIPos('[R=',temp)>0 do
     begin
     pos1:=ANSIPos('[R=',temp);
     temp:=Copy(temp,pos1+3,length(temp));
     pos2:=ANSIPos(']',temp);
     role:=uppercase(Copy(temp,1,pos2-1));
     if ANSIPos(role,roles)<=0 then
        if length(roles)>0 then
           roles:=roles+'|'+role
        else
           roles:=role;
     temp:=Copy(temp,pos2+1,length(temp));
  end;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('UPDATE Y SET T='''+
     AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[2,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
     ''', Y='''+
     AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[3,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
     ''', P='''+
     AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[4,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
     ''', R='''+
     AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Roles,'\','\\'),'"','\"'),'''','\''')+
     ''' WHERE no='+(Sender as TStringGrid).Cells[1,(Sender as TStringGrid).Row]);
  Principale.Query1.ExecSQL;
end;

end.

