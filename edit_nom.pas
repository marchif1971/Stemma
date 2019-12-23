unit Edit_Nom;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, Edit_Citations, StrUtils, FMUtils, LCLType, MaskEdit;

type

  { TEditNom }

  TEditNom = class(TForm)
    Ajouter1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    M: TMemo;
    I: TMaskEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Modifier1: TMenuItem;
    No: TEdit;
    X: TEdit;
    P: TMemo;
    P2: TMemo;
    P1: TMemo;
    PD: TEdit;
    PopupMenu2: TPopupMenu;
    PopupMenuNom: TPopupMenu;
    SD: TEdit;
    PD2: TEdit;
    SD2: TEdit;
    Supprimer1: TMenuItem;
    TableauCitations: TStringGrid;
    TableauNoms: TStringGrid;
    Ajout: TEdit;
    Y: TComboBox;
    Y2: TComboBox;
    procedure Ajouter1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure IEditingDone(Sender: TObject);
    procedure MEditingDone(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure P2DblClick(Sender: TObject);
    procedure PDblClick(Sender: TObject);
    procedure PDEditingDone(Sender: TObject);
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

procedure NomSaveData;

var
  EditNom: TEditNom;

implementation

uses
  noms, unit1, evenements; // explorateur

{$R *.lfm}

{ TEditNom }

procedure TEditNom.TableauCitationsDblClick(Sender: TObject);
begin
  if TableauCitations.Row>0 then
     begin
     PutCode('N',TableauCitations.Cells[0,TableauCitations.Row]);
     If EditCitations.Showmodal=mrOK then
        PopulateCitations(TableauCitations,'N',No.Text);
  end;
end;

procedure TEditNom.YChange(Sender: TObject);
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
     P2.Text:=DecodePhrase(Principale.Individu.Caption,'PRINCIPAL',P.Text,'N',No.Text);
  end
  else
     Label6.Visible:=(P.Text=P1.Text);
end;

procedure TEditNom.P2DblClick(Sender: TObject);
begin
  P.Visible:=true;
  P2.Visible:=false;
end;

procedure TEditNom.FormShow(Sender: TObject);
var
  titre,prenom,nom,suffixe,temp,code,nocode,type_cherche:string;
  j,Pos1,Pos2:integer;
begin
  GetFormPosition(Sender as TForm,0,0,590,629);
  I.ReadOnly:=false;
  EditNom.ActiveControl:=EditNom.TableauNoms;
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[182]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[166]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[183]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[171]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[172]);
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[144]);
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[173]);
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[174]);
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[184]);
  Label9.Caption:=AnsitoUTF8(Principale.Traduction.Items[168]);
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[169]);
  TableauNoms.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauNoms.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauCitations.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[138]);
  TableauCitations.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauCitations.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[229]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[230]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[231]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[232]);
  MenuItem9.Caption:=AnsitoUTF8(Principale.Traduction.Items[228]);
  MenuItem10.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem11.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem12.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  Ajouter1.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier1.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer1.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  // Populate le ComboBox
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT Y.no, Y.T, Y.P FROM Y WHERE Y.Y=''N''');
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
  TableauNoms.RowCount:=5;
  // Populate la form
  GetCode(code,nocode);
  Ajout.Text:='0';
  if code='A' then
     begin
     GetCode(code,nocode);
     If Length(code)>=1 then
        begin
        PutCode(code,nocode);
        EditNom.Caption:='';
        Ajout.Text:='1';
        if code='J' then
           begin
           TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[318])+GetName(Principale.Individu.Caption);
        end;
        if code='I' then  // fils
           // Ajouter NOM s'il y a lieu
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT S FROM I WHERE no='+Principale.Individu.Caption);
           Principale.Query1.Open;
           if Principale.Query1.Fields[0].AsString='M' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              nom:='';
              if copy(temp,1,5)='!TMG|' then
                 begin
                 temp := copy(temp,6,length(temp));
                 nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
              end
              else
                 begin
                 // Traiter les noms avec <N=TITRE></N>...
                 Pos1:=AnsiPos('<Nom>',temp)+5;
                 Pos2:=AnsiPos('</Nom>',temp);
                 if (Pos1+Pos2)>5 then
                    nom:=Copy(temp,Pos1,Pos2-Pos1);
              end;
              if length(nom)>0 then
                 begin
                 TableauNoms.RowCount:=2;
                 TableauNoms.Cells[1,1]:='Nom';
                 TableauNoms.Cells[2,1]:=nom;
              end
              else
               TableauNoms.RowCount:=1;
           end
           else
               TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[315])+GetName(Principale.Individu.Caption);
        end;
        if code='L' then // fille
           // Ajouter NOM s'il y a lieu }
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT S FROM I WHERE no='+Principale.Individu.Caption);
           Principale.Query1.Open;
           if Principale.Query1.Fields[0].AsString='M' then
              begin
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.Add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
              Principale.Query1.Open;
              temp:=Principale.Query1.Fields[0].AsString;
              nom:='';
              if copy(temp,1,5)='!TMG|' then
                 begin
                 temp := copy(temp,6,length(temp));
                 nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
              end
              else
                 begin
                 // Traiter les noms avec <N=TITRE></N>...
                 Pos1:=AnsiPos('<Nom>',temp)+5;
                 Pos2:=AnsiPos('</Nom>',temp);
                 if (Pos1+Pos2)>5 then
                    nom:=Copy(temp,Pos1,Pos2-Pos1);
              end;
              if length(nom)>0 then
                 begin
                 TableauNoms.RowCount:=2;
                 TableauNoms.Cells[1,1]:='Nom';
                 TableauNoms.Cells[2,1]:=nom;
              end
              else
               TableauNoms.RowCount:=1;
           end
           else
               TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[316])+GetName(Principale.Individu.Caption);
        end;
        if code='F' then  // frère
           // Ajouter NOM }
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           nom:='';
           if copy(temp,1,5)='!TMG|' then
              begin
              temp := copy(temp,6,length(temp));
              nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
           end
           else
              begin
              // Traiter les noms avec <N=TITRE></N>...
              Pos1:=AnsiPos('<Nom>',temp)+5;
              Pos2:=AnsiPos('</Nom>',temp);
              if (Pos1+Pos2)>5 then
                 nom:=Copy(temp,Pos1,Pos2-Pos1);
           end;
           if length(nom)>0 then
              begin
              TableauNoms.RowCount:=2;
              TableauNoms.Cells[1,1]:='Nom';
              TableauNoms.Cells[2,1]:=nom;
           end
           else
              TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[313])+GetName(Principale.Individu.Caption);
        end;
        if code='S' then  // soeur
           // Ajouter NOM }
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           nom:='';
           if copy(temp,1,5)='!TMG|' then
              begin
              temp := copy(temp,6,length(temp));
              nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
           end
           else
              begin
              // Traiter les noms avec <N=TITRE></N>...
              Pos1:=AnsiPos('<Nom>',temp)+5;
              Pos2:=AnsiPos('</Nom>',temp);
              if (Pos1+Pos2)>5 then
                 nom:=Copy(temp,Pos1,Pos2-Pos1);
           end;
           if length(nom)>0 then
              begin
              TableauNoms.RowCount:=2;
              TableauNoms.Cells[1,1]:='Nom';
              TableauNoms.Cells[2,1]:=nom;
           end
           else
              TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[337])+GetName(Principale.Individu.Caption);
        end;
        if code='P' then  // Père
           // Ajouter NOM }
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
           Principale.Query1.Open;
           temp:=Principale.Query1.Fields[0].AsString;
           nom:='';
           if copy(temp,1,5)='!TMG|' then
              begin
              temp := copy(temp,6,length(temp));
              nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
           end
           else
              begin
              // Traiter les noms avec <N=TITRE></N>...
              Pos1:=AnsiPos('<Nom>',temp)+5;
              Pos2:=AnsiPos('</Nom>',temp);
              if (Pos1+Pos2)>5 then
                 nom:=Copy(temp,Pos1,Pos2-Pos1);
           end;
           if length(nom)>0 then
              begin
              TableauNoms.RowCount:=2;
              TableauNoms.Cells[1,1]:='Nom';
              TableauNoms.Cells[2,1]:=nom;
           end
           else
              TableauNoms.RowCount:=1;
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[311])+GetName(Principale.Individu.Caption);
        end;
        if code='M' then  // Mère
           begin
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[312])+GetName(Principale.Individu.Caption);
           TableauNoms.RowCount:=1;
        end;
        if code='R' then  // Non-Relié
           begin
           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[35]);
           TableauNoms.RowCount:=1;
        end;
//        if length(EditNom.Caption)=0 then
//           begin
//           EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[35]);
//           TableauNoms.RowCount:=1;
//        end;
        I.ReadOnly:=true;
        I.Text:='0';
        X.Text:='1';
     end
     else
        begin
        TableauNoms.RowCount:=1;
        EditNom.Caption:=AnsitoUTF8(Principale.Traduction.Items[36]);
        I.Text:=Principale.Individu.Text;
        X.Text:='0';
     end;
     Button1.Enabled:=true;
     TableauCitations.RowCount:=1;
     No.Text:='0';
     M.Text:='';
     P.Text:='';
     P1.Text:='';
     P2.Text:='';
     PD.Text:='';
     PD2.Text:=InterpreteDate('',1);;
     SD.Text:='';
     SD2.Text:=PD2.Text;
     Y.ItemIndex:=0;
     Y2.ItemIndex:=0;
     Label6.Visible:=true;
  end
  else // modifie un nom existant en provenance du tableau nom
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT N.no, N.I, N.Y, N.N, N.M, N.P, N.PD, N.SD, N.X FROM  N WHERE N.no='+
                                FormNoms.TableauNoms.Cells[0,FormNoms.TableauNoms.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     temp:=Principale.Query1.Fields[3].AsString;
     suffixe:='';
     nom:='';
     prenom:='';
     titre:='';
     if copy(temp,1,5)='!TMG|' then
        begin
        temp := copy(temp,6,length(temp));
        nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
        temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
        titre := trim(copy(temp,1,AnsiPos('|',temp)-1));
        temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
        prenom := trim(copy(temp,1,AnsiPos('|',temp)-1));
        temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
        suffixe := trim(copy(temp,1,AnsiPos('|',temp)-1));
     end
     else
        begin
        // Traiter les noms avec <N=TITRE></N>...
        Pos1:=AnsiPos('<Titre>',temp)+7;
        Pos2:=AnsiPos('</Titre>',temp);
        if (Pos1+Pos2)>7 then
           titre:=Copy(temp,Pos1,Pos2-Pos1);
        Pos1:=AnsiPos('<Prénom>',temp)+9;     // 9 car le 'é' prends 2 position en ANSI
        Pos2:=AnsiPos('</Prénom>',temp);
        if (Pos1+Pos2)>9 then
           prenom:=Copy(temp,Pos1,Pos2-Pos1);
        Pos1:=AnsiPos('<Nom>',temp)+5;
        Pos2:=AnsiPos('</Nom>',temp);
        if (Pos1+Pos2)>5 then
           nom:=Copy(temp,Pos1,Pos2-Pos1);
        Pos1:=AnsiPos('<Suffixe>',temp)+9;
        Pos2:=AnsiPos('</Suffixe>',temp);
        if (Pos1+Pos2)>9 then
           Suffixe:=Copy(temp,Pos1,Pos2-Pos1);
     end;
     j:=1;
     if length(titre)>0 then
        begin
        TableauNoms.Cells[1,j]:='Titre';
        TableauNoms.Cells[2,j]:=titre;
        j:=j+1;
     end;
     if length(prenom)>0 then
        begin
        TableauNoms.Cells[1,j]:='Prénom';
        TableauNoms.Cells[2,j]:=prenom;
        j:=j+1;
     end;
     if length(nom)>0 then
        begin
        TableauNoms.Cells[1,j]:='Nom';
        TableauNoms.Cells[2,j]:=nom;
        j:=j+1;
     end;
     if length(suffixe)>0 then
        begin
        TableauNoms.Cells[1,j]:='Suffixe';
        TableauNoms.Cells[2,j]:=Suffixe;
        j:=j+1;
     end;
     TableauNoms.RowCount:=j;
     type_cherche:=Principale.Query1.Fields[2].AsString;
     if (type_cherche='1037') then
        type_cherche:='20';
     for j:=0 to Y2.Items.Count-1 do
        if Y2.Items[j]=type_cherche then
           Y.ItemIndex:=j;
     Y2.ItemIndex:=Y.ItemIndex;
     No.Text:=Principale.Query1.Fields[0].AsString;
     I.Text:=Principale.Query1.Fields[1].AsString;
     Button1.Enabled:=true;
     TableauCitations.Enabled:=true;
     M.Text:=Principale.Query1.Fields[4].AsString;
     P.Text:=Principale.Query1.Fields[5].AsString;
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
     P2.Text:=DecodePhrase(Principale.Individu.Caption,'PRINCIPAL',P.Text,'N',No.Text);
     PD2.Text:=Principale.Query1.Fields[6].AsString;
     PD.Text:=ConvertDate(Principale.Query1.Fields[6].AsString,1);
     SD2.Text:=Principale.Query1.Fields[7].AsString;
     SD.Text:=ConvertDate(Principale.Query1.Fields[7].AsString,1);
     X.Text:=Principale.Query1.Fields[8].AsString;
     I.ReadOnly:=(X.Text='1');
     // Populate le tableau de citations
     PopulateCitations(TableauCitations,'N',No.Text);
  end;
end;

procedure TEditNom.IEditingDone(Sender: TObject);
begin
  If StrToInt(I.Text)>0 then
     begin
     Button1.Enabled:=true;
     TableauCitations.Enabled:=true;
  end
  else
     begin
     Button1.Enabled:=false;
     TableauCitations.Enabled:=true;
  end;
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='I';
  Principale.DataHist.Cells[1,0]:=I.Text;
end;

procedure TEditNom.MEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='M';
  Principale.DataHist.Cells[1,0]:=M.Text;
end;

procedure NomSaveData;
var
  j:integer;
  nom,nom_recherche,i1,i2,i3,i4,temp,typerelation,code,nocode,dateev,parent1,parent2,no_eve:string;
  existe:boolean;
begin
  nom:=EditNom.X.Text;
  nom:='';
  nom_recherche:='';
  i1:='';
  i2:='';
  i3:='';
  i4:='';
  // cherche le prochain numéro vide si un ajout d'une personne
  if EditNom.I.text='0' then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        EditNom.I.text:='0'
     else
        EditNom.I.text:=Principale.Query2.Fields[0].AsString;
  end;
  if EditNom.TableauNoms.RowCount>1 then
     For j:=1 to EditNom.TableauNoms.RowCount-1 do
        if length(trim(EditNom.TableauNoms.Cells[2,j]))>0 then
           begin
           nom_recherche:=nom_recherche+' '+trim(EditNom.TableauNoms.Cells[2,j]);
           nom:=nom+'<'+EditNom.TableauNoms.Cells[1,j]+'>'+trim(EditNom.TableauNoms.Cells[2,j])+'</'+EditNom.TableauNoms.Cells[1,j]+'>';
           if EditNom.TableauNoms.Cells[1,j]=AnsitoUTF8(Principale.Traduction.Items[37]) then
              i1:=RemoveUTF8(trim(EditNom.TableauNoms.Cells[2,j]));
           if EditNom.TableauNoms.Cells[1,j]=AnsitoUTF8(Principale.Traduction.Items[38]) then
              i2:=RemoveUTF8(trim(EditNom.TableauNoms.Cells[2,j]));
           end;
  nom_recherche:=trim(nom_recherche);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='N';
  Principale.DataHist.Cells[1,0]:=nom;
  if EditNom.no.Text='0' then
     begin
     GetCode(code,nocode);
     if Code='R' then
        begin
        Principale.Query1.SQL.Clear;
        if EditNom.I.text='0' then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''?'', ''?'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+EditNom.I.text+''', ''?'', ''?'', 0)');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
        Principale.Query1.Open;
        Principale.Query1.First;
        if EditNom.I.text='0' then
           EditNom.I.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     end;
     if (Code='P') or (Code='M') then // père ou mère
        begin
        Principale.Query1.SQL.Clear;
        // mets le sexe de la personne actuelle dans nocode...
        if code='P' then
           nocode:='M'
        else
           nocode:='F';
        if EditNom.I.text='0' then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+nocode+''', ''N'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+EditNom.I.text+''', '''+nocode+''', ''N'', 0)');
        Principale.Query1.ExecSQL;
        if EditNom.I.text='0' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
           Principale.Query1.Open;
           Principale.Query1.First;
           EditNom.I.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        end;
        Principale.Query1.SQL.Clear;
        // Valide si principal...
        Principale.Query2.SQL.Clear;
        if code='P' then
           Principale.Query2.SQL.Add('SELECT R.no, R.B FROM R JOIN I ON R.B=I.no WHERE I.S=''M'' AND R.X=1 AND R.A='+
              Principale.Individu.Caption)
        else
           Principale.Query2.SQL.Add('SELECT R.no, R.B FROM R JOIN I ON R.B=I.no WHERE I.S=''F'' AND R.X=1 AND R.A='+
              Principale.Individu.Caption);
        Principale.Query2.Open;
        If Principale.Query2.EOF then
           begin
           typerelation:='10';
           temp:='1'
        end
        else
           begin
           typerelation:='12';     // Si des parents principaux existent, assume l'ajout de parrain/marraine
           temp:='0';
        end;
        Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, X, SD) VALUES ('+typerelation+', '+
           Principale.Individu.Caption+', '+EditNom.I.Text+', '+temp+', ''100000000030000000000'')');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
        Principale.Query1.Open;
        Principale.Query1.First;
        // ajouter les citations du nom à la relation
        PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
        SaveModificationTime(Principale.Individu.Caption);
        // Demande si on veut unir les parents
        if (temp='1') then
           begin
           if code='M' then temp:='M' else temp:='F';
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SELECT R.no, R.B, N.N FROM R JOIN I ON R.B=I.no JOIN N on N.I=R.B WHERE I.S='''+
                                     temp+''' AND R.X=1 AND N.X=1 AND R.A='+Principale.Individu.Text);
           Principale.Query1.Open;
           If not Principale.Query1.EOF then
              begin
              parent1:=EditNom.I.Text;
              parent2:=Principale.Query1.Fields[1].AsString;
              // Vérifier qu'il n'y a pas déjà une union entre ces deux parents
              Principale.Query2.SQL.Clear;
              Principale.Query2.SQL.Add('SELECT COUNT(E.no) FROM E JOIN W ON W.E=E.no JOIN Y on E.Y=Y.no WHERE (W.I='+
                                        parent1+' OR W.I='+parent2+') AND W.X=1 AND E.X=1 AND Y.Y=''M'' GROUP BY E.no');
              Principale.Query2.Open;
              existe:=false;
              while not Principale.Query2.EOF do
                 begin
                 existe:=existe or (Principale.Query2.Fields[0].AsInteger=2);
                 Principale.Query2.Next;
              end;
              if not existe then
                 // GetName(parent1) montre '???' car le nom n'a pas encore été enregistré, utiliser le nom dans 'nom'
                 if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[300])+
                       DecodeName(nom,1)+AnsitoUTF8(Principale.Traduction.Items[299])+
                       DecodeName(Principale.Query1.Fields[2].AsString,1)+
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
//                  PutCode('X',no_eve);
                    // Sauvegarder les modifications
                    SaveModificationTime(parent1);
                    SaveModificationTime(parent2);
                    // UPDATE DÉCÈS si la date est il y a 100 ans !!!
                    if (copy(EditNom.PD2.text,1,1)='1') and not (EditNom.PD2.text='100000000030000000000') then
                       dateev:=Copy(EditNom.PD2.text,2,4)
                    else
                       if (copy(EditNom.SD2.text,1,1)='1') and not (EditNom.SD2.text='100000000030000000000') then
                          dateev:=Copy(EditNom.SD2.text,2,4)
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
     end;
     if (Code='J') then
        begin
        // Trouve le sexe de la personne actuelle dans nocode...
        Principale.Query1.SQL.Clear;
        if EditNom.I.text='0' then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+nocode+''', ''?'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+EditNom.I.text+''', '''+nocode+''', ''?'', 0)');
        Principale.Query1.ExecSQL;
        if EditNom.I.text='0' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
           Principale.Query1.Open;
           Principale.Query1.First;
           EditNom.I.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO E (Y, X, L, PD, SD) VALUES (300, 1, 1, ''100000000030000000000'', ''100000000030000000000'')');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        nocode:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        // ajouter les citations du nom à l'événement
        PutCode(code,nocode);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO W (I, E, X, R) VALUES ('+
           Principale.Individu.Caption+', '+nocode+',1 , ''CONJOINT'')');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        // ajouter les citations du nom au témoin
