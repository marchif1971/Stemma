unit Edit_Evenements;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Menus, FMUtils, StrUtils, LCLType, IniFiles, Process;

type

  { TEditEvenement }

  TEditEvenement = class(TForm)
    Ajouter1: TMenuItem;
    Ajouter2: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    L3: TEdit;
    L4: TEdit;
    L0: TEdit;
    LA: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    M: TMemo;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    BackRepeat: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Modifier2: TMenuItem;
    ModifierTemoin: TMenuItem;
    AjouterTemoin: TMenuItem;
    Modifier1: TMenuItem;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Supprimer2: TMenuItem;
    SupprimerTemoin: TMenuItem;
    No: TEdit;
    L1: TEdit;
    L2: TEdit;
    PopupMenu1: TPopupMenu;
    Role: TEdit;
    P2: TMemo;
    PD: TEdit;
    PD2: TEdit;
    Supprimer1: TMenuItem;
    TableauExhibits: TStringGrid;
    TableauTemoins: TStringGrid;
    X: TEdit;
    SD: TEdit;
    SD2: TEdit;
    TableauCitations: TStringGrid;
    YY: TEdit;
    Y: TComboBox;
    Y2: TComboBox;
    procedure Ajouter1Click(Sender: TObject);
    procedure Ajouter2Click(Sender: TObject);
    procedure AjouterTemoinClick(Sender: TObject);
    procedure BackRepeatClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MEditingDone(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure Modifier2Click(Sender: TObject);
    procedure PDEditingDone(Sender: TObject);
    procedure SDEditingDone(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Supprimer2Click(Sender: TObject);
    procedure SupprimerTemoinClick(Sender: TObject);
    procedure TableauCitationsDblClick(Sender: TObject);
    procedure TableauTemoinsDblClick(Sender: TObject);
    procedure TableauTemoinsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure YChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

function PopulateTemoins(Event:string):string;

var
  EditEvenement: TEditEvenement;

implementation

uses
  evenements, unit1, explorateur, edit_citations, edit_temoin, exhibits, Show_Image,
  noms, edit_exhibits;

{$R *.lfm}

{ TEditEvenement }

procedure TEditEvenement.TableauCitationsDblClick(Sender: TObject);
begin
  if TableauCitations.Row>0 then
     begin
     PutCode('E',TableauCitations.Cells[0,TableauCitations.Row]);
     If EditCitations.Showmodal=mrOK then
        PopulateCitations(TableauCitations,'E',No.Text);
  end;
end;

procedure TEditEvenement.TableauTemoinsDblClick(Sender: TObject);
begin
  if TableauTemoins.Row>0 then
     begin
     // Enregistrer le témoin par défaut si no.text='0'
     if no.text='0' then
        Button1Click(Sender);
     If EditTemoin.Showmodal=mrOK then
        PopulateTemoins(no.text);
  end;
end;

procedure TEditEvenement.TableauTemoinsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if aCol=0 then
     begin
     (Sender as TStringGrid).Canvas.Font.Color := (Sender as TStringGrid).Canvas.Brush.Color;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
  if (((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol>0)) then
     begin
//     if (Sender as TStringGrid).Row=aRow then
//        (Sender as TStringGrid).Canvas.Brush.Color := clBlue
//     else
//        (Sender as TStringGrid).Canvas.Brush.Color := clYellow;
//     (Sender as TStringGrid).Canvas.FillRect(aRect);
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TEditEvenement.YChange(Sender: TObject);
var
  roledefaut, remplacerole, roles, phrase:string;
  j:integer;
begin
  Y2.ItemIndex:=Y.ItemIndex;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT Y.P, Y.R FROM Y WHERE Y.no='+Y2.Items[Y2.ItemIndex]);
  Principale.Query1.Open;
  Principale.Query1.First;
  phrase:=Principale.Query1.Fields[0].AsString;
  roles:=Principale.Query1.Fields[1].AsString;
  if AnsiPos('|',Roles)>0 then
     RoleDefaut:=Copy(Roles,1,AnsiPos('|',Roles)-1)
  else
     RoleDefaut:=Roles;
  RemplaceRole:=RoleDefaut;
  for j:=1 to TableauTemoins.Rowcount-1 do
     begin
     if AnsiPos(TableauTemoins.Cells[2,j],Roles)<1 then
        begin
//        if TableauTemoins.Cells[3,j]=Principale.Individu.Text then
        RemplaceRole:=TableauTemoins.Cells[2,j];
           if TableauTemoins.Cells[2,j]<>'WITNESS' then
              RemplaceRole:=RoleDefaut
           else
              RemplaceRole:='TEMOIN';
        TableauTemoins.Cells[2,j]:=RemplaceRole;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE W SET P='''', R='''+RemplaceRole+''' WHERE W.no='+TableauTemoins.Cells[0,j]);
        Principale.Query1.ExecSQL;
        SaveModificationTime(TableauTemoins.Cells[3,j]);
     end;
  end;
  If Label6.Visible Then
     P2.Text:=DecodePhrase(Principale.Individu.Caption,Role.Text,phrase,'E',No.Text);
end;

procedure TEditEvenement.PDEditingDone(Sender: TObject);
var
  j,k:integer;
  trouve:boolean;
begin
  PD2.Text:=InterpreteDate(PD.Text,1);
  PD.Text:=ConvertDate(PD2.Text,1);
  SD.Text:=PD.Text;
  if PD2.Text<>'100000000030000000000' then
     begin
     // On doit vérifier avant d'insérer si le Memo existe déjà, si oui, déplace au début
     trouve:=false;
     for j:=0 to Principale.DataHist.RowCount-1 do
        begin
        if (Principale.DataHist.Cells[0,j]='PD') and
           (Principale.DataHist.Cells[1,j]=PD2.Text) then
           begin
           trouve:=true;
           for k:=j downto 1 do
              begin
              Principale.DataHist.Cells[0,k]:=Principale.DataHist.Cells[0,k-1];
              Principale.DataHist.Cells[1,k]:=Principale.DataHist.Cells[1,k-1];
           end;
           break;
        end;
     end;
     if not trouve then
        Principale.DataHist.InsertColRow(false,0);
     SD2.Text:=PD2.Text;
     Principale.DataHist.Cells[0,0]:='PD';
     Principale.DataHist.Cells[1,0]:=PD2.Text;
  end;
    Principale.DataHist.Row:=0;
end;

procedure TEditEvenement.FormShow(Sender: TObject);
var
  j,pos1,pos2,sexe:integer;
  Lieu,phrase,code,nocode,type_cherche:string;
  call_ychange:boolean;
begin
  call_ychange:=false;
  GetFormPosition(Sender as TForm,0,0,698,630);
  EditEvenement.ActiveControl:=EditEvenement.PD;
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[165]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[166]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[171]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[172]);
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[144]);
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[173]);
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[174]);
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[170]);
  Label9.Caption:=AnsitoUTF8(Principale.Traduction.Items[168]);
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[169]);
  Label11.Caption:=AnsitoUTF8(Principale.Traduction.Items[167]);
  Label12.Caption:=AnsitoUTF8(Principale.Traduction.Items[298]);
  TableauTemoins.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[175]);
  TableauTemoins.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[176]);
  TableauCitations.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[138]);
  TableauCitations.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauCitations.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  TableauExhibits.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauExhibits.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[201]);
  Ajouter1.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier1.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer1.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  Ajouter2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier2.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer2.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  AjouterTemoin.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  ModifierTemoin.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  SupprimerTemoin.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[227]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[228]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem10.Caption:=AnsitoUTF8(Principale.Traduction.Items[181]);
  MenuItem14.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.add('SELECT S, V, I, date, no FROM I WHERE no='+Principale.Individu.Caption);
  Principale.Query2.Open;
  If Principale.Query2.Fields[0].AsString='F' then
     sexe:=1
  else
     sexe:=0;
  // Populate le ComboBox
  Principale.Query2.SQL.Clear;
  GetCode(code,nocode);
  if code='A' then // si Ajout d'évènement
     begin
     if nocode='0' then // divers
        Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''B'' OR Y.Y=''D'' OR Y.Y=''M'' OR Y.Y=''X'' OR Y.Y=''Z'' ORDER BY Y.T');
     if (nocode='B') or (nocode='N') then // Naissance ou baptême
        Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''B'' ORDER BY Y.T');
     if (nocode='D') or (nocode='S') then // Décès ou sépulture
        Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''D'' ORDER BY Y.T');
     if (copy(nocode,1,1)='O') or (copy(nocode,1,1)='R') then // Occupation(511) ou religion(560)
        Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''X'' ORDER BY Y.T');
  end
  else // si édition d'évènement
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT Y.Y FROM E JOIN Y ON Y.no=E.Y WHERE E.no='+
                                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y='''+
        Principale.Query1.Fields[0].AsString+''' ORDER BY Y.T');
  end;
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
  if code='A' then
     begin
     EditEvenement.Caption:=AnsitoUTF8(Principale.Traduction.Items[30]);
     TableauTemoins.RowCount:=2;
     TableauTemoins.Cells[0,1]:='0';
     if nocode='0' then
        begin
        Y.ItemIndex:=0;
        Y2.ItemIndex:=0;
        X.Text:='0';
     end;
     if copy(nocode,1,1)='O' then // Occupation (511)
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='511' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        X.Text:='0';
     end;
     if copy(nocode,1,1)='R' then // Occupation (560)
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='560' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        X.Text:='0';
     end;
     if nocode='N' then
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='100' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE Y.Y=''B'' AND E.X=1 AND W.X=1 AND W.I='+
           Principale.Individu.Caption);
        Principale.Query1.Open;
        if Principale.Query1.Eof then
           X.Text:='1'
        else
           X.Text:='0';
     end;
     if nocode='B' then
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='110' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE Y.Y=''B'' AND E.X=1 AND W.X=1 AND W.I='+
           Principale.Individu.Caption);
        Principale.Query1.Open;
        if Principale.Query1.Eof then
           X.Text:='1'
        else
           X.Text:='0';
     end;
     if nocode='D' then
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='200' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE Y.Y=''D'' AND E.X=1 AND W.X=1 AND W.I='+
           Principale.Individu.Caption);
        Principale.Query1.Open;
        if Principale.Query1.Eof then
           X.Text:='1'
        else
           X.Text:='0';
     end;
     if nocode='S' then
        begin
        // Mettre le bon Y.ItemIndex
        // Trouver si ce doit être un primaire ou non
        for j:=0 to Y2.Items.Count-1 do
           if Y2.Items[j]='210' then
              Y.ItemIndex:=j;
        Y2.ItemIndex:=Y.ItemIndex;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE Y.Y=''D'' AND E.X=1 AND W.X=1 AND W.I='+
           Principale.Individu.Caption);
        Principale.Query1.Open;
        if Principale.Query1.Eof then
           X.Text:='1'
        else
           X.Text:='0';
     end;
     // Trouver le type de témoin par défaut
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT Y.R FROM Y WHERE Y.no='+Y2.Items[Y2.ItemIndex]);
     Principale.Query1.Open;
     Principale.Query1.First;
     if AnsiPos('|',Principale.Query1.Fields[0].AsString)>0 then
        TableauTemoins.Cells[2,1]:=Copy(Principale.Query1.Fields[0].AsString,1,AnsiPos('|',Principale.Query1.Fields[0].AsString)-1)
     else
        TableauTemoins.Cells[2,1]:=Principale.Query1.Fields[0].AsString;
     TableauTemoins.Cells[3,1]:=Principale.Individu.Text;
     TableauTemoins.Cells[4,1]:=GetName(Principale.Individu.Text);
     TableauTemoins.Cells[1,1]:='*';
     M.Text:='';
     PD.Text:='';
     if copy(nocode,1,1)='O' then // Occupation (511)
        begin
        if copy(nocode,2,1)='E' then // Écolier
           if sexe=0 then
              M.Text:='écolier'
           else
              M.Text:='écolière';
        if copy(nocode,2,1)='C' then // Cultivateur
           if sexe=0 then
              M.Text:='cultivateur'
           else
              M.Text:='cultivatrice';
        if copy(nocode,2,1)='J' then // Journalier
           if sexe=0 then
              M.Text:='journalier'
           else
              M.Text:='journalière';
        PD.Text:=copy(nocode,3,4);
     end;
     if copy(nocode,1,1)='R' then // Religion (560)
        begin
        if copy(nocode,2,1)='P' then // Presbytérienne
           M.Text:='presbytérienne';
        if copy(nocode,2,1)='A' then // Anglicane
           M.Text:='anglicane';
        if copy(nocode,2,1)='B' then // Baptiste
           M.Text:='baptiste';
        if copy(nocode,2,1)='M' then // Métohdiste
           M.Text:='méthodiste';
        if copy(nocode,2,1)='R' then //
           M.Text:='protestante';
     end;
     SD.Text:=PD.Text;
     PD2.Text:=PD.Text;
     SD2.Text:=PD.Text;
     P2.Text:='';
     No.Text:='0';
     Role.Text:=TableauTemoins.Cells[1,1];
     LA.Text:='';
     L0.Text:='';
     L1.Text:='';
     L2.Text:='';
     L3.Text:='';
     L4.Text:='';
     YY.Text:='';
     Label6.Visible:=true;
  end
  else
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT E.no, E.Y, E.L, E.M, E.X, E.PD, E.SD, L.L FROM E JOIN L ON L.no=E.L WHERE E.no='+
                                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     type_cherche:=Principale.Query1.Fields[1].AsString;
     if (type_cherche='1089') then
        begin
        type_cherche:='650';
        call_ychange:=true;
     end;
     if (type_cherche='1012') then
        begin
        type_cherche:='110';
        call_ychange:=true;
     end;
     if (type_cherche='1003') then
        begin
        type_cherche:='200';
        call_ychange:=true;
     end;
     if (type_cherche='1006') then
        begin
        type_cherche:='210';
        call_ychange:=true;
     end;
     if (type_cherche='1004') then
        begin
        type_cherche:='300';
        call_ychange:=true;
     end;
     if (type_cherche='1002') then
        begin
        type_cherche:='100';
        call_ychange:=true;
     end;
     if (type_cherche='1066') then
        begin
        type_cherche:='511';
        call_ychange:=true;
     end;
     if (type_cherche='1010') then
        begin
        type_cherche:='550';
        call_ychange:=true;
     end;
     for j:=0 to Y2.Items.Count-1 do
        if Y2.Items[j]=type_cherche then
           Y.ItemIndex:=j;
     Y2.ItemIndex:=Y.ItemIndex;
     No.Text:=Principale.Query1.Fields[0].AsString;
     X.Text:=Principale.Query1.Fields[4].AsString;
     M.Text:=Principale.Query1.Fields[3].AsString;
     // Aller chercher L0-L4 de L
     Lieu:=Principale.Query1.Fields[7].AsString;
     if Copy(Lieu,1,4)='!TMG' then
        begin
        Lieu:=Copy(Lieu,AnsiPos('|',Lieu)+1,Length(Lieu));
        L0.Text:=Copy(Lieu,1,AnsiPos('|',Lieu)-1);
        Lieu:=Copy(Lieu,AnsiPos('|',Lieu)+1,Length(Lieu));
        L1.Text:=Copy(Lieu,1,AnsiPos('|',Lieu)-1);
        Lieu:=Copy(Lieu,AnsiPos('|',Lieu)+1,Length(Lieu));
        L2.Text:=Copy(Lieu,1,AnsiPos('|',Lieu)-1);
        Lieu:=Copy(Lieu,AnsiPos('|',Lieu)+1,Length(Lieu));
        L3.Text:=Copy(Lieu,1,AnsiPos('|',Lieu)-1);
        Lieu:=Copy(Lieu,AnsiPos('|',Lieu)+1,Length(Lieu));
        L4.Text:=Copy(Lieu,1,AnsiPos('|',Lieu)-1);
        LA.Text:='';
     end
     else
        begin
        Pos1:=AnsiPos('<Article>',Lieu)+9;
        Pos2:=AnsiPos('</Article>',Lieu);
        if (Pos1+Pos2)>9 then
           LA.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           LA.Text:='';
        Pos1:=AnsiPos('<Détail>',Lieu)+9;
        Pos2:=AnsiPos('</Détail>',Lieu);
        if (Pos1+Pos2)>9 then
           L0.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           L0.Text:='';
        Pos1:=AnsiPos('<Ville>',Lieu)+7;
        Pos2:=AnsiPos('</Ville>',Lieu);
        if (Pos1+Pos2)>7 then
           L1.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           L1.Text:='';
        Pos1:=AnsiPos('<Région>',Lieu)+9;
        Pos2:=AnsiPos('</Région>',Lieu);
        if (Pos1+Pos2)>9 then
           L2.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           L2.Text:='';
        Pos1:=AnsiPos('<Province>',Lieu)+10;
        Pos2:=AnsiPos('</Province>',Lieu);
        if (Pos1+Pos2)>10 then
           L3.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           L3.Text:='';
        Pos1:=AnsiPos('<Pays>',Lieu)+6;
        Pos2:=AnsiPos('</Pays>',Lieu);
        if (Pos1+Pos2)>6 then
           L4.Text:=Copy(Lieu,Pos1,Pos2-Pos1)
        else
           L4.Text:='';
     end;
     PD2.Text:=Principale.Query1.Fields[5].AsString;
     PD.Text:=ConvertDate(Principale.Query1.Fields[5].AsString,1);
     SD2.Text:=Principale.Query1.Fields[6].AsString;
     SD.Text:=ConvertDate(Principale.Query1.Fields[6].AsString,1);
     // Aller chercher P, Role et témoins de W
     phrase:=PopulateTemoins(no.Text);
     if call_ychange then // On a changer d'un vieux type à nouveau type
        begin
        YChange(sender);
        // ajout d'un "à" si il y a un lieu
        If ((LA.Text = '') and ((length(L0.Text)>0) or (length(L1.Text)>0) or
            (length(L2.Text)>0) or (length(L3.Text)>0) or (length(L4.Text)>0))) then
           begin
           LA.Text := 'à';
        end;
     end;
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.no='+Y2.Items[Y2.ItemIndex]);
  Principale.Query2.Open;
  Principale.Query2.First;
  if length(phrase)=0 then
     begin
     Label6.Visible:=true;
     phrase:=Principale.Query2.Fields[2].AsString;
  end;
  P2.Text:=DecodePhrase(Principale.Individu.Caption,Role.Text,Phrase,'E',No.Text);
  // Populate le tableau de citations
  if no.text='0' then
     TableauCitations.RowCount:=1
  else
     PopulateCitations(TableauCitations,'E',No.Text);
  // Populate le tableau de documents
  if no.text='0' then
     TableauExhibits.RowCount:=1
  else
     PopulateExhibits(TableauExhibits,'E',No.Text);
end;

procedure TEditEvenement.MEditingDone(Sender: TObject);
var
  j,k:integer;
  trouve:boolean;
  memo:string;
begin
  memo:=trim(M.Text);
  If Length(memo)>0 then
     begin
     // On doit vérifier avant d'insérer si le Memo existe déjà, si oui, déplace au début
     trouve:=false;
     for j:=0 to Principale.DataHist.RowCount-1 do
        begin
        if (Principale.DataHist.Cells[0,j]='M') and
           (Principale.DataHist.Cells[1,j]=M.Text) then
           begin
           trouve:=true;
           for k:=j downto 1 do
              begin
              Principale.DataHist.Cells[0,k]:=Principale.DataHist.Cells[0,k-1];
              Principale.DataHist.Cells[1,k]:=Principale.DataHist.Cells[1,k-1];
           end;
           break;
        end;
     end;
     if not trouve then
        Principale.DataHist.InsertColRow(false,0);
     Principale.DataHist.Cells[0,0]:='M';
     Principale.DataHist.Cells[1,0]:=M.Text;
  end;
end;

procedure TEditEvenement.MenuItem10Click(Sender: TObject);
var
  ini:TIniFile;
  pdf:string;
begin
  // Visualiser un exhibits
  if TableauExhibits.Row>0 then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT X.Z, X.F FROM X WHERE X.no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
     Principale.Query2.Open;
     if TableauExhibits.Cells[4,TableauExhibits.Row]=AnsitoUTF8(Principale.Traduction.Items[34]) then
        begin
        ShowImage.Caption:=AnsitoUTF8(Principale.Traduction.Items[34]);
        ShowImage.Image.Visible:=false;
        ShowImage.Memo.Visible:=true;
        ShowImage.Button1.Visible:=true;
        ShowImage.Button2.Visible:=true;
        ShowImage.Memo.Text:=Principale.Query2.Fields[0].AsString;
        if ShowImage.Showmodal=mrOk then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('UPDATE X SET Z='''+
              AnsiReplaceStr(AnsiReplaceStr(ShowImage.Memo.Text,'"','\"'),'''','\''')+
              ''' WHERE X.no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
           Principale.Query2.ExecSQL;
           // Enregistrer la date de la dernière modification pour tout les individus reliés
           // à cet exhibits.
           Principale.Query3.SQL.Clear;
           Principale.Query3.SQL.Add('SELECT W.I FROM (W JOIN E on W.E=E.no) JOIN X on X.N=E.no WHERE X.no='+
                                        TableauExhibits.Cells[0,TableauExhibits.Row]);
           Principale.Query3.Open;
           Principale.Query3.First;
           while not Principale.Query3.EOF do
              begin
              SaveModificationTime(Principale.Query3.Fields[0].Asstring);
              Principale.Query3.Next;
           end;
           PopulateNom;
        end;
     end
     else
        begin
        if AnsiPos('.PDF',Principale.Query2.Fields[1].AsString)>0 then
           begin
           Ini := TIniFile.Create('Stemma.ini');
           pdf := ini.ReadString('Parametres','PDF','C:\Program Files (x86)\Adobe\Reader 10.0\Reader\AcroRd32.exe');
           with TProcess.Create(nil) do
           try
              CommandLine:=pdf+' '+Principale.Query2.Fields[1].AsString;
              Execute;
              ini.WriteString('Parametres','PDF',pdf);
           finally
              Free;
           end;
           Ini.Free;
        end
        else
           begin
           ShowImage.Caption:=Principale.Query2.Fields[1].AsString;
           ShowImage.Memo.Visible:=false;
           ShowImage.Button1.Visible:=false;
           ShowImage.Button2.Visible:=false;
           ShowImage.Image.Visible:=true;
           ShowImage.Image.Picture.LoadFromFile(Principale.Query2.Fields[1].AsString);
           ShowImage.Showmodal;
        end;
     end;
  end;
end;

procedure TEditEvenement.MenuItem11Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditEvenement.MenuItem12Click(Sender: TObject);
var
    j:integer;
    found:boolean;
    temp:string;
    direction:integer;
begin
  found:=false;
  direction := Principale.DataHist.RowCount-1;
  // Traitement de F3 pour les lieus
  if EditEvenement.ActiveControl.Name='LA' then
     begin
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if ANSIPos('<Article>',temp)>0 then
              LA.text:=Copy(temp,ANSIPos('<Article>',temp)+9,AnsiPos('</Article>',temp)-ANSIPos('<Article>',temp)-9)
           else
              LA.text:='';
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if ANSIPos('<Article>',temp)>0 then
                 LA.text:=Copy(temp,ANSIPos('<Article>',temp)+9,AnsiPos('</Article>',temp)-ANSIPos('<Article>',temp)-9)
              else
                 LA.text:='';
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L0' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L0.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Détail>',temp)>0 then
                 L0.text:=Copy(temp,ANSIPos('<Détail>',temp)+9,AnsiPos('</Détail>',temp)-ANSIPos('<Détail>',temp)-9);
              if ANSIPos('<Ville>',temp)>0 then
                 L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L0.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Détail>',temp)>0 then
                    L0.text:=Copy(temp,ANSIPos('<Détail>',temp)+9,AnsiPos('</Détail>',temp)-ANSIPos('<Détail>',temp)-9);
                 if ANSIPos('<Ville>',temp)>0 then
                    L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L1' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Ville>',temp)>0 then
                 L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Ville>',temp)>0 then
                    L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L2' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L3' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L4' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
    if EditEvenement.ActiveControl.Name='SD' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to direction do
          begin
          if Principale.DataHist.Cells[0,j]='SD' then
             begin
             SD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
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
                SD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
                SDEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditEvenement.ActiveControl.Name='PD' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to direction do
          begin
          if Principale.DataHist.Cells[0,j]='PD' then
             begin
             PD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
             PDEditingDone(Sender);
             found:=true;
             break;
          end;
       end;
       if not found then
          begin
          For j:=0 to Principale.DataHist.RowCount-1 do
             begin
             if Principale.DataHist.Cells[0,j]='PD' then
                begin
                PD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
                PDEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditEvenement.ActiveControl.Name='M' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to direction do
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

procedure TEditEvenement.MenuItem14Click(Sender: TObject);
var
    i:integer;
begin
  for i:=TableauTemoins.Selection.Top to TableauTemoins.Selection.Bottom do
  begin
       // Toggle le statut primaire d'un témoin
       if TableauTemoins.Cells[1,i]='*' then
          TableauTemoins.Cells[1,i]:=''
       else
          TableauTemoins.Cells[1,i]:='*';
       if StrToInt(TableauTemoins.Cells[0,i])>0 then
          begin
          Principale.Query1.SQL.Clear;
          if TableauTemoins.Cells[1,i]='*' then
             Principale.Query1.SQL.Add('UPDATE W SET X=1 WHERE W.no='+TableauTemoins.Cells[0,i])
          else
             Principale.Query1.SQL.Add('UPDATE W SET X=0 WHERE W.no='+TableauTemoins.Cells[0,i]);
          Principale.Query1.ExecSQL;
          SaveModificationTime(TableauTemoins.Cells[3,i]);
       end;
  end;
end;

procedure TEditEvenement.Modifier2Click(Sender: TObject);
begin
  // Modifier un document de l'événement
  If TableauExhibits.Row>0 then
     begin
     PutCode('E',TableauExhibits.Cells[0,TableauExhibits.Row]);
     If EditExhibits.Showmodal=mrOK then
        begin
        PopulateExhibits(TableauExhibits,'E',no.text);
        // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
        if Principale.MenuItem11.Checked then
           PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
     end;
  end;
end;

procedure TEditEvenement.Button1Click(Sender: TObject);
var
  Individu,Lieu,Lieu1,Lieu2,dateev:string;
  reorder, valide, trouve:boolean;
  j,k:integer;
begin
  // Vérifie qu'il y a au moins 1 témoin
  valide:=TableauTemoins.RowCount>1;
  if not valide then
     begin
     Application.MessageBox(pchar(AnsitoUTF8(Principale.Traduction.Items[301])),pchar(AnsitoUTF8(Principale.Traduction.Items[124])),MB_OK)
  end
  else
     begin
     if EditEvenement.ActiveControl=PD then
        PDEditingDone(Sender);
     if EditEvenement.ActiveControl=SD then
        SDEditingDone(Sender);
     if EditEvenement.ActiveControl=M then
        MEditingDone(Sender);
     // Trouve le lieu équivalent !!!
     LA.Text:=trim(LA.Text);
     L0.Text:=trim(L0.Text);
     L1.Text:=trim(L1.Text);
     L2.Text:=trim(L2.Text);
     L3.Text:=trim(L3.Text);
     L4.Text:=trim(L4.Text);
     Lieu1:='!TMG|'+trim(LA.Text+' '+L0.Text)+'|'+L1.Text+'|'+L2.Text+'|'+L3.Text+'|'+L4.Text+'||||';
     Lieu2:='';
     if Length(LA.TexT)>0 then
        Lieu2:='<Article>'+LA.Text+'</Article>';
     if Length(L0.TexT)>0 then
        Lieu2:=Lieu2+'<Détail>'+L0.Text+'</Détail>';
     L1.Text:=trim(L1.Text);
     if Length(L1.TexT)>0 then
        Lieu2:=Lieu2+'<Ville>'+L1.Text+'</Ville>';
     L2.Text:=trim(L2.Text);
     if Length(L2.TexT)>0 then
        Lieu2:=Lieu2+'<Région>'+L2.Text+'</Région>';
     L3.Text:=trim(L3.Text);
     if Length(L3.TexT)>0 then
        Lieu2:=Lieu2+'<Province>'+L3.Text+'</Province>';
     L4.Text:=trim(L4.Text);
     if Length(L4.TexT)>0 then
        Lieu2:=Lieu2+'<Pays>'+L4.Text+'</Pays>';
     Lieu1:=AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Lieu1,'\','\\'),'"','\"'),'''','\''');
     Lieu2:=AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Lieu2,'\','\\'),'"','\"'),'''','\''');
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT L.no FROM L WHERE L.L='''+Lieu2+'''');
     Principale.Query1.Open;
     if not Principale.Query1.EOF then
        Lieu:=Principale.Query1.Fields[0].AsString
     else
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT L.no FROM L WHERE L.L='''+Lieu1+'''');
        Principale.Query1.Open;
        if not Principale.Query1.EOF then
           Lieu:=Principale.Query1.Fields[0].AsString
        else // Ajoute le lieu dans la table
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('INSERT INTO L (L) VALUES ('''+Lieu2+''')');
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L.no FROM L WHERE L.L='''+Lieu2+'''');
           Principale.Query1.Open;
           Lieu:=Principale.Query1.Fields[0].AsString;
        end;
     end;
     if StrToInt(Lieu)>1 then
        begin
        // On doit vérifier avant d'insérer si le lieu existe déjà, si oui, déplace au début
        trouve:=false;
        for j:=1 to Principale.DataHist.RowCount-1 do
           begin
           if (Principale.DataHist.Cells[0,j]='L') and
              (Principale.DataHist.Cells[1,j]=Lieu) then
              begin
              trouve:=true;
              for k:=j downto 1 do
                 begin
                 Principale.DataHist.Cells[0,k]:=Principale.DataHist.Cells[0,k-1];
                 Principale.DataHist.Cells[1,k]:=Principale.DataHist.Cells[1,k-1];
              end;
              break;
           end;
        end;
        if not trouve then
           Principale.DataHist.InsertColRow(false,0);
        Principale.DataHist.Cells[0,1]:='L';
        Principale.DataHist.Cells[1,1]:=Lieu;
     end;
     Principale.Query1.SQL.Clear;
     if no.text='0' then
        begin
        Principale.Query1.SQL.Add('INSERT INTO E (Y, L, M, PD, SD, X) VALUES ('+Y2.Items[Y2.ItemIndex]+
          ', '+Lieu+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '+X.Text+')')
     end
     else
        Principale.Query1.SQL.Add('UPDATE E SET Y='+Y2.Items[Y2.ItemIndex]+
          ', L='+Lieu+', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', PD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', SD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''' WHERE no='+no.text);
     Principale.Query1.ExecSQL;
     if no.text='0' then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        // Ajoute le témoin qui a été ajouté par défaut dans le tableau
        Principale.Query1.SQL.Clear;
        if TableauTemoins.Cells[1,1]='*' then
           Principale.Query1.SQL.Add('INSERT INTO W (R, I, P, E, X) VALUES ('''+TableauTemoins.Cells[2,1]+
                   ''', '+TableauTemoins.Cells[3,1]+', '''', '+no.Text+', 1)')
        else
           Principale.Query1.SQL.Add('INSERT INTO W (R, I, P, E, X) VALUES ('''+TableauTemoins.Cells[2,1]+
                   ''', '+TableauTemoins.Cells[3,1]+', '''', '+no.Text+', 0)');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''W''');
        Principale.Query1.Open;
        Principale.Query1.First;
        TableauTemoins.Cells[0,1]:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     end;
     // Sauvegarder les modifications pour tous les témoins de l'événements
     Principale.Query3.SQL.Clear;
     Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+no.Text);
     Principale.Query3.Open;
     Principale.Query3.First;
     individu:='0';
     While not Principale.Query3.EOF do
        begin
        if Principale.Query3.Fields[1].AsBoolean then
           individu:=Principale.Query3.Fields[0].AsString;
        SaveModificationTime(Principale.Query3.Fields[0].AsString);
        // UPDATE DÉCÈS si la date est il y a 100 ans !!!
        if (copy(PD2.text,1,1)='1') and not (PD2.text='100000000030000000000') then
           dateev:=Copy(PD2.text,2,4)
        else
           if (copy(SD2.text,1,1)='1') and not (SD2.text='100000000030000000000') then
              dateev:=Copy(SD2.text,2,4)
           else
              dateev:=FormatDateTime('YYYY',now);
        if ((StrtoInt(FormatDateTime('YYYY',now))-StrtoInt(dateev))>100) then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+individu);
           Principale.Query2.ExecSQL;
           If (Principale.MenuItem8.Checked) and (individu=Principale.Individu.Caption) then
              PopulateNom;
        end;
        Principale.Query3.Next;
     end;
     // UPDATE N.I3 et N.I4!!!
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT Y.Y, E.X, E.PD FROM Y JOIN E on E.Y=Y.no WHERE E.no='+no.Text);
     Principale.Query1.Open;
     if  (StrToInt(individu)>0) and
         ((Principale.Query1.Fields[0].AsString='B') or ((Principale.Query1.Fields[0].AsString='D'))) and
         (Principale.Query1.Fields[1].AsInteger=1) and (X.Text='1') then
         begin
         if (Principale.Query1.Fields[0].AsString='B') then
             begin
             Principale.Query2.SQL.Clear;
             Principale.Query2.SQL.Add('UPDATE N SET I3='''+Principale.Query1.Fields[2].AsString+
                 ''' WHERE N.I='+individu);
             Principale.Query2.ExecSQL;
             // Update date de tri de relation
             Principale.Query2.SQL.Clear;
             Principale.Query2.SQL.Add('UPDATE R SET SD='''+Principale.Query1.Fields[2].AsString+
                 ''' WHERE A='+individu+' AND (SD=''100000000030000000000'' OR SD ='''')');
             Principale.Query2.ExecSQL;
         end;
         if (Principale.Query1.Fields[0].AsString='D') then
            begin
            // UPDATE N.I4!!!
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('UPDATE N SET I4='''+Principale.Query1.Fields[2].AsString+
                ''' WHERE N.I='+individu);
            Principale.Query2.ExecSQL;
            // UPDATE DÉCÈS!!!
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+individu);
            Principale.Query2.ExecSQL;
        end;
     end;
     // Modifier la ligne de l'explorateur si naissance principale ou décès principal
{     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT Y.Y, E.X, E.PD FROM Y JOIN E on E.Y=Y.no WHERE E.no='+no.Text);
     Principale.Query1.Open;
     if  (StrToInt(individu)>0) and
        ((Principale.Query1.Fields[0].AsString='B') or ((Principale.Query1.Fields[0].AsString='D'))) and
        (Principale.Query1.Fields[1].AsInteger=1) and (X.Text='1') then
        begin
        reorder:=false;
        for j:=1 to FormExplorateur.Index.RowCount-1 do
           if FormExplorateur.Index.Cells[1,j]=individu then
              begin
              if (Principale.Query1.Fields[0].AsString='B') then
                 begin
                 if Principale.MenuItem13.Checked then
                    begin
                    FormExplorateur.Index.Cells[3,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                    if (FormExplorateur.O.text='3') then
                       begin
                       FormExplorateur.Index.Cells[6,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                       reorder:=true;
                    end;
                 end;
                 // UPDATE N.I3!!!
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE N SET I3='''+Principale.Query1.Fields[2].AsString+
                     ''' WHERE N.I='+individu);
                 Principale.Query2.ExecSQL;
                 // Update date de tri de relation
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE R SET SD='''+Principale.Query1.Fields[2].AsString+
                     ''' WHERE A='+individu+' AND (SD=''100000000030000000000'' OR SD ='''')');
                 Principale.Query2.ExecSQL;
              end;
              if (Principale.Query1.Fields[0].AsString='D') then
                 begin
                 if Principale.MenuItem13.Checked then
                    begin
                    FormExplorateur.Index.Cells[4,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                    if (FormExplorateur.O.text='4') then
                       begin
                       FormExplorateur.Index.Cells[6,j]:=ConvertDate(Principale.Query1.Fields[2].AsString,1);
                       reorder:=true;
                    end;
                 end;
                 // UPDATE N.I4!!!
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE N SET I4='''+Principale.Query1.Fields[2].AsString+
                    ''' WHERE N.I='+individu);
                 Principale.Query2.ExecSQL;
                 // UPDATE DÉCÈS!!!
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+individu);
                 Principale.Query2.ExecSQL;
                 If Principale.MenuItem8.Checked then
                    PopulateNom;
              end;
           end;
        if reorder then
           begin
           FormExplorateur.Index.SortColRow(true,6);
           TrouveIndividu;
        end;
     end; }
  end;
end;

procedure TEditEvenement.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TEditEvenement.Ajouter1Click(Sender: TObject);
begin
  If no.text='0' then
     Button1Click(Sender);
  PutCode('E',no.text);
  PutCode('A',no.text);
  If EditCitations.Showmodal=mrOK then
     PopulateCitations(TableauCitations,'E',No.Text);
end;

procedure TEditEvenement.Ajouter2Click(Sender: TObject);
begin
  // Ajouter un document à l'événement
  If no.text='0' then
     Button1Click(Sender);
  PutCode('E',no.text);
  PutCode('A',no.text);
  If EditExhibits.Showmodal=mrOK then
     begin
     PopulateExhibits(TableauExhibits,'E',no.text);
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TEditEvenement.AjouterTemoinClick(Sender: TObject);
begin
  // Ajouter un témoin à l'événement
  If no.text='0' then
     Button1Click(Sender);
  PutCode('A',no.text);
  If EditTemoin.Showmodal=mrOK then
     PopulateTemoins(no.text);
end;

procedure TEditEvenement.BackRepeatClick(Sender: TObject);
var
    j:integer;
    found:boolean;
    temp:string;
    direction:integer;
begin
  found:=false;
  direction := 0;
  Principale.DataHist.Row:=Principale.DataHist.Row-1;
  // Traitement de F3 pour les lieus
  if EditEvenement.ActiveControl.Name='LA' then
     begin
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if ANSIPos('<Article>',temp)>0 then
              LA.text:=Copy(temp,ANSIPos('<Article>',temp)+9,AnsiPos('</Article>',temp)-ANSIPos('<Article>',temp)-9)
           else
              LA.text:='';
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if ANSIPos('<Article>',temp)>0 then
                 LA.text:=Copy(temp,ANSIPos('<Article>',temp)+9,AnsiPos('</Article>',temp)-ANSIPos('<Article>',temp)-9)
              else
                 LA.text:='';
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L0' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L0.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Détail>',temp)>0 then
                 L0.text:=Copy(temp,ANSIPos('<Détail>',temp)+9,AnsiPos('</Détail>',temp)-ANSIPos('<Détail>',temp)-9);
              if ANSIPos('<Ville>',temp)>0 then
                 L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L0.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Détail>',temp)>0 then
                    L0.text:=Copy(temp,ANSIPos('<Détail>',temp)+9,AnsiPos('</Détail>',temp)-ANSIPos('<Détail>',temp)-9);
                 if ANSIPos('<Ville>',temp)>0 then
                    L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L1' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Ville>',temp)>0 then
                 L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Ville>',temp)>0 then
                    L1.text:=Copy(temp,ANSIPos('<Ville>',temp)+7,AnsiPos('</Ville>',temp)-ANSIPos('<Ville>',temp)-7);
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L2' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Région>',temp)>0 then
                 L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Région>',temp)>0 then
                    L2.text:=Copy(temp,ANSIPos('<Région>',temp)+9,AnsiPos('</Région>',temp)-ANSIPos('<Région>',temp)-9);
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L3' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Province>',temp)>0 then
                 L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Province>',temp)>0 then
                    L3.text:=Copy(temp,ANSIPos('<Province>',temp)+10,AnsiPos('</Province>',temp)-ANSIPos('<Province>',temp)-10);
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditEvenement.ActiveControl.Name='L4' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row-1 downto direction do
        begin
        if Principale.DataHist.Cells[0,j]='L' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           if Copy(temp,1,4)='!TMG' then
              begin
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
              L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
           end
           else
              begin
              if ANSIPos('<Pays>',temp)>0 then
                 L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=Principale.DataHist.RowCount-1 downto 0 do
           begin
           if Principale.DataHist.Cells[0,j]='L' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT L FROM L WHERE no='+Principale.DataHist.Cells[1,j]);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              if Copy(temp,1,4)='!TMG' then
                 begin
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L1.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L2.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L3.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
                 temp:=Copy(temp,AnsiPos('|',temp)+1,Length(temp));
                 L4.Text:=Copy(temp,1,AnsiPos('|',temp)-1);
              end
              else
                 begin
                 if ANSIPos('<Pays>',temp)>0 then
                    L4.text:=Copy(temp,ANSIPos('<Pays>',temp)+6,AnsiPos('</Pays>',temp)-ANSIPos('<Pays>',temp)-6);
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
    if EditEvenement.ActiveControl.Name='SD' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row-1 downto direction do
          begin
          if Principale.DataHist.Cells[0,j]='SD' then
             begin
             SD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
             SDEditingDone(Sender);
             found:=true;
             break;
          end;
       end;
       if not found then
          begin
          For j:=Principale.DataHist.RowCount-1 downto 0 do
             begin
             if Principale.DataHist.Cells[0,j]='SD' then
                begin
                SD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
                SDEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditEvenement.ActiveControl.Name='PD' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row-1 downto direction do
          begin
          if Principale.DataHist.Cells[0,j]='PD' then
             begin
             PD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
             PDEditingDone(Sender);
             found:=true;
             break;
          end;
       end;
       if not found then
          begin
          For j:=Principale.DataHist.RowCount-1  downto 0 do
             begin
             if Principale.DataHist.Cells[0,j]='PD' then
                begin
                PD.text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
                PDEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditEvenement.ActiveControl.Name='M' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row-1 downto direction do
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
          For j:=Principale.DataHist.RowCount-1 downto 0 do
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
    if found then Principale.DataHist.Row:=j;
