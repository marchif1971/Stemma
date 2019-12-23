unit Edit_Parents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Menus, FMUtils, StrUtils, Edit_Citations, LCLType, MaskEdit;

type

  { TEditParents }

  TEditParents = class(TForm)
    Ajouter1: TMenuItem;
    A: TMaskEdit;
    Button2: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    Modifier1: TMenuItem;
    X: TEdit;
    NomB: TEdit;
    NomA: TEdit;
    P1: TMemo;
    P2: TMemo;
    PopupMenu2: TPopupMenu;
    B: TMaskEdit;
    SD: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    M: TMemo;
    P: TMemo;
    SD2: TEdit;
    Supprimer1: TMenuItem;
    TableauCitations: TStringGrid;
    Y: TComboBox;
    Label1: TLabel;
    No: TEdit;
    Y2: TComboBox;
    procedure AEditingDone(Sender: TObject);
    procedure Ajouter1Click(Sender: TObject);
    procedure BEditingDone(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MEditingDone(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure P2DblClick(Sender: TObject);
    procedure PDblClick(Sender: TObject);
    procedure PEditingDone(Sender: TObject);
    procedure SDEditingDone(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure TableauCitationsDblClick(Sender: TObject);
    procedure YChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure ParentsSaveData;

var
  EditParents: TEditParents;

implementation

uses
  parents, enfants, unit1, noms, evenements;

{ TEditParents }

procedure TEditParents.FormShow(Sender: TObject);
var
  i:integer;
  code,nocode,type_cherche:string;
begin
  { TODO 20 : Lorsque l'on est dans A ou B, ESC ne fonctionne pas - By design Lazarus}
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[186]);
  GetFormPosition(Sender as TForm,0,0,438,625);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[166]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[187]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[171]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[172]);
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[189]);
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[173]);
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[174]);
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[188]);
  TableauCitations.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[138]);
  TableauCitations.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauCitations.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[228]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  Ajouter1.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier1.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer1.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  // Populate le ComboBox
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''R''');
  Principale.Query2.Open;
  Principale.Query2.First;
  Y.Items.Clear;
  Y2.Items.Clear;
  while not Principale.Query2.EOF do
     begin
     Y.Items.Add(Principale.Query2.Fields[1].AsString);
     Y2.Items.Add(Principale.Query2.Fields[0].AsString);
     Principale.Query2.Next;
  end;
  // Populate la form
  GetCode(code,nocode);
  if code='A' then
     begin
     TableauCitations.RowCount:=1;
     No.Text:='0';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+Principale.Individu.text);
     Principale.Query2.Open;
     Principale.Query2.First;
     X.Text:='0';
     GetCode(code,nocode);
     if Code='E' then
        begin
        if nocode='0' then
           EditParents.ActiveControl:=EditParents.A
        else
           EditParents.ActiveControl:=EditParents.Y;
        EditParents.Caption:=AnsitoUTF8(Principale.Traduction.Items[41]);
        B.Text:=Principale.Individu.text;
        NomB.Text:=DecodeName(Principale.Query2.Fields[0].AsString,1);
        A.Text:=nocode;
        A.EditingDone;
        type_cherche:='10';
     end
     else
     begin
        if nocode='0' then
           EditParents.ActiveControl:=EditParents.B
        else
           EditParents.ActiveControl:=EditParents.Y;
        EditParents.Caption:=AnsitoUTF8(Principale.Traduction.Items[42]);
        A.Text:=Principale.Individu.text;
        NomA.Text:=DecodeName(Principale.Query2.Fields[0].AsString,1);
        B.Text:=nocode;
        B.EditingDone;
        // Si la personne a déjà deux parents principaux sélectionne parents religieux, sinon parents naturels.
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT R.no FROM R WHERE R.X=1 AND R.A='+A.text);
        Principale.Query1.Open;
        Principale.Query1.First;
        If Principale.Query1.EOF then
           type_cherche:='10'
        else
           if (Principale.Query1.RecordCount=2) then
              type_cherche:='12'
        else
           type_cherche:='10';
     end;
     for i:=0 to Y2.Items.Count-1 do
        if Y2.Items[i]=type_cherche then
           Y.ItemIndex:=i;
     Y2.ItemIndex:=Y.ItemIndex;
     M.Text:='';
     P.Text:='';
     SD.Text:='';
     SD2.Text:=InterpreteDate('',1);;
  end
  else
     begin
     EditParents.ActiveControl:=EditParents.A;
     Principale.Query1.SQL.Clear;
     if code='P' then
        begin
        EditParents.ActiveControl:=EditParents.A;
        Principale.Query1.SQL.Add('SELECT R.no, R.Y, R.B, R.M, R.X, R.SD, R.P, N.N, R.A FROM R JOIN N on R.B=N.I WHERE N.X=1 AND R.no='+
                                   FormParents.TableauParents.Cells[0,FormParents.TableauParents.Row])
     end
     else
       begin
       EditParents.ActiveControl:=EditParents.B;
       Principale.Query1.SQL.Add('SELECT R.no, R.Y, R.B, R.M, R.X, R.SD, R.P, N.N, R.A FROM R JOIN N on R.B=N.I WHERE N.X=1 AND R.no='+
                                  FormEnfants.TableauEnfants.Cells[0,FormEnfants.TableauEnfants.Row]);
     end;
     Principale.Query1.Open;
     Principale.Query1.First;
     type_cherche:=Principale.Query1.Fields[1].AsString;
     if ((type_cherche='1079') or (type_cherche='1090')) then
        type_cherche:='10';
     if ((type_cherche='1085') or (type_cherche='1094')) then
        type_cherche:='12';
     for i:=0 to Y2.Items.Count-1 do
        if Y2.Items[i]=type_cherche then
           Y.ItemIndex:=i;
     Y2.ItemIndex:=Y.ItemIndex;
     No.Text:=Principale.Query1.Fields[0].AsString;
     X.Text:=Principale.Query1.Fields[4].AsString;
     A.Text:=Principale.Query1.Fields[8].AsString;
     B.Text:=Principale.Query1.Fields[2].AsString;
     NomB.Text:=DecodeName(Principale.Query1.Fields[7].AsString,1);
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+A.Text);
     Principale.Query2.Open;
     Principale.Query2.First;
     NomA.Text:=DecodeName(Principale.Query2.Fields[0].AsString,1);
     M.Text:=Principale.Query1.Fields[3].AsString;
     P.Text:=Principale.Query1.Fields[6].AsString;
     SD2.Text:=Principale.Query1.Fields[5].AsString;
     SD.Text:=ConvertDate(Principale.Query1.Fields[5].AsString,1);
     // Populate le tableau de citations
     PopulateCitations(TableauCitations,'R',No.Text);
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.no='+Y2.Items[Y2.ItemIndex]);
  Principale.Query2.Open;
  Principale.Query2.First;
  P1.Text:=Principale.Query2.Fields[2].AsString;
  if length(P.Text)=0 then
     begin
     P.Text:=P1.Text;
     Label6.Visible:=true;
  end;
  P2.Text:=DecodePhrase(A.Text,'ENFANT',P.Text,'R',No.Text);
  Button1.Enabled:=((StrToInt(A.Text)>0) and (StrToInt(B.Text)>0));
  TableauCitations.Enabled:=Button1.Enabled;
  MenuItem5.Enabled:=Button1.Enabled;
end;

procedure TEditParents.MEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='M';
  Principale.DataHist.Cells[1,0]:=M.Text;
end;

procedure TEditParents.MenuItem5Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditParents.MenuItem6Click(Sender: TObject); // repeat
var
  j:integer;
  found:boolean;
begin
  if EditParents.ActiveControl.Name='SD' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='SD' then
           begin
           SD.text:=Principale.DataHist.Cells[1,j];
           SDEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='SD' then
              begin
              SD.text:=Principale.DataHist.Cells[1,j];
              SDEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditParents.ActiveControl.Name='A' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='I' then
           begin
           A.text:=Principale.DataHist.Cells[1,j];
           AEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='A' then
              begin
              A.text:=Principale.DataHist.Cells[1,j];
              AEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditParents.ActiveControl.Name='P' then
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
  if EditParents.ActiveControl.Name='B' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='I' then
           begin
           B.text:=Principale.DataHist.Cells[1,j];
           BEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='B' then
              begin
              B.text:=Principale.DataHist.Cells[1,j];
              BEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditParents.ActiveControl.Name='M' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='M' then
           begin
           M.text:=Principale.DataHist.Cells[1,j];
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='M' then
              begin
              M.text:=Principale.DataHist.Cells[1,j];
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if found then Principale.DataHist.Row:=j+1;
end;

procedure TEditParents.BEditingDone(Sender: TObject);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+B.Text);
  Principale.Query1.Open;
  Principale.Query1.First;
  NomB.Text:=DecodeName(Principale.Query1.Fields[0].AsString,1);
  P2.Text:=DecodePhrase(A.Text,'ENFANT',P.Text,'R',No.Text);
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I.S FROM I WHERE I.no='+B.Text);
  Principale.Query1.Open;
  if Principale.Query1.eof then
     Button1.Enabled:=false
  else
     if Principale.Query1.Fields[0].AsString='?' then
        Button1.Enabled:=false
     else
        Button1.Enabled:=((StrToInt(A.Text)>0) and (StrToInt(B.Text)>0));
  TableauCitations.Enabled:=Button1.Enabled;
  MenuItem5.Enabled:=Button1.Enabled;
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='I';
  Principale.DataHist.Cells[1,0]:=B.Text;
end;

procedure TEditParents.AEditingDone(Sender: TObject);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+A.Text);
  Principale.Query1.Open;
  Principale.Query1.First;
  NomA.Text:=DecodeName(Principale.Query1.Fields[0].AsString,1);
  P2.Text:=DecodePhrase(A.Text,'ENFANT',P.Text,'R',No.Text);
  Button1.Enabled:=((StrToInt(A.Text)>0) and (StrToInt(B.Text)>0));
  TableauCitations.Enabled:=Button1.Enabled;
  MenuItem5.Enabled:=Button1.Enabled;
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='I';
  Principale.DataHist.Cells[1,0]:=A.Text;
end;

procedure TEditParents.Ajouter1Click(Sender: TObject);
begin
  If no.text='0' then
     ParentsSaveData;
  PutCode('R',no.text);
  PutCode('A',no.text);
  If EditCitations.Showmodal=mrOK then
     PopulateCitations(TableauCitations,'R',No.Text);
end;

procedure ParentsSaveData;
var
  temp, primaire, no_eve, dateev:string;
  parent1, parent2:string;
  existe:boolean;
begin
  temp:=EditParents.no.text;
  // Si l'enfant n'a pas de parent de ce sexe, mettre la relation primaire.
  primaire:='0';
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I.S FROM I WHERE I.no='+EditParents.B.Text);
  Principale.Query1.Open;
  If not Principale.Query1.EOF then
     begin
     temp:=Principale.Query1.Fields[0].AsString;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT R.no, R.B FROM R JOIN I ON R.B=I.no WHERE I.S='''+
                               temp+''' AND R.X=1 AND R.A='+EditParents.A.Text);
     Principale.Query1.Open;
     If Principale.Query1.EOF then
        primaire:='1';
  end;
  if (EditParents.X.Text='1') or ((EditParents.no.Text='0') and (primaire='1')) then
     begin
     if temp='F' then temp:='M' else temp:='F';
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT R.no, R.B, N.N FROM R JOIN I ON R.B=I.no JOIN N on N.I=R.B WHERE I.S='''+
                               temp+''' AND R.X=1 AND N.X=1 AND R.A='+EditParents.A.Text);
     Principale.Query1.Open;
     If not Principale.Query1.EOF then
        begin
        temp:=Principale.Query1.Fields[2].AsString;
        parent1:=EditParents.B.Text;
        parent2:=Principale.Query1.Fields[1].AsString;
        // Vérifier qu'il n'y a pas déjà une union entre ces deux parents
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT COUNT(E.no) FROM E JOIN W ON W.E=E.no JOIN Y on E.Y=Y.no WHERE (W.I='+
                                  parent1+' OR W.I='+parent2+') AND W.X=1 AND E.X=1 AND Y.Y=''M'' GROUP BY E.no');
        Principale.Query1.Open;
        existe:=false;
        while not Principale.Query1.EOF do
           begin
           existe:=existe or (Principale.Query1.Fields[0].AsInteger=2);
           Principale.Query1.Next;
        end;
        if not existe then
           if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[300])+
                 EditParents.nomB.Text+AnsitoUTF8(Principale.Traduction.Items[299])+
                 DecodeName(temp,1)+
                 AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
              begin
              // Unir les parents
              // Ajouter l'événement mariage
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('INSERT INTO E (Y, L, X) VALUES (300, 1, 1)');
              Principale.Query1.ExecSQL;
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
              Principale.Query1.Open;
              Principale.Query1.First;
              no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
              // Ajouter les témoins
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('INSERT INTO W (I, E, X, R) VALUES ('+
                 parent1+', '+no_eve+', 1, ''CONJOINT'')');
              Principale.Query1.ExecSQL;
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('INSERT INTO W (I, E, X, R) VALUES ('+
                 parent2+', '+no_eve+', 1, ''CONJOINT'')');
              Principale.Query1.ExecSQL;
              // Ajouter les références
              // noter que l'on doit ajouter les références (Principale.Code.Text='X')
              // sur l'événement # Principale.no.Text
              PutCode('P',no_eve);
              // Sauvegarder les modifications
              SaveModificationTime(parent1);
              SaveModificationTime(parent2);
              // UPDATE DÉCÈS si la date est il y a 100 ans !!!
              if (copy(EditParents.SD2.text,1,1)='1') and not (EditParents.SD2.text='100000000030000000000') then
                 dateev:=Copy(EditParents.SD2.text,2,4)
              else
                 dateev:=FormatDateTime('YYYY',now);
              if ((StrtoInt(FormatDateTime('YYYY',now))-StrtoInt(dateev))>100) then
                 begin
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+parent1);
                 Principale.Query2.ExecSQL;
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+parent2);
                 Principale.Query2.ExecSQL;
                 If (Principale.MenuItem8.Checked) then
                    PopulateNom;
              end;
              If (Principale.MenuItem9.Checked) then
                 PopulateEvenements;
           end;
     end;
  end;
  Principale.Query1.SQL.Clear;
  if EditParents.no.Text='0' then
     begin
     If EditParents.Label6.Visible then
        Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, M, SD, P, X) VALUES ('+EditParents.Y2.Items[EditParents.Y2.ItemIndex]+
          ', '+EditParents.A.Text+', '+EditParents.B.Text+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditParents.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''', '+primaire+')')
     else
       Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, M, SD, P, X) VALUES ('+EditParents.Y2.Items[EditParents.Y2.ItemIndex]+
         ', '+EditParents.A.Text+', '+EditParents.B.Text+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.M.Text),'\','\\'),'"','\"'),'''','\''')+
         ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditParents.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
         ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.P.Text),'\','\\'),'"','\"'),'''','\''')+
         ''', '+primaire+')')
     end
  else
     begin
     If EditParents.Label6.Visible then
        Principale.Query1.SQL.Add('UPDATE R SET Y='+EditParents.Y2.Items[EditParents.Y2.ItemIndex]+
          ', A='+EditParents.A.Text+', B='+EditParents.B.Text+', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', SD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditParents.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', P='''' WHERE no='+EditParents.no.text)
     else
       Principale.Query1.SQL.Add('UPDATE R SET Y='+EditParents.Y2.Items[EditParents.Y2.ItemIndex]+
         ', B='+EditParents.B.Text+', A='+EditParents.A.Text+', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.M.Text),'\','\\'),'"','\"'),'''','\''')+
         ''', SD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditParents.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
         ''', P='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditParents.P.Text),'\','\\'),'"','\"'),'''','\''')+
         ''' WHERE no='+EditParents.no.text);
  end;
  Principale.Query1.ExecSQL;
  if EditParents.no.text='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query1.Open;
     Principale.Query1.First;
     EditParents.no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  // Sauvegarder les modifications
  if StrtoInt(EditParents.A.Text)>0 then SaveModificationTime(EditParents.A.Text);
  if StrtoInt(EditParents.B.Text)>0 then SaveModificationTime(EditParents.B.Text);
  // UPDATE DÉCÈS si la date est il y a 100 ans !!!
  if (copy(EditParents.SD2.text,1,1)='1') and not (EditParents.SD2.text='100000000030000000000') then
     dateev:=Copy(EditParents.SD2.text,2,4)
  else
     dateev:=FormatDateTime('YYYY',now);
  if ((StrtoInt(FormatDateTime('YYYY',now))-StrtoInt(dateev))>100) then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+EditParents.A.Text);
     Principale.Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+EditParents.B.Text);
     Principale.Query2.ExecSQL;
     If (Principale.MenuItem8.Checked) then
        PopulateNom;
  end;
end;

procedure TEditParents.Button1Click(Sender: TObject);
var
  code,nocode:string;
begin
  ParentsSaveData;
  // Donc déplacer ce bloc à la fin de Button1 et
  // exécuter seulement si c'est vraiment une sortie par Button1 ou F10
  GetCode(code,nocode);
  if code='P' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''R'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        begin
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''E'', '+
           nocode+', '+Principale.Query1.Fields[0].AsString+', '+
           Principale.Query1.Fields[1].AsString+', '''+
           Principale.Query1.Fields[2].AsString+''')');
        Principale.Query2.ExecSQL;
        Principale.Query1.Next;
     end;
  end;
end;

procedure TEditParents.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
    SaveFormPosition(Sender as TForm);
end;

procedure TEditParents.P2DblClick(Sender: TObject);
begin
  P.Visible:=true;
  P2.Visible:=false;
end;

procedure TEditParents.PDblClick(Sender: TObject);
begin
  P2.Visible:=true;
  P.Visible:=false;
end;

procedure TEditParents.PEditingDone(Sender: TObject);
begin
  If length(P.Text)=0 then
     P.Text:=P1.Text;
  Label6.Visible:=(P.Text=P1.Text);
  P2.Text:=DecodePhrase(A.Text,'ENFANT',P.Text,'R',No.Text);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='P';
  Principale.DataHist.Cells[1,0]:=P.Text;
end;

procedure TEditParents.SDEditingDone(Sender: TObject);
begin
  SD2.Text:=InterpreteDate(SD.Text,1);
  SD.Text:=convertDate(SD2.Text,1);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='SD';
  Principale.DataHist.Cells[1,0]:=SD.Text;
end;

procedure TEditParents.Supprimer1Click(Sender: TObject);
begin
  If TableauCitations.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[31])+
        TableauCitations.Cells[1,TableauCitations.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM C WHERE no='+TableauCitations.Cells[0,TableauCitations.Row]);
        Principale.Query1.ExecSQL;
        TableauCitations.DeleteRow(TableauCitations.Row);
        // Sauvegarder les modifications
        if StrtoInt(A.Text)>0 then SaveModificationTime(A.Text);
        if StrtoInt(B.Text)>0 then SaveModificationTime(B.Text);
     end;
end;

procedure TEditParents.TableauCitationsDblClick(Sender: TObject);
begin
  if TableauCitations.Row>0 then
     begin
     PutCode('R',TableauCitations.Cells[0,TableauCitations.Row]);
     If EditCitations.Showmodal=mrOK then
        PopulateCitations(TableauCitations,'R',No.Text);
  end;
end;

procedure TEditParents.YChange(Sender: TObject);
begin
  Y2.ItemIndex:=Y.ItemIndex;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT Y.P FROM Y WHERE Y.no='+Y2.Items[Y2.ItemIndex]);
  Principale.Query1.Open;
  Principale.Query1.First;
  P1.Text:=Principale.Query1.Fields[0].AsString;
  If Label6.Visible Then
     begin
     P.Text:=Principale.Query1.Fields[0].AsString;
     P2.Text:=DecodePhrase(A.Text,'ENFANT',P.Text,'R',No.Text);
  end
  else
     Label6.Visible:=(P.Text=P1.Text);
end;

{$R *.lfm}

{ TEditParents }

end.

