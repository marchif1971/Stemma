unit Edit_Citations;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, MaskEdit, Menus, StrUtils, FMUtils, Math;

type

  { TEditCitations }

  TEditCitations = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    S: TMaskEdit;
    Memo: TMemo;
    N: TEdit;
    Source: TComboBox;
    No: TEdit;
    Code: TEdit;
    Source1: TComboBox;
    Q: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure SEditingDone(Sender: TObject);
    procedure SourceEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  EditCitations: TEditCitations;

implementation

uses
  unit1;

{$R *.lfm}

{ TEditCitations }

procedure TEditCitations.FormShow(Sender: TObject);
var
  i:integer;
  sourcenumber, codex, nocode:string;
begin
   EditCitations.ActiveControl:=EditCitations.S;
   Principale.DataHist.Row:=0;
   Caption:=AnsitoUTF8(Principale.Traduction.Items[160]);
   Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[161]);
   Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[162]);
   Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[163]);
   Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
   Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
   // Populate Citations
   // GET TYPE AND NO FROM CALLER
   // Populate le ComboBox
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add('SELECT S.no, S.T FROM S ORDER BY S.no');
   Principale.Query2.Open;
   Principale.Query2.First;
   Source.Items.Clear;
   Source1.Items.Clear;
   while not Principale.Query2.EOF do
      begin
      sourcenumber:=Principale.Query2.Fields[0].AsString;
      i:=trunc(log10(Principale.Query2.RecordCount+1))+1;
      while length(sourcenumber)<i do sourcenumber:='0'+sourcenumber;
      Source.Items.Add(sourcenumber+'- '+Principale.Query2.Fields[1].AsString);
      Source1.Items.Add(Principale.Query2.Fields[0].AsString);
      Principale.Query2.Next;
   end;
   // Populate la form
   GetCode(codex,nocode);
   if Codex='A' then
      begin
      EditCitations.Caption:=AnsitoUTF8(Principale.Traduction.Items[29]);
      No.text:='0';
      Source.ItemIndex:=0;
      Source1.ItemIndex:=Source.ItemIndex;
      Memo.Text:='';
      GetCode(codex,nocode);
      Code.Text:=Codex;
      N.Text:=nocode;
      Q.Value:=0;
      S.Text:='';
   end
   else
      begin
      Principale.Query1.SQL.Clear;
      No.Text := nocode;
      Principale.Query1.SQL.Add('SELECT C.no, C.Y, C.N, C.S, C.M, C.Q FROM C WHERE C.no='+No.Text);
      Principale.Query1.Open;
      Principale.Query1.First;
      for i:=0 to Source1.Items.Count-1 do
         if Source1.Items[i]=Principale.Query1.Fields[3].AsString then
            Source.ItemIndex:=i;
      Source1.ItemIndex:=Source.ItemIndex;
      Memo.Text:=Principale.Query1.Fields[4].AsString;
      Code.Text:=Principale.Query1.Fields[1].AsString;
      N.Text:=Principale.Query1.Fields[2].AsString;
      Q.Value:=Principale.Query1.Fields[5].AsInteger;
      S.Text:=Source1.Items[Source1.ItemIndex];
   end;
end;

procedure TEditCitations.MenuItem1Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditCitations.MenuItem2Click(Sender: TObject);
var
  i:integer;
  found:boolean;
  temp:string;