end;

procedure TEditEvenement.SDEditingDone(Sender: TObject);
var
  j,k:integer;
  trouve:boolean;
begin
  SD2.Text:=InterpreteDate(SD.Text,1);
  SD.Text:=ConvertDate(SD2.Text,1);
  if SD2.Text<>'100000000030000000000' then
     begin
     // On doit vérifier avant d'insérer si la date existe déjà, si oui, déplace au début
     trouve:=false;
     for j:=0 to Principale.DataHist.RowCount-1 do
        begin
        if (Principale.DataHist.Cells[0,j]='SD') and
           (Principale.DataHist.Cells[1,j]=SD2.Text) then
           begin
           trouve:=true;
           for k:=j downto 1 do
              begin
              Principale.DataHist.Cells[0,k]:=Principale.DataHist.Cells[0,k-1];
              Principale.DataHist.Cells[1,k]:=Principale.DataHist.Cells[1,k-1];
           end;
           break;
        end;
     end;
     if not trouve then
        Principale.DataHist.InsertColRow(false,0);
     Principale.DataHist.Cells[0,0]:='SD';
     Principale.DataHist.Cells[1,0]:=SD2.Text;
  end;
  Principale.DataHist.Row:=0;
end;

procedure TEditEvenement.Supprimer1Click(Sender: TObject);
begin
  If TableauCitations.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[31])+
        TableauCitations.Cells[1,TableauCitations.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM C WHERE no='+TableauCitations.Cells[0,TableauCitations.Row]);
        Principale.Query1.ExecSQL;
        TableauCitations.DeleteRow(TableauCitations.Row);
        // Sauvegarder les modifications pour tout les témoins de l'événements
        Principale.Query3.SQL.Clear;
        Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+no.Text);
        Principale.Query3.Open;
        Principale.Query3.First;
        While not Principale.Query3.EOF do
           begin
           SaveModificationTime(Principale.Query3.Fields[0].AsString);
           Principale.Query3.Next;
        end;
     end;
