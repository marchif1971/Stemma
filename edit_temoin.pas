unit Edit_Temoin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, FMUtils, StrUtils;

type

  { TEditTemoin }

  TEditTemoin = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    X: TEdit;
    I: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    No: TEdit;
    E: TEdit;
    NomI: TEdit;
    P: TMemo;
    P1: TMemo;
    P2: TMemo;
    Role: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IEditingDone(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PEditingDone(Sender: TObject);
    procedure RoleChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  EditTemoin: TEditTemoin;

implementation

uses Edit_Evenements, unit1, explorateur;

{$R *.lfm}

{ TEditTemoin }

procedure TEditTemoin.PEditingDone(Sender: TObject);
begin
  If length(P.Text)=0 then
     P.Text:=P1.Text;
  Label6.Visible:=(P.Text=P1.Text);
  P2.Text:=DecodePhrase(I.Text,Role.Items[Role.ItemIndex],P.Text,'E',E.Text);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='P';
  Principale.DataHist.Cells[1,0]:=P.Text;
end;

procedure TEditTemoin.RoleChange(Sender: TObject);
begin
  P2.Text:=DecodePhrase(I.Text,Role.Text,P.Text,'E',E.Text);
end;

procedure TEditTemoin.FormShow(Sender: TObject);
var
   j:integer;
   temp, code, nocode:string;
begin
  EditTemoin.ActiveControl:=EditTemoin.I;
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[195]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[196]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[197]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[172]);
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[198]);
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[173]);
  // Populate le ComboBox
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT Y.R FROM Y WHERE Y.no='+
                             EditEvenement.Y2.Items[EditEvenement.Y2.ItemIndex]);
  Principale.Query1.Open;
  Principale.Query1.First;
  Role.Items.Clear;
  temp:=Principale.Query1.Fields[0].AsString;
  while AnsiPos('|',temp)>0 do
     begin
     Role.Items.Add(Copy(temp,1,AnsiPos('|',temp)-1));
     temp:=Copy(temp,AnsiPos('|',temp)+1,length(temp));
  end;
  Role.Items.Add(Copy(temp,1,length(temp)));
  // Populate la form
  GetCode(code,nocode);
  if Code='A' then
     begin
     EditTemoin.Caption:=AnsitoUTF8(Principale.Traduction.Items[48]);
     I.text:='';
     NomI.Text:='';
     No.text:='0';
     E.Text:=nocode;
     X.Text:='1';
     Role.ItemIndex:=0;
     P.Text:='';
     label6.Visible:=true;
  end
  else
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT W.no, W.I, W.E, W.X, W.P, W.R, N.N FROM W JOIN N ON W.I=N.I WHERE N.X=1 AND W.no='+
                                EditEvenement.TableauTemoins.Cells[0,EditEvenement.TableauTemoins.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     for j:=0 to Role.Items.Count-1 do
        if Role.Items[j]=Principale.Query1.Fields[5].AsString then
           Role.ItemIndex:=j;
     No.Text:=Principale.Query1.Fields[0].AsString;
     I.Text:=Principale.Query1.Fields[1].AsString;
     X.Text:=Principale.Query1.Fields[3].AsString;
     E.Text:=Principale.Query1.Fields[2].AsString;
     NomI.Text:=DecodeName(Principale.Query1.Fields[6].AsString,1);
     P.Text:=Principale.Query1.Fields[4].AsString;
  end;
  // aller chercher la phrase par défaut
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT Y.P FROM Y JOIN E ON E.Y=Y.no WHERE E.no='+E.Text);
  Principale.Query1.Open;
  Principale.Query1.First;
  P1.Text:=Principale.Query1.Fields[0].AsString;
  if length(P.text)=0 then
     begin
     P.Text:=P1.Text;
     label6.Visible:=true;
  end;
  P2.Text:=DecodePhrase(I.Text,Role.Text,P.Text,'E',E.Text);
end;

procedure TEditTemoin.Button1Click(Sender: TObject);
var
   reorder:boolean;
   j:integer;
   principal:string;
begin
  Principale.Query1.SQL.Clear;
  if no.text='0' then
     begin
     if Role.ItemIndex>0 then
        principal:='0'
     else
        principal:='1';
     If Label6.Visible then
        Principale.Query1.SQL.Add('INSERT INTO W (R, I, P, E, X) VALUES ('''+Role.Items[Role.ItemIndex]+
          ''', '+I.Text+', '''', '+E.Text+', '+principal+')')
     else
        Principale.Query1.SQL.Add('INSERT INTO W (R, I, P, E, X) VALUES ('''+Role.Items[Role.ItemIndex]+
          ''', '+I.Text+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(P.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '+E.Text+', '+principal+')')
  end
  else
     begin
     If Label6.Visible then
        Principale.Query1.SQL.Add('UPDATE W SET R='''+Role.Items[Role.ItemIndex]+
          ''', I='+I.Text+', P='''' WHERE no='+no.text)
     else
        Principale.Query1.SQL.Add('UPDATE W SET R='''+Role.Items[Role.ItemIndex]+
          ''', I='+I.Text+', P='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(P.Text),'\','\\'),'"','\"'),'''','\''')+
          ''' WHERE no='+no.text);
  end;
  Principale.Query1.ExecSQL;
  if no.text='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''W''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  // Sauvegarder les modifications pour tout les témoins de l'événements
  Principale.Query3.SQL.Clear;
  Principale.Query3.SQL.Add('SELECT W.I FROM W WHERE W.E='+E.Text);
  Principale.Query3.Open;
  Principale.Query3.First;
  While not Principale.Query3.EOF do
     begin
     SaveModificationTime(Principale.Query3.Fields[0].AsString);
     Principale.Query3.Next;
  end;
  // Modifier la ligne de l'explorateur si naissance principale ou décès principal
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT Y.Y, E.X, E.PD FROM Y JOIN E on E.Y=Y.no WHERE E.no='+E.Text);
  Principale.Query1.Open;
  if Principale.MenuItem13.Checked and
     ((Principale.Query1.Fields[0].AsString='B') or ((Principale.Query1.Fields[0].AsString='D'))) and
     (Principale.Query1.Fields[1].AsInteger=1) and (X.Text='1') then
     begin
     reorder:=false;
     for j:=1 to FormExplorateur.Index.RowCount-1 do
        if FormExplorateur.Index.Cells[0,j]=I.text then
           begin
           if (Principale.Query1.Fields[0].AsString='B') then
              begin
              FormExplorateur.Index.Cells[3,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
              if (FormExplorateur.O.text='3') then
                 begin
                 FormExplorateur.Index.Cells[6,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                 // UPDATE N.I3!!!
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE N SET I3='''+Principale.Query1.Fields[2].AsString+
                     ''' WHERE N.I=I.Text');
                 Principale.Query2.ExecSQL;
                 reorder:=true;
              end;
           end;
           if (Principale.Query1.Fields[0].AsString='D') then
              begin
              FormExplorateur.Index.Cells[4,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
              if (FormExplorateur.O.text='4') then
                 begin
                 FormExplorateur.Index.Cells[6,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                 // UPDATE N.I4!!!
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE N SET I4='''+Principale.Query1.Fields[2].AsString+
                    ''' WHERE N.I=I.Text');
                 Principale.Query2.ExecSQL;
                 reorder:=true;
              end;
           end;
        end;
     if reorder then
        begin
        FormExplorateur.Index.SortColRow(true,6);
        TrouveIndividu;
     end;
  end;
end;

procedure TEditTemoin.IEditingDone(Sender: TObject);
begin
  if length(I.Text)>0 then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+I.Text);
     Principale.Query1.Open;
     Principale.Query1.First;
     if not Principale.Query1.Eof then
        begin
        NomI.Text:=DecodeName(Principale.Query1.Fields[0].AsString,1);
        P2.Text:=DecodePhrase(I.Text,Role.Text,P.Text,'E',E.Text);
        Principale.DataHist.InsertColRow(false,0);
        Principale.DataHist.Cells[0,0]:='I';
        Principale.DataHist.Cells[1,0]:=I.Text;
     end;
  end;
end;

procedure TEditTemoin.MenuItem1Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditTemoin.MenuItem2Click(Sender: TObject);
var
  j:integer;
  found:boolean;
begin
  if EditTemoin.ActiveControl.Name='P' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='P' then
           begin
           P.text:=Principale.DataHist.Cells[1,j];
           PEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='P' then
              begin
              P.text:=Principale.DataHist.Cells[1,j];
              PEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditTemoin.ActiveControl.Name='I' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='I' then
           begin
           I.text:=Principale.DataHist.Cells[1,j];
           IEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='I' then
              begin
              I.text:=Principale.DataHist.Cells[1,j];
              IEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if found then Principale.DataHist.Row:=j+1;
end;



end.