//        PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO W (I, E, X, R) VALUES ('+
           EditNom.I.Text+', '+nocode+',1 , ''CONJOINT'')');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        // ajouter les citations du nom au témoin
//        PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
        SaveModificationTime(Principale.Individu.Caption);
     end;
     if (Code='F') or (Code='S') then
        begin
        Principale.Query1.SQL.Clear;
        // mets le sexe de la personne actuelle dans nocode...
        if code='F' then
           nocode:='M'
        else
           nocode:='F';
        if EditNom.I.text='0' then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+nocode+''', ''?'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+EditNom.I.text+''', '''+nocode+''', ''?'', 0)');
        Principale.Query1.ExecSQL;
        if EditNom.I.text='0' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
           Principale.Query1.Open;
           Principale.Query1.First;
           EditNom.I.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        end;
        // Recherche parent principaux
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('SELECT R.no, R.B FROM R WHERE R.X=1 AND R.A='+
           Principale.Individu.Caption);
        Principale.Query2.Open;
        Principale.Query2.First;
        while not Principale.Query2.EOF do
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, X, SD) VALUES (10, '+
              EditNom.I.Text+', '+Principale.Query2.Fields[1].AsString+', 1, ''100000000030000000000'')');
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
           Principale.Query1.Open;
           Principale.Query1.First;
           // ajouter les citations du nom à la relation