end;

procedure TEditEvenement.Supprimer2Click(Sender: TObject);
begin
  // Supprimer le document de l'événement
  If TableauExhibits.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[60])+
        TableauExhibits.Cells[2,TableauExhibits.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM X WHERE no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
        Principale.Query1.ExecSQL;
        TableauExhibits.DeleteRow(TableauExhibits.Row);
        // Sauvegarder les modifications pour tout les témoins de l'événements
        Principale.Query3.SQL.Clear;
        Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+no.Text);
        Principale.Query3.Open;
        Principale.Query3.First;
        While not Principale.Query3.EOF do
           begin
           SaveModificationTime(Principale.Query3.Fields[0].AsString);
           Principale.Query3.Next;
        end;
        // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
        if Principale.MenuItem11.Checked then
           PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
     end;
end;

procedure TEditEvenement.SupprimerTemoinClick(Sender: TObject);
begin
  If (TableauTemoins.RowCount>2) and (TableauTemoins.Row>0) then  // Il faudra qu'il reste au moins un témoin
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[32])+
        TableauTemoins.Cells[4,TableauTemoins.Row]+' ('+
        TableauTemoins.Cells[3,TableauTemoins.Row]+')'+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        // Exécuter SAVEMODIFICATIONTIME pour le témoin supprimer
        SaveModificationTime(TableauTemoins.Cells[3,TableauTemoins.Row]);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM W WHERE no='+TableauTemoins.Cells[0,TableauTemoins.Row]);
        Principale.Query1.ExecSQL;
        TableauTemoins.DeleteRow(TableauTemoins.Row);
        // Sauvegarder les modifications pour tous les témoins de l'événements
        Principale.Query3.SQL.Clear;
        Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+no.Text);
        Principale.Query3.Open;
        Principale.Query3.First;
        While not Principale.Query3.EOF do
           begin
           SaveModificationTime(Principale.Query3.Fields[0].AsString);
           Principale.Query3.Next;
        end;
     end;
