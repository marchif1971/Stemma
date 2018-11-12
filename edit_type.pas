unit Edit_Type;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, FMUtils, StrUtils;

type

  { TEditType }

  TEditType = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    No: TEdit;
    Y: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    P: TMemo;
    T: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  EditType: TEditType;

implementation

uses
  unitTypes, unit1;

{ TEditType }

procedure TEditType.FormShow(Sender: TObject);
var
  code,nocode:string;
begin
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[199]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label11.Caption:=AnsitoUTF8(Principale.Traduction.Items[166]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[172]);
  // Populate le Combo-Box    ('B','D','M','N','R','X','Z')
  Y.Items.Clear;
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[49]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[50]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[51]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[52]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[53]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[54]));
  Y.Items.Add(AnsitoUTF8(Principale.Traduction.Items[55]));
  // Populate la form
  getcode(code,nocode);
  if code='A' then
     begin
     EditType.Caption:=AnsitoUTF8(Principale.Traduction.Items[56]);
     No.Text:='0';
     T.Text:='';
     P.Text:='';
     Y.ItemIndex:=0;
  end
  else
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT Y.no, Y.T, Y.Y, Y.P FROM Y WHERE Y.no='+
                                     FormTypes.TableauTypes.Cells[1,FormTypes.TableauTypes.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     No.Text:=Principale.Query1.Fields[0].AsString;
     T.Text:=Principale.Query1.Fields[1].AsString;
     P.Text:=Principale.Query1.Fields[3].AsString;
     Y.ItemIndex:=0;
     while not (Copy(Y.Items[Y.ItemIndex],1,1)=Principale.Query1.Fields[2].AsString) do
        Y.ItemIndex:=Y.ItemIndex+1;
  end;
end;

procedure TEditType.MenuItem1Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditType.MenuItem2Click(Sender: TObject);
var
  i:integer;
  found:boolean;
begin
  if EditType.ActiveControl.Name='P' then
     begin
     found:=false;
     For i:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,i]='P' then
           begin
           P.text:=Principale.DataHist.Cells[1,i];
           PEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For i:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,i]='P' then
              begin
              P.text:=Principale.DataHist.Cells[1,i];
              PEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if found then Principale.DataHist.Row:=i+1;
end;

procedure TEditType.PEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='P';
  Principale.DataHist.Cells[1,0]:=P.Text;
end;

procedure TEditType.Button1Click(Sender: TObject);
var
  temp, role, roles:string;
  pos1,pos2:integer;
begin
  roles:='';
  temp:=p.text;
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
  temp:=p.text;
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
  if no.text='0' then
     Principale.Query1.SQL.Add('INSERT INTO Y (T, Y, P, R) VALUES ('''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(T.text,'\','\\'),'"','\"'),'''','\''')+
        ''', '''+Copy(Y.Items[Y.ItemIndex],1,1)+''', '''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(P.text,'\','\\'),'"','\"'),'''','\''')+
        ''', '''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Roles,'\','\\'),'"','\"'),'''','\''')+
        ''')')
  else
     Principale.Query1.SQL.Add('UPDATE Y SET T='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(T.text,'\','\\'),'"','\"'),'''','\''')+
        ''', Y='''+Copy(Y.Items[Y.ItemIndex],1,1)+
        ''', P='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(P.text,'\','\\'),'"','\"'),'''','\''')+
        ''', R='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Roles,'\','\\'),'"','\"'),'''','\''')+
        ''' WHERE no='+no.text);
  Principale.Query1.ExecSQL;
end;

{$R *.lfm}

end.