//           PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
           //  SaveModificationTime(Principale.Query2.Fields[1].AsString);
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('UPDATE I SET date='''+FormatDateTime('YYYYMMDD',now)+
                          ''' WHERE no='+Principale.Query2.Fields[1].AsString);
           Principale.Query1.ExecSQL;
           Principale.Query2.Next;
        end;
     end;
     if (Code='I') or (Code='L') then
        begin
        Principale.Query1.SQL.Clear;
        // mets le sexe de la personne actuelle dans temp...
        if code='I' then
           temp:='M'
        else
           temp:='F';
        if EditNom.I.text='0' then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+temp+''', ''?'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+EditNom.I.text+''', '''+temp+''', ''?'', 0)');
        Principale.Query1.ExecSQL;
        if EditNom.I.text='0' then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
           Principale.Query1.Open;
           Principale.Query1.First;
           EditNom.I.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, X, SD) VALUES (10, '+
           EditNom.I.Text+', '+Principale.Individu.Caption+', 1, ''100000000030000000000'')');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
        Principale.Query1.Open;
        Principale.Query1.First;
        // ajouter les citations du nom à la relation
        PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
        SaveModificationTime(Principale.Individu.Caption);
        if StrToInt(nocode)>0 then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('INSERT INTO R (Y, A, B, X, SD) VALUES (10, '+
              EditNom.I.Text+', '+nocode+', 1, ''100000000030000000000'')');
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
           Principale.Query1.Open;
           Principale.Query1.First;
           // ajouter les citations du nom à la relation
           PutCode(code,InttoStr(Principale.Query1.Fields[10].AsInteger-1));
           SaveModificationTime(nocode);
        end;
     end;
     i3:=GetI3(EditNom.I.Text);
     i4:=GetI4(EditNom.I.Text);
     temp:=EditNom.X.Text;
     If EditNom.Label6.Visible then
        begin
        temp:='INSERT INTO N (Y, I, M, N, I1, I2, PD, SD, P, I3, I4, X, R) VALUES ('+EditNom.Y2.Items[EditNom.Y2.ItemIndex]+
          ', '''+EditNom.I.Text+''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i1,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i2,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''', '''+i3+''','''+i4+''', '+EditNom.X.Text+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_recherche,'\','\\'),'"','\"'),'''','\''')+''')';
     end
     else
        begin
        temp:='INSERT INTO N (Y, I, M, N, I1, I2, PD, SD, P, I3, I4, X, R) VALUES ('+EditNom.Y2.Items[EditNom.Y2.ItemIndex]+
          ', '''+EditNom.I.Text+''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i1,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i2,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.P.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', '''+i3+''','''+i4+''', '+EditNom.X.Text+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_recherche,'\','\\'),'"','\"'),'''','\''')+''')';
     end
  end
  else
     begin
     // Si on déplace un nom primaire d'individu, le nom devient secondaire.
     if (EditNom.X.text='1') and
        ((Principale.Individu.Caption<>EditNom.I.Text) and not (EditNom.I.Text='0') and not (EditNom.Ajout.Text='1')) then
        EditNom.X.text:='0';
     If EditNom.Label6.Visible then
        begin
        temp:='UPDATE N SET Y='+EditNom.Y2.Items[EditNom.Y2.ItemIndex]+
          ', I='+EditNom.I.Text+', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', N='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom,'\','\\'),'"','\"'),'''','\''')+
          ''', I1='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i1,'\','\\'),'"','\"'),'''','\''')+
          ''', I2='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i2,'\','\\'),'"','\"'),'''','\''')+
          ''', PD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', SD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', P='''', X='+EditNom.X.text+', R='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_recherche,'\','\\'),'"','\"'),'''','\''')+''' WHERE no='+EditNom.no.text;
     end
     else
        begin
        temp:='UPDATE N SET Y='+EditNom.Y2.Items[EditNom.Y2.ItemIndex]+
          ', I='+EditNom.I.Text+', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.M.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', N='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom,'\','\\'),'"','\"'),'''','\''')+
          ''', I1='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i1,'\','\\'),'"','\"'),'''','\''')+
          ''', I2='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i2,'\','\\'),'"','\"'),'''','\''')+
          ''', PD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.PD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', SD='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(EditNom.SD2.Text,'\','\\'),'"','\"'),'''','\''')+
          ''', P='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(trim(EditNom.P.Text),'\','\\'),'"','\"'),'''','\''')+
          ''', X='+EditNom.X.text+', R='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_recherche,'\','\\'),'"','\"'),'''','\''')+''' WHERE no='+EditNom.no.text;
     end;
  end;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add(temp);
  Principale.Query1.ExecSQL;
  // Sauvegarder les modifications
  SaveModificationTime(EditNom.I.Text);
  // UPDATE DÉCÈS si la date est il y a 100 ans !!!
  if (copy(EditNom.PD2.text,1,1)='1') and not (EditNom.PD2.text='100000000030000000000') then
     dateev:=Copy(EditNom.PD2.text,2,4)
  else
     if (copy(EditNom.SD2.text,1,1)='1') and not (EditNom.SD2.text='100000000030000000000') then
        dateev:=Copy(EditNom.SD2.text,2,4)
     else
        dateev:=FormatDateTime('YYYY',now);
  if ((StrtoInt(FormatDateTime('YYYY',now))-StrtoInt(dateev))>100) then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('UPDATE I SET V=''N'' WHERE no='+EditNom.I.Text);
     Principale.Query2.ExecSQL;
     If (Principale.MenuItem8.Checked) then
        PopulateNom;
  end;
  if not (EditNom.I.Text=Principale.Individu.Caption) then
     SaveModificationTime(Principale.Individu.Caption);
  // Modifier la ligne de l'explorateur
{  if Principale.MenuItem13.Checked then
     if EditNom.no.text<>'0' then
        begin
        for j:=1 to FormExplorateur.Index.RowCount-1 do
           if FormExplorateur.Index.Cells[0,j]=EditNom.no.text then
              begin
              FormExplorateur.Index.Cells[1,j]:=EditNom.I.text;
              if FormExplorateur.O.text='1' then
                 FormExplorateur.Index.Cells[2,j]:=DecodeName(nom,1)
              else
                 FormExplorateur.Index.Cells[2,j]:=DecodeName(nom,2);
              if FormExplorateur.O.text='1' then
                 FormExplorateur.Index.Cells[6,j]:=RemoveUTF8(i2+' '+i1);
              if FormExplorateur.O.text='2' then
                 FormExplorateur.Index.Cells[6,j]:=RemoveUTF8(i1+', '+i2);
              if (FormExplorateur.O.text='1') or (FormExplorateur.O.text='2') then
                 begin
//                 FormExplorateur.Index.SortColRow(true,6);
                 TrouveIndividu;
              end;
              break;
           end;
     end
     else
        begin
        if FormExplorateur.O.text='1' then
           temp:=RemoveUTF8(i2+' '+i1);
        if FormExplorateur.O.text='2' then
           temp:=RemoveUTF8(i1+', '+i2);
        if FormExplorateur.O.text='3' then
           temp:=geti3(EditNom.I.text);
        if FormExplorateur.O.text='4' then
           temp:=geti4(EditNom.I.text);
        if length(temp)>0 then
           begin
           j:=FormExplorateur.Index.Row;
           If AnsiCompareText((copy(FormExplorateur.Index.Cells[6,j],1,length(temp))),temp)>0 then
              begin
              while (AnsiCompareText((copy(FormExplorateur.Index.Cells[6,j],1,length(temp))),temp)>0) and (j>1) do
                 begin
                 Application.ProcessMessages;
                 j:=j-1;
              end;
              j:=j+1;
           end
           else
              begin
              while (AnsiCompareText((copy(FormExplorateur.Index.Cells[6,j],1,length(temp))),temp)<0) and
                    (j<FormExplorateur.index.rowcount-1) do
                 begin
                 Application.ProcessMessages;
                 j:=j+1;
              end;
              j:=j-1;
           end;
        end;
        FormExplorateur.Index.InsertColRow(false,j);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
        Principale.Query1.Open;
        Principale.Query1.First;
        EditNom.no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        FormExplorateur.Index.Cells[0,j]:=EditNom.no.text;
        FormExplorateur.Index.Cells[1,j]:=EditNom.I.text;
        if FormExplorateur.O.text='1' then
           FormExplorateur.Index.Cells[2,j]:=DecodeName(nom,1)
        else
           FormExplorateur.Index.Cells[2,j]:=DecodeName(nom,2);
        FormExplorateur.Index.Cells[3,j]:=ConvertDate(i3,1);
        FormExplorateur.Index.Cells[4,j]:=ConvertDate(i4,1);
        If EditNom.X.Text='1' then
           FormExplorateur.Index.Cells[5,j]:='*'
        else
           FormExplorateur.Index.Cells[5,j]:='';
        FormExplorateur.Index.Cells[6,j]:=temp;
        FormExplorateur.Index.Row:=j;
//        FormExplorateur.Index.SortColRow(true,6);
//        TrouveIndividu;
     end;
}  if EditNom.no.text='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query1.Open;
     Principale.Query1.First;
     EditNom.no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