begin
  found:=false;
  For i:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
     begin
     if Principale.DataHist.Cells[0,i]='R' then
        begin
        S.text:=copy(Principale.DataHist.Cells[1,i],1,AnsiPos('|',Principale.DataHist.Cells[1,i])-1);
        SEditingDone(Sender);
        temp:=copy(Principale.DataHist.Cells[1,i],AnsiPos('|',Principale.DataHist.Cells[1,i])+1,length(Principale.DataHist.Cells[1,i]));
        Memo.text:=copy(temp,1,AnsiPos('|',temp)-1);
        temp:=copy(temp,AnsiPos('|',temp)+1,length(temp));
        Q.value:=StrtoInt(copy(temp,1,length(temp)));
        Principale.DataHist.Row:=i+1;
        found:=true;
        break;
     end;
  end;
  if not found then
     begin
     For i:=0 to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,i]='R' then
           begin
           S.text:=copy(Principale.DataHist.Cells[1,i],1,AnsiPos('|',Principale.DataHist.Cells[1,i])-1);
           SEditingDone(Sender);
           temp:=copy(Principale.DataHist.Cells[1,i],AnsiPos('|',Principale.DataHist.Cells[1,i])+1,length(Principale.DataHist.Cells[1,i]));
           Memo.text:=copy(temp,1,AnsiPos('|',temp)-1);
           temp:=copy(temp,AnsiPos('|',temp)+1,length(temp));
           Q.value:=StrtoInt(copy(temp,1,length(temp)));
           Principale.DataHist.Row:=i+1;
           break;
        end;
     end;
  end;
end;

procedure TEditCitations.SEditingDone(Sender: TObject);
var
  i:integer;
begin
  if length(S.Text)>0 then
     if StrToInt(S.Text)>0 then
        begin
        for i:=0 to Source1.Items.Count-1 do
           if Source1.Items[i]=S.Text then
              Source.ItemIndex:=i;
        Source1.ItemIndex:=Source.ItemIndex;
     end;
end;

procedure TEditCitations.SourceEditingDone(Sender: TObject);
begin
   Source1.ItemIndex:=Source.ItemIndex;
   S.Text:=Source1.Items[Source1.ItemIndex];
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.Add('SELECT S.Q FROM S WHERE S.no='+Source1.Items[Source1.ItemIndex]);
   Principale.Query1.Open;
   Principale.Query1.First;
   Q.Value:=Principale.Query1.Fields[0].AsInteger;
end;

procedure TEditCitations.Button1Click(Sender: TObject);
begin
  Principale.Query1.SQL.Clear;
  if no.text<>'0' then
     Principale.Query1.SQL.Add('UPDATE C SET S='+Source1.Items[Source1.ItemIndex]+
        ', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Memo.Text,'\','\\'),'"','\"'),'''','\''')+
        ''', Q='+IntToStr(Q.Value)+' WHERE no='+no.text)
  else
     Principale.Query1.SQL.Add('INSERT INTO C (S, M, Q, Y, N) VALUES ( '+Source1.Items[Source1.ItemIndex]+
        ', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Memo.Text,'\','\\'),'"','\"'),'''','\''')+
        ''', '+IntToStr(Q.Value)+', '''+Code.Text+''', '''+N.Text+''' )');
  Principale.Query1.ExecSQL;
  // Sauvegarder les dates de modifications
  if Code.Text='R' then
     begin
     Principale.Query3.SQL.Clear;
     Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE R.no='+N.Text);
     Principale.Query3.Open;
     Principale.Query3.First;
     SaveModificationTime(Principale.Query3.Fields[0].AsString);
     SaveModificationTime(Principale.Query3.Fields[1].AsString);
  end;
  if Code.Text='N' then
     begin
     Principale.Query3.SQL.Clear;
     Principale.Query3.SQL.Add('SELECT N.I FROM N WHERE N.no='+N.Text);
     Principale.Query3.Open;
     Principale.Query3.First;
     SaveModificationTime(Principale.Query3.Fields[0].AsString);
  end;
  if Code.Text='E' then
     begin
     Principale.Query3.SQL.Clear;
     Principale.Query3.SQL.Add('SELECT W.I FROM W WHERE W.E='+N.Text);
     Principale.Query3.Open;
     Principale.Query3.First;
     while not Principale.Query3.eof do
        begin
        SaveModificationTime(Principale.Query3.Fields[0].AsString);
        Principale.Query3.Next;
     end;
  end;
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='R';
  Principale.DataHist.Cells[1,0]:=S.Text+'|'+Memo.Text+'|'+InttoStr(Q.Value);
end;

end.