end;

function PopulateTemoins(Event:string):string;
var
  row:integer;
  phrase:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT W.no, W.I, W.X, W.P, W.R, N.N FROM W JOIN N ON N.I=W.I WHERE W.E='+
                           Event+' AND N.X=1 ORDER BY W.X DESC');
  Principale.Query1.Open;
  Principale.Query1.First;
  EditEvenement.TableauTemoins.RowCount:=Principale.Query1.RecordCount+1;
  row:=1;
  while not Principale.Query1.eof do
     begin
     EditEvenement.TableauTemoins.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     EditEvenement.TableauTemoins.Cells[2,row]:=Principale.Query1.Fields[4].AsString;
     EditEvenement.TableauTemoins.Cells[3,row]:=Principale.Query1.Fields[1].AsString;
     EditEvenement.TableauTemoins.Cells[4,row]:=DecodeName(Principale.Query1.Fields[5].AsString,1);
     if Principale.Query1.Fields[2].AsBoolean then
        EditEvenement.TableauTemoins.Cells[1,row]:='*'
     else
        EditEvenement.TableauTemoins.Cells[1,row]:='';
     if Principale.Query1.Fields[1].AsString=Principale.Individu.Text then
        begin
        phrase:=Principale.Query1.Fields[3].AsString;
        EditEvenement.Role.Text:=Principale.Query1.Fields[4].AsString;
     end;
     row:=row+1;
     Principale.Query1.Next;
  end;
  EditEvenement.Label13.Caption:='('+IntToStr(EditEvenement.TableauTemoins.RowCount-1)+')';
  PopulateTemoins:=phrase;
end;

end.