end;

procedure TEditNom.Button1Click(Sender: TObject);
var
  code,nocode:string;
begin
  if EditNom.ActiveControl=PD then
     PDEditingDone(Sender);
  if EditNom.ActiveControl=SD then
     SDEditingDone(Sender);
  NomSaveData;
  GetCode(code,nocode);
  if (Code='X') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''N'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        begin
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''E'', '+
           nocode+', '+Principale.Query1.Fields[0].AsString+', '+
           Principale.Query1.Fields[1].AsString+', '''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Principale.Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Principale.Query2.ExecSQL;
        Principale.Query1.Next;
     end;
     GetCode(code,nocode);
  end;
  if (Code='J') then // ajoute conjoint ou conjointe
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''N'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        begin
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''E'', '+
           nocode+', '+Principale.Query1.Fields[0].AsString+', '+
           Principale.Query1.Fields[1].AsString+', '''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Principale.Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Principale.Query2.ExecSQL;
        Principale.Query1.Next;
     end;
  end;
  if (Code='P') or (Code='M') then  // ajoute père ou mère
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''N'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        begin
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''R'', '+
           nocode+', '+Principale.Query1.Fields[0].AsString+', '+
           Principale.Query1.Fields[1].AsString+', '''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Principale.Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Principale.Query2.ExecSQL;
        Principale.Query1.Next;
     end;
  end;
  if (Code='F') or (Code='S') then   // ajoute frère ou soeur
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''N'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        while (Code='F') or (Code='S') do
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''R'', '+
              nocode+', '+Principale.Query1.Fields[0].AsString+', '+
              Principale.Query1.Fields[1].AsString+', '''+
              AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Principale.Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
           Principale.Query2.ExecSQL;
           Principale.Query1.Next;
           GetCode(code,nocode);
        end;
  end;
  if (Code='I') or (Code='L') then  // ajoute fils ou fille
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT S, Q, M FROM C WHERE Y=''N'' AND N='+no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     While not Principale.Query1.EOF do
        while (Code='I') or (Code='L') do
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('INSERT INTO C (Y, N, S, Q, M) VALUES (''R'', '+
              nocode+', '+Principale.Query1.Fields[0].AsString+', '+
              Principale.Query1.Fields[1].AsString+', '''+
              AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Principale.Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
           Principale.Query2.ExecSQL;
           Principale.Query1.Next;
           GetCode(code,nocode);
        end;
  end;
end;

procedure TEditNom.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TEditNom.Ajouter1Click(Sender: TObject);
begin
  if Button1.Enabled then
     begin
     If no.text='0' then
        NomSaveData;
     PutCode('N',no.text);
     PutCode('A',no.text);
     If EditCitations.Showmodal=mrOK then
        PopulateCitations(TableauCitations,'N',No.Text);
  end;
end;

procedure TEditNom.MenuItem1Click(Sender: TObject);
var
  j:integer;
  existe:boolean;
begin
  // Ajouter Titre
  existe:=false;
  if TableauNoms.RowCount>1 then
     for j:=1 to TableauNoms.RowCount-1 do
        existe:=existe or (TableauNoms.Cells[1,j]=AnsitoUTF8(Principale.Traduction.Items[40]));
  If not existe then
     begin
     TableauNoms.RowCount:=TableauNoms.RowCount+1;
     if TableauNoms.RowCount>2 then
        for j:=TableauNoms.RowCount-1 downto 1 do
           begin
           TableauNoms.Cells[1,j]:=TableauNoms.Cells[1,j-1];
           TableauNoms.Cells[2,j]:=TableauNoms.Cells[2,j-1];
        end;
     TableauNoms.Cells[1,1]:=AnsitoUTF8(Principale.Traduction.Items[40]);
     TableauNoms.Cells[2,1]:='';
     TableauNoms.Row:=1;
     TableauNoms.Col:=2;
     TableauNoms.SetFocus;
//     EditNom.ActiveControl:=TableauNoms;
  end;
end;

procedure TEditNom.MenuItem2Click(Sender: TObject);
var
  j:integer;
  existe:boolean;
begin
  // Ajouter Prénom
  existe:=false;
  if TableauNoms.RowCount>1 then
     for j:=1 to TableauNoms.RowCount-1 do
        existe:=existe or (TableauNoms.Cells[1,j]=AnsitoUTF8(Principale.Traduction.Items[38]));
  If not existe then
     begin
     TableauNoms.RowCount:=TableauNoms.RowCount+1;
     if TableauNoms.Cells[1,1]='Titre' then
        begin
        if TableauNoms.RowCount>3 then
           for j:=TableauNoms.RowCount-1 downto 2 do
              begin
              TableauNoms.Cells[1,j]:=TableauNoms.Cells[1,j-1];
              TableauNoms.Cells[2,j]:=TableauNoms.Cells[2,j-1];
           end;
        TableauNoms.Cells[1,2]:=AnsitoUTF8(Principale.Traduction.Items[38]);
        TableauNoms.Cells[2,2]:='';
        TableauNoms.Row:=2;
     end
     else
        begin
        if TableauNoms.RowCount>2 then
           for j:=TableauNoms.RowCount-1 downto 1 do
              begin
              TableauNoms.Cells[1,j]:=TableauNoms.Cells[1,j-1];
              TableauNoms.Cells[2,j]:=TableauNoms.Cells[2,j-1];
           end;
        TableauNoms.Cells[1,1]:=AnsitoUTF8(Principale.Traduction.Items[38]);
        TableauNoms.Cells[2,1]:='';
        TableauNoms.Row:=1;
     end;
     TableauNoms.Col:=2;
     TableauNoms.SetFocus;
//     EditNom.ActiveControl:=TableauNoms;
  end;
end;

procedure TEditNom.MenuItem3Click(Sender: TObject);
var
  j:integer;
  existe:boolean;
begin
  // Ajouter Nom
  existe:=false;
  if TableauNoms.RowCount>1 then
     for j:=1 to TableauNoms.RowCount-1 do
        existe:=existe or (TableauNoms.Cells[1,j]=AnsitoUTF8(Principale.Traduction.Items[37]));
  If not existe then
     begin
     TableauNoms.RowCount:=TableauNoms.RowCount+1;
     if TableauNoms.Cells[1,TableauNoms.RowCount-2]=AnsitoUTF8(Principale.Traduction.Items[39]) then
        begin
        TableauNoms.Cells[1,TableauNoms.RowCount-1]:=TableauNoms.Cells[1,TableauNoms.RowCount-2];
        TableauNoms.Cells[2,TableauNoms.RowCount-1]:=TableauNoms.Cells[2,TableauNoms.RowCount-2];
        TableauNoms.Cells[1,TableauNoms.RowCount-2]:=AnsitoUTF8(Principale.Traduction.Items[37]);
        TableauNoms.Cells[2,TableauNoms.RowCount-2]:='';
        TableauNoms.Row:=TableauNoms.RowCount-2;
     end
     else
        begin
        TableauNoms.Cells[1,TableauNoms.RowCount-1]:=AnsitoUTF8(Principale.Traduction.Items[37]);
        TableauNoms.Cells[2,TableauNoms.RowCount-1]:='';
        TableauNoms.Row:=TableauNoms.RowCount-1;
     end;
     TableauNoms.Col:=2;
     TableauNoms.SetFocus;
//     EditNom.ActiveControl:=TableauNoms;
  end;
end;

procedure TEditNom.MenuItem4Click(Sender: TObject);
var
  existe:boolean;
begin
  // Ajouter Suffixe
  if TableauNoms.RowCount>1 then
     existe:=TableauNoms.Cells[1,TableauNoms.RowCount-1]=AnsitoUTF8(Principale.Traduction.Items[39])
  else
     existe:=false;
  If not existe then
     begin
     TableauNoms.RowCount:=TableauNoms.RowCount+1;
     TableauNoms.Cells[1,TableauNoms.RowCount-1]:=AnsitoUTF8(Principale.Traduction.Items[39]);
     //TableauNoms.Cells[2,TableauNoms.RowCount-1]:='';
     TableauNoms.Row:=TableauNoms.RowCount-1;
     TableauNoms.Col:=2;
     TableauNoms.SetFocus;
//     EditNom.ActiveControl:=TableauNoms;
  end;
end;

procedure TEditNom.MenuItem5Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditNom.MenuItem6Click(Sender: TObject);
var
    j,k,pos1,pos2:integer;
    found:boolean;
    temp,nom,titre,prenom,suffixe:string;
begin
  j:=0;
  found:=false;
  if EditNom.ActiveControl.Name='TableauNoms' then
     begin
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='N' then
           begin
           // Traitement de F3 pour les noms }
           temp:=Principale.DataHist.Cells[1,j];
           if copy(temp,1,5)='!TMG|' then
              begin
              temp := copy(temp,6,length(temp));
              nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
              temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
              titre := trim(copy(temp,1,AnsiPos('|',temp)-1));
              temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
              prenom := trim(copy(temp,1,AnsiPos('|',temp)-1));
              temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
              suffixe := trim(copy(temp,1,AnsiPos('|',temp)-1));
           end
           else
              begin
              titre:='';
              prenom:='';
              nom:='';
              suffixe:='';
              // Traiter les noms avec <N=TITRE></N>...
              Pos1:=AnsiPos('<Titre>',temp)+7;
              Pos2:=AnsiPos('</Titre>',temp);
              if (Pos1+Pos2)>7 then
                 titre:=Copy(temp,Pos1,Pos2-Pos1);
              Pos1:=AnsiPos('<Prénom>',temp)+9;     // 9 car le 'é' prends 2 position en ANSI
              Pos2:=AnsiPos('</Prénom>',temp);
              if (Pos1+Pos2)>9 then
                 prenom:=Copy(temp,Pos1,Pos2-Pos1);
              Pos1:=AnsiPos('<Nom>',temp)+5;
              Pos2:=AnsiPos('</Nom>',temp);
              if (Pos1+Pos2)>5 then
                 nom:=Copy(temp,Pos1,Pos2-Pos1);
              Pos1:=AnsiPos('<Suffixe>',temp)+9;
              Pos2:=AnsiPos('</Suffixe>',temp);
              if (Pos1+Pos2)>9 then
                 Suffixe:=Copy(temp,Pos1,Pos2-Pos1);
           end;
           k:=1;
           if length(titre)>0 then
              k:=k+1;
           if length(prenom)>0 then
              k:=k+1;
           if length(nom)>0 then
              k:=k+1;
           if length(suffixe)>0 then
              k:=k+1;
           TableauNoms.RowCount:=k;
           k:=1;
           if length(titre)>0 then
              begin
              TableauNoms.Cells[1,k]:='Titre';
              TableauNoms.Cells[2,k]:=titre;
              k:=k+1;
           end;
           if length(prenom)>0 then
              begin
              TableauNoms.Cells[1,k]:='Prénom';
              TableauNoms.Cells[2,k]:=prenom;
              k:=k+1;
           end;
           if length(nom)>0 then
              begin
              TableauNoms.Cells[1,k]:='Nom';
              TableauNoms.Cells[2,k]:=nom;
              k:=k+1;
           end;
           if length(suffixe)>0 then
              begin
              TableauNoms.Cells[1,k]:='Suffixe';
              TableauNoms.Cells[2,k]:=Suffixe;
              k:=k+1;
           end;
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='N' then
              begin
              // Traitement de F3 pour les noms }
              temp:=Principale.DataHist.Cells[1,j];
              if copy(temp,1,5)='!TMG|' then
                 begin
                 temp := copy(temp,6,length(temp));
                 nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
                 temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
                 titre := trim(copy(temp,1,AnsiPos('|',temp)-1));
                 temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
                 prenom := trim(copy(temp,1,AnsiPos('|',temp)-1));
                 temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
                 suffixe := trim(copy(temp,1,AnsiPos('|',temp)-1));
              end
              else
                 begin
                 titre:='';
                 prenom:='';
                 nom:='';
                 suffixe:='';
                 // Traiter les noms avec <N=TITRE></N>...
                 Pos1:=AnsiPos('<Titre>',temp)+7;
                 Pos2:=AnsiPos('</Titre>',temp);
                 if (Pos1+Pos2)>7 then
                    titre:=Copy(temp,Pos1,Pos2-Pos1);
                 Pos1:=AnsiPos('<Prénom>',temp)+9;     // 9 car le 'é' prends 2 position en ANSI
                 Pos2:=AnsiPos('</Prénom>',temp);
                 if (Pos1+Pos2)>9 then
                    prenom:=Copy(temp,Pos1,Pos2-Pos1);
                 Pos1:=AnsiPos('<Nom>',temp)+5;
                 Pos2:=AnsiPos('</Nom>',temp);
                 if (Pos1+Pos2)>5 then
                    nom:=Copy(temp,Pos1,Pos2-Pos1);
                 Pos1:=AnsiPos('<Suffixe>',temp)+9;
                 Pos2:=AnsiPos('</Suffixe>',temp);
                 if (Pos1+Pos2)>9 then
                    Suffixe:=Copy(temp,Pos1,Pos2-Pos1);
              end;
              k:=1;
              if length(titre)>0 then
                 k:=k+1;
              if length(prenom)>0 then
                 k:=k+1;
              if length(nom)>0 then
                 k:=k+1;
              if length(suffixe)>0 then
                 k:=k+1;
              TableauNoms.RowCount:=k;
              k:=1;
              if length(titre)>0 then
                 begin
                 TableauNoms.Cells[1,k]:='Titre';
                 TableauNoms.Cells[2,k]:=titre;
                 k:=k+1;
              end;
              if length(prenom)>0 then
                 begin
                 TableauNoms.Cells[1,k]:='Prénom';
                 TableauNoms.Cells[2,k]:=prenom;
                 k:=k+1;
              end;
              if length(nom)>0 then
                 begin
                 TableauNoms.Cells[1,k]:='Nom';
                 TableauNoms.Cells[2,k]:=nom;
                 k:=k+1;
              end;
              if length(suffixe)>0 then
                 begin
                 TableauNoms.Cells[1,k]:='Suffixe';
                 TableauNoms.Cells[2,k]:=Suffixe;
                 k:=k+1;
              end;
              found:=true;
              break;
           end;
        end;
     end;
  end;
    if EditNom.ActiveControl.Name='SD' then
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
    if EditNom.ActiveControl.Name='PD' then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
          begin
          if Principale.DataHist.Cells[0,j]='PD' then
             begin
             PD.text:=Principale.DataHist.Cells[1,j];
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
                PD.text:=Principale.DataHist.Cells[1,j];
                PDEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditNom.ActiveControl.Name='I' then
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
             if Principale.DataHist.Cells[0,j]='A' then
                begin
                I.text:=Principale.DataHist.Cells[1,j];
                IEditingDone(Sender);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if EditNom.ActiveControl.Name='P' then
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
    if EditNom.ActiveControl.Name='M' then
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

procedure TEditNom.PDblClick(Sender: TObject);
begin
  P2.Visible:=true;
  P.Visible:=false;
end;

procedure TEditNom.PDEditingDone(Sender: TObject);
begin
  PD2.Text:=InterpreteDate(PD.Text,1);
  PD.Text:=ConvertDate(PD2.Text,1);
  SD.Text:=PD.Text;
  SD2.Text:=PD2.Text;
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='PD';
  Principale.DataHist.Cells[1,0]:=PD2.Text;
end;

procedure TEditNom.PEditingDone(Sender: TObject);
begin
  If length(P.Text)=0 then
     P.Text:=P1.Text;
  Label6.Visible:=(P.Text=P1.Text);
  P2.Text:=DecodePhrase(Principale.Individu.Caption,'TEMOIN',P.Text,'N',No.Text);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='P';
  Principale.DataHist.Cells[1,0]:=P.Text;
end;

procedure TEditNom.SDEditingDone(Sender: TObject);
begin
  SD2.Text:=InterpreteDate(SD.Text,1);
  SD.Text:=ConvertDate(SD2.Text,1);
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='SD';
  Principale.DataHist.Cells[1,0]:=SD2.Text;
end;

procedure TEditNom.Supprimer1Click(Sender: TObject);
begin
  If TableauCitations.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[31])+
        TableauCitations.Cells[1,TableauCitations.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),Pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM C WHERE no='+TableauCitations.Cells[0,TableauCitations.Row]);
        Principale.Query1.ExecSQL;
        TableauCitations.DeleteRow(TableauCitations.Row);
        SaveModificationTime(I.Text);
     end;
end;

end.

