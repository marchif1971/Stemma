unit AjouteBapteme;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, StrUtils, FMUtils, Noms, Parents, Evenements;

type

  { TAjouteBapt }

  TAjouteBapt = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit3: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    EditSexe: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit16EditingDone(Sender: TObject);
    procedure Edit17DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit23DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit29DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit6EditingDone(Sender: TObject);
    procedure Edit7DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit8DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure EditSexeDblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  AjouteBapt: TAjouteBapt;

implementation

uses
  unit1;

{$R *.lfm}

{ TAjouteBapt }

procedure TAjouteBapt.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[434]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[435]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[441]); // Registre
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[442]); // Année
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[443]); // Feuillet
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[444]); // Acte
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[136]); // Date
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[445]); // # de célébrant
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[446]); // # de baptisé
  Label9.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[447]); // Date de naissance
  Label11.Caption:=AnsitoUTF8(Principale.Traduction.Items[448]); // # de père
  Label12.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label13.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label14.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label15.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  Label16.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[452]); // # de mère
  Label18.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label20.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label21.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  Label22.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label23.Caption:=AnsitoUTF8(Principale.Traduction.Items[454]); // # de parrain
  Label24.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label25.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label26.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label27.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  Label28.Caption:=AnsitoUTF8(Principale.Traduction.Items[149]); // Usager:
  Label29.Caption:=AnsitoUTF8(Principale.Traduction.Items[455]); // # de marraine
  Label30.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label31.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label32.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label33.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  Label34.Caption:=AnsitoUTF8(Principale.Traduction.Items[456]); // Commentaires
  CheckBox1.Caption:=AnsitoUTF8(Principale.Traduction.Items[450]); // Présent
  CheckBox2.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  CheckBox3.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  CheckBox4.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  EditSexe.Hint:='M';
  EditSexe.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[440]); // Interpréter
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]); // Ok
  Button3.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]); // Annuler
  Edit1.Text:='';
  Try
     Edit5.Text:='B'+inttostr(strtoint(copy(Edit5.Text,2,Length(Edit5.Text)))+1);
  except
     Edit5.Text:='';
  end;
  Edit8.Text:='';
  Edit9.Text:='';
  Edit10.Text:='';
  Edit11.Text:='';
  Edit12.Text:='';
  Edit13.Text:='';
  Edit14.Text:='';
  Edit15.Text:='';
  Edit16.Text:='';
  Edit17.Text:='';
  Edit18.Text:='';
  Edit19.Text:='';
  Edit20.Text:='';
  Edit21.Text:='';
  Edit22.Text:='';
  Edit23.Text:='';
  Edit24.Text:='';
  Edit25.Text:='';
  Edit26.Text:='';
  Edit27.Text:='';
  Edit29.Text:='';
  Edit30.Text:='';
  Edit31.Text:='';
  Edit32.Text:='';
  Edit33.Text:='';
  Edit34.Text:='';
  CheckBox1.Checked:=false;
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
  GetFormPosition(Sender as TForm,0,0,Height,Width);
end;

procedure TAjouteBapt.Button2Click(Sender: TObject); // Ok
var
  temp,no_nom,no_eve,no_bapt,nom_personne,X,i3,i4,lieu, annee1, annee2, usager:string;
  registre, annee, feuillet, acte, date,naissance,b_prenom,residence,commentaires, Sexe:string;
  p_titre,p_prenom,p_nom,p_suffixe,p_metier,p_present,p_signature:string;
  pr_titre,pr_prenom,pr_nom,pr_suffixe,pr_metier,pr_signature:string;
  m_titre,m_prenom,m_nom,m_suffixe,m_metier,m_present,m_signature:string;
  mr_titre,mr_prenom,mr_nom,mr_suffixe,mr_signature:string;
  i,pretre,baptise,pere,mere,parrain,marraine:integer;
begin
  registre:=Edit2.text;
  lieu:=EstimatePlace(registre,registre);
  annee:=Edit3.text;
  feuillet:=Edit4.Text;
  acte:=Edit5.Text;
  date:=InterpreteDate(Edit6.Text,1);
  try
     pretre:=strtoint(Edit7.Text);
  except
     pretre:=0;
  end;
  try
     baptise:=strtoint(Edit8.Text);
  except
     baptise:=0;
  end;
  b_prenom:=Edit9.Text;
  naissance:=Edit10.text;
  Sexe:=EditSexe.Hint;
  try
     pere:=strtoint(Edit11.text);
  except
     pere:=0;
  end;
  p_titre:=Edit12.Text;
  p_prenom:=Edit13.Text;
  p_nom:=Edit14.Text;
  p_suffixe:=Edit15.Text;
  p_metier:=Edit16.Text;
  if CheckBox1.Checked then
     p_present:='X'
  else
     p_present:='';
  if CheckBox2.Checked then
     p_signature:='X'
  else
     p_signature:='';
  try
     mere:=strtoint(Edit17.Text);
  except
     mere:=0;
  end;
  m_titre:=Edit18.Text;
  m_prenom:=Edit19.Text;
  m_nom:=Edit20.Text;
  m_suffixe:=Edit21.Text;
  residence:=EstimatePlace(Edit22.Text,lieu);
  try
     parrain:=strtoint(Edit23.Text);
  except
     parrain:=0;
  end;
  pr_titre:=Edit24.Text;
  pr_prenom:=Edit25.Text;
  pr_nom:=Edit26.Text;
  pr_suffixe:=Edit27.Text;
  if CheckBox3.Checked then
     pr_signature:='X'
  else
     pr_signature:='';
  try
     marraine:=strtoint(Edit29.Text);
  except
     marraine:=0;
  end;
  mr_titre:=Edit30.Text;
  mr_prenom:=Edit31.Text;
  mr_nom:=Edit32.Text;
  mr_suffixe:=Edit33.Text;
  if CheckBox4.Checked then
     mr_signature:='X'
  else
     mr_signature:='';
  commentaires:=Edit34.Text;
  usager:=Edit28.Text;
  nom_personne:=CodeName('',b_prenom,p_nom,'');
  // modifie ou ajoute le baptisé
  if (baptise=0) then // ajoute le baptisé
     begin
     // ajoute l'individu du bon sexe
     // cherche le prochain numéro vide
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        baptise:=0
     else
        baptise:=Principale.Query2.Fields[0].AsInteger;
     // Créé l'individu
     Principale.Query1.SQL.Clear;
     if (baptise=0) then
        Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('+sexe+', ''N'', 0)')
     else
        Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(baptise)+''', '''+sexe+''', ''N'', 0)');
     Principale.Query1.ExecSQL;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
     Principale.Query1.Open;
     Principale.Query1.First;
     if (baptise=0) then
        baptise:=Principale.Query1.Fields[10].AsInteger-1;
  end;
  // Créé ou modifie le nom
  // cherche si le nom existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(baptise)+''' AND N='''+nom_personne+'''');
  Principale.Query1.Open;
  // cherche si un nom principal existe
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(baptise)+' AND X=1');
  Principale.Query2.Open;
  If Principale.Query2.EOF then
     begin
     X:='1';
     i3:=InterpreteDate(naissance,1);
     i4:='';
  end
  else
      begin
      X:='0';
      i3:=InterpreteDate(naissance,1);
      i4:=Principale.Query2.Fields[3].AsString;
  end;
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter le nom
     temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (21, '+
           inttostr(baptise)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(b_prenom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(p_nom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+date+ // PD
           ''', '''+date+ // SD
           ''', '''', '''+i3+''','''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(b_prenom+' '+p_nom,'\','\\'),'"','\"'),'''','\''')+''')'
  else  // on doit modifier le nom
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[2].AsString;
     temp:='UPDATE n SET Y=21 WHERE no='+no_nom;
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  // Ajouter une source pour le nom
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute sa naissance
  // cherche si la naissance existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e WHERE I='''+inttostr(baptise)+
                                    ''' AND e.X=1 AND w.X=1 AND (e.Y=100 or e.Y=101)');
  Principale.Query1.Open;
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter la naissance
     temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (100, '''+i3+''', '''+i3+''', 1, '''', 1)'
  else // on doit modifier la naissance
     begin
     no_nom:=Principale.Query1.Fields[0].AsString;
     temp:='UPDATE e SET PD='''+i3+''', SD='''+i3+''' WHERE no='+no_nom;
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(baptise)+', '+no_nom+', 1, '''', ''ENFANT'')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
  end;
  // ajoute une source pour l'événement
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute son baptême
  // cherche si le baptême existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e WHERE I='''+inttostr(baptise)+
                                    ''' AND e.X=1 AND w.X=1 AND e.Y=110');
  Principale.Query1.Open;
  no_bapt:='';
  If Principale.Query1.EOF then // on doit ajouter le baptême
     temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (110, '''+date+''', '''+date+''', '+lieu+', '''', 0)'
  else // on doit modifier le baptême
     begin
     no_bapt:=Principale.Query1.Fields[0].AsString;
     temp:='UPDATE e SET PD='''+date+''', SD='''+date+''', L='+lieu+', X=0 WHERE no='+no_bapt;
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  if (no_bapt='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_bapt:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(baptise)+', '+no_bapt+', 1, '''', ''ENFANT'')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
  end;
  // ajoute une source pour l'événement
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_bapt+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // affiche la modification d'événement
  // ajoute ses parents
  // si le # de père est pas là
  nom_personne:=CodeName(p_titre,p_prenom,p_nom,p_suffixe);
  if (pere=0) then // ajoute le père
     begin
     // ajoute l'individu du bon sexe
     // cherche le prochain numéro vide
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        pere:=0
     else
        pere:=Principale.Query2.Fields[0].AsInteger;
     // Créé l'individu
     Principale.Query1.SQL.Clear;
     if (pere=0) then
        Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''M'', ''N'', 0)')
     else
        Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(pere)+''', ''M'', ''N'', 0)');
     Principale.Query1.ExecSQL;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
     Principale.Query1.Open;
     Principale.Query1.First;
     if (pere=0) then
        pere:=Principale.Query1.Fields[10].AsInteger-1;
  end;
  // Créé ou modifie le nom
  // cherche si le nom existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(pere)+''' AND N='''+nom_personne+'''');
  Principale.Query1.Open;
  // cherche si un nom principal existe
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(pere)+' AND X=1');
  Principale.Query2.Open;
  If Principale.Query2.EOF then
     begin
     X:='1';
     i3:='';
     i4:='';
  end
  else
     begin
     X:='0';
     i3:=Principale.Query2.Fields[2].AsString;
     i4:=Principale.Query2.Fields[3].AsString;
  end;
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter le nom
     temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
           inttostr(pere)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(p_prenom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(p_nom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+InterpreteDate('',1)+
           ''', '''+InterpreteDate('',1)+
           ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(p_titre+' '+p_prenom+' '+p_nom+' '+p_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
  else  // on doit modifier le nom
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[2].AsString;
     temp:='UPDATE n SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  // Ajouter une source pour le nom
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute la relation au père
  // cherche si la relation existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(baptise)+' AND B='+inttostr(pere));
  Principale.Query1.Open;
  X:='1';
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter la relation
     temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(baptise)+
           ', '+inttostr(pere)+', '''', '+X+', '''', '''+interpretedate(naissance,1)+''')'
  else  // on doit modifier la relation
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[0].AsString;
     temp:='UPDATE r SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  // ajoute la référence pour la relation
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // si le # de mère est pas là
  nom_personne:=CodeName(m_titre,m_prenom,m_nom,m_suffixe);
  if (mere=0) then // ajoute la mère
     begin
     // ajoute l'individu du bon sexe
     // cherche le prochain numéro vide
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        mere:=0
     else
        mere:=Principale.Query2.Fields[0].AsInteger;
     // Créé l'individu
     Principale.Query1.SQL.Clear;
     if (mere=0) then
        Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''F'', ''N'', 0)')
     else
        Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(mere)+''', ''F'', ''N'', 0)');
     Principale.Query1.ExecSQL;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
     Principale.Query1.Open;
     Principale.Query1.First;
     if (mere=0) then
        mere:=Principale.Query1.Fields[10].AsInteger-1;
  end;
  // Créé ou modifie le nom
  // cherche si le nom existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(mere)+''' AND N='''+nom_personne+'''');
  Principale.Query1.Open;
  // cherche si un nom principal existe
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(mere)+' AND X=1');
  Principale.Query2.Open;
  If Principale.Query2.EOF then
     begin
     X:='1';
     i3:='';
     i4:='';
  end
  else
      begin
      X:='0';
      i3:=Principale.Query2.Fields[2].AsString;
      i4:=Principale.Query2.Fields[3].AsString;
  end;
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter le nom
     temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
           inttostr(mere)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_prenom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_nom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+InterpreteDate('',1)+
           ''', '''+InterpreteDate('',1)+
           ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_titre+' '+m_prenom+' '+m_nom+' '+m_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
  else  // on doit modifier le nom
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[2].AsString;
     temp:='UPDATE n SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  // Ajouter une source pour le nom
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute la relation à la mère
  // cherche si la relation existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(baptise)+' AND B='+inttostr(mere));
  Principale.Query1.Open;
  X:='1';
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter la relation
     temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(baptise)+
           ', '+inttostr(mere)+', '''', '+X+', '''', '''+interpretedate(naissance,1)+''')'
  else  // on doit modifier la relation
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[0].AsString;
     temp:='UPDATE r SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  // ajoute la référence pour la relation
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute le métier du père
  if length(p_metier)>0 then
     begin
     // cherche si l'occupation existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT e.no, e.PD FROM e JOIN w on e.no=w.E WHERE e.M='''+p_metier+''' AND e.Y=511 AND w.I='+inttostr(pere));
     Principale.Query1.Open;
     no_nom:='';
     If Principale.Query1.EOF then // on doit ajouter l'occupation
        begin
        temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''+interpretedate(annee,1)+
              ''', '''+interpretedate(annee,1)+''', 1, '''+p_metier+''', 0)';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        if (no_nom='') then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
           Principale.Query2.Open;
           Principale.Query2.First;
           no_nom:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
        end;
        // et ajouter le temoin à l'occupation
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_nom+', 1, '''', ''EMPLOYÉ'')';
     end
     else  // on doit modifier l'occupation
        begin
        no_nom:=Principale.Query1.Fields[0].AsString;
        try
           annee1:=copy(Principale.Query1.Fields[1].AsString,2,4);
           annee2:=copy(Principale.Query1.Fields[1].AsString,12,4);
           if (strtoint(annee2)=0) then
              if strtoint(annee1)>=strtoint(annee) then
                 begin
                 annee2:=annee1;
                 annee1:=annee;
              end
              else
                 annee2:=annee
           else
              begin
              if (strtoint(annee1)>=strtoint(annee)) then
                 annee1:=annee;
              if (strtoint(annee2)<=strtoint(annee)) then
                 annee2:=annee;
           end;
           if annee1=annee2 then
              annee1:=interpretedate(annee,1)
           else
              annee1:=interpretedate(annee1+'a'+annee2,1)
        except
          annee1:=interpretedate(annee,1);
        end;
        temp:='UPDATE e SET PD='''+annee1+
                        ''',SD='''+annee1+''' WHERE no='+no_nom;  // On change PD SD
     end;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     if (no_nom='') then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     end;
     // ajoute la référence pour l'occupation
     Principale.Query1.SQL.Clear;
     temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
     Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_nom+', 100, 3, '''+temp+''')');
     Principale.Query1.ExecSQL;
  end;
  // modifie ou ajoute la résidence des parents si 'cette paroisse'
  if (length(residence)>0) then
     begin
     // cherche si la residence existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                               +residence+' AND e.Y=550 AND w1.I='+inttostr(pere)+' AND w2.I='+inttostr(mere)+') HAVING temp=2');
     Principale.Query1.Open;
     no_nom:='';
     If Principale.Query1.EOF then // on doit ajouter la résidence
        begin
        temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
              ''', '''+interpretedate(annee,1)+''', '+residence+', '''', 0)';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        if (no_nom='') then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
           Principale.Query2.Open;
           Principale.Query2.First;
           no_nom:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
        end;
        // et ajouter le temoin à la résidence
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_nom+', 1, '''', ''TEMOIN'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mere)+', '+no_nom+', 1, '''', ''TEMOIN'')';
     end
     else  // on doit modifier la residence
        begin
        no_nom:=Principale.Query1.Fields[0].AsString;
        try
           annee1:=copy(Principale.Query1.Fields[1].AsString,2,4);
           annee2:=copy(Principale.Query1.Fields[1].AsString,12,4);
           if (strtoint(annee2)=0) then
              if strtoint(annee1)>=strtoint(annee) then
                 begin
                 annee2:=annee1;
                 annee1:=annee;
              end
              else
                 annee2:=annee
           else
              begin
              if (strtoint(annee1)>=strtoint(annee)) then
                 annee1:=annee;
              if (strtoint(annee2)<=strtoint(annee)) then
                 annee2:=annee;
           end;
           if annee1=annee2 then
              annee1:=interpretedate(annee,1)
           else
              annee1:=interpretedate(annee1+'a'+annee2,1)
        except
          annee1:=interpretedate(annee,1);
        end;
        temp:='UPDATE e SET PD='''+annee1+
                        ''',SD='''+annee1+''' WHERE no='+no_nom;  // On change PD SD
     end;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     if (no_nom='') then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
     end;
     // ajoute la référence pour la residence
     Principale.Query1.SQL.Clear;
     temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
     Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_nom+', 100, 3, '''+temp+''')');
     Principale.Query1.ExecSQL;
  end;
  // ajoute le parrain
  nom_personne:=CodeName(pr_titre,pr_prenom,pr_nom,pr_suffixe);
  if (parrain=0) then // ajoute le parrain
     begin
     // ajoute l'individu du bon sexe
     // cherche le prochain numéro vide
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        parrain:=0
     else
        parrain:=Principale.Query2.Fields[0].AsInteger;
     // Créé l'individu
     Principale.Query1.SQL.Clear;
     if (parrain=0) then
        Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''M'', ''N'', 0)')
     else
        Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(parrain)+''', ''M'', ''N'', 0)');
     Principale.Query1.ExecSQL;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
     Principale.Query1.Open;
     Principale.Query1.First;
     if (parrain=0) then
        parrain:=Principale.Query1.Fields[10].AsInteger-1;
  end;
  // Créé ou modifie le nom
  // cherche si le nom existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(parrain)+''' AND N='''+nom_personne+'''');
  Principale.Query1.Open;
  // cherche si un nom principal existe
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(parrain)+' AND X=1');
  Principale.Query2.Open;
  If Principale.Query2.EOF then
     begin
     X:='1';
     i3:='';
     i4:='';
  end
  else
     begin
     X:='0';
     i3:=Principale.Query2.Fields[2].AsString;
     i4:=Principale.Query2.Fields[3].AsString;
  end;
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter le nom
     temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
           inttostr(parrain)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pr_prenom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pr_nom,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+InterpreteDate('',1)+
           ''', '''+InterpreteDate('',1)+
           ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pr_titre+' '+pr_prenom+' '+pr_nom+' '+pr_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
  else  // on doit modifier le nom
     begin
     X:=Principale.Query1.Fields[3].AsString;
     no_nom:=Principale.Query1.Fields[2].AsString;
     temp:='UPDATE n SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  // Ajouter une source pour le nom
  if (no_nom='') then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  Principale.Query1.SQL.Clear;
  temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
  Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_nom+', 100, 3, '''+temp+''')');
  Principale.Query1.ExecSQL;
  // modifie ou ajoute la relation au parrain
  // cherche si la relation existe
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=12 AND A='+inttostr(baptise)+' AND B='+inttostr(parrain));
  Principale.Query1.Open;
  X:='0';
  no_nom:='';
  If Principale.Query1.EOF then // on doit ajouter la relation
     temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (12, '+inttostr(baptise)+
           ', '+inttostr(parrain)+', '''', '+X+', '''', '''+interpretedate(naissance,1)+''')'
  else  // on doit modifier la relation
     begin
     X:=Principale.Query2.Fields[1].AsString;
     no_nom:=Principale.Query1.Fields[0].AsString;
     temp:='UPDATE r SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add(temp);
  Principale.Query2.ExecSQL;
  if (no_nom='') then
     begin
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
      Principale.Query1.Open;
      Principale.Query1.First;
      no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
   end;
   // ajoute la référence pour la relation
   Principale.Query1.SQL.Clear;
   temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
   Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_nom+', 100, 3, '''+temp+''')');
   Principale.Query1.ExecSQL;
   // ajoute la marraine
   nom_personne:=CodeName(mr_titre,mr_prenom,mr_nom,mr_suffixe);
   if (marraine=0) then // ajoute la marraine
      begin
      // ajoute l'individu du bon sexe
      // cherche le prochain numéro vide
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
      Principale.Query2.Open;
      If Principale.Query2.EOF then
         marraine:=0
      else
         marraine:=Principale.Query2.Fields[0].AsInteger;
      // Créé l'individu
      Principale.Query1.SQL.Clear;
      if (marraine=0) then
         Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''F'', ''N'', 0)')
      else
         Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(marraine)+''', ''F'', ''N'', 0)');
      Principale.Query1.ExecSQL;
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
      Principale.Query1.Open;
      Principale.Query1.First;
      if (marraine=0) then
         marraine:=Principale.Query1.Fields[10].AsInteger-1;
   end;
   // Créé ou modifie le nom
   // cherche si le nom existe
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(marraine)+''' AND N='''+nom_personne+'''');
   Principale.Query1.Open;
   // cherche si un nom principal existe
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(marraine)+' AND X=1');
   Principale.Query2.Open;
   If Principale.Query2.EOF then
      begin
      X:='1';
      i3:='';
      i4:='';
   end
   else
      begin
      X:='0';
      i3:=Principale.Query2.Fields[2].AsString;
      i4:=Principale.Query2.Fields[3].AsString;
   end;
   no_nom:='';
   If Principale.Query1.EOF then // on doit ajouter le nom
      temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
            inttostr(marraine)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
            ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mr_prenom,'\','\\'),'"','\"'),'''','\''')+
            ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mr_nom,'\','\\'),'"','\"'),'''','\''')+
            ''', '''+InterpreteDate('',1)+
            ''', '''+InterpreteDate('',1)+
            ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mr_titre+' '+mr_prenom+' '+mr_nom+' '+mr_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
   else  // on doit modifier le nom
      begin
      X:=Principale.Query1.Fields[3].AsString;
      no_nom:=Principale.Query1.Fields[2].AsString;
      temp:='UPDATE n SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
   end;
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   // Ajouter une source pour le nom
   if (no_nom='') then
      begin
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
      Principale.Query1.Open;
      Principale.Query1.First;
      no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
   end;
   Principale.Query1.SQL.Clear;
   temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
   Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_nom+', 100, 3, '''+temp+''')');
   Principale.Query1.ExecSQL;
   // modifie ou ajoute la relation a la marraine
   // cherche si la relation existe
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=12 AND A='+inttostr(baptise)+' AND B='+inttostr(marraine));
   Principale.Query1.Open;
   X:='0';
   no_nom:='';
   If Principale.Query1.EOF then // on doit ajouter la relation
      temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (12, '+inttostr(baptise)+
            ', '+inttostr(marraine)+', '''', '+X+', '''', '''+interpretedate(naissance,1)+''')'
   else  // on doit modifier la relation
      begin
      X:=Principale.Query2.Fields[1].AsString;
      no_nom:=Principale.Query1.Fields[0].AsString;
      temp:='UPDATE r SET X='+X+' WHERE no='+no_nom;  // En fait on ne fait pas de modification
   end;
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   if (no_nom='') then
      begin
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
      Principale.Query1.Open;
      Principale.Query1.First;
      no_nom:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
   end;
   // ajoute la référence pour la relation
   Principale.Query1.SQL.Clear;
   temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
   Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_nom+', 100, 3, '''+temp+''')');
   Principale.Query1.ExecSQL;
   // modifier ou ajouter le mariage des parents du baptisé
   // cherche si le mariage existe
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.Add('SELECT w.e, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.X=1 AND w.E IN (SELECT e.no FROM e JOIN w w1 ON e.no=w1.E JOIN w w2 on e.no=w2.E WHERE e.Y=300 AND w1.I='
                              +inttostr(pere)+' AND w2.I='+inttostr(mere)+' AND e.X=1 AND w1.X=1 AND w2.X=1) HAVING temp=2');
   Principale.Query1.Open;
   no_eve:='';
   If Principale.Query1.EOF then // on doit ajouter le mariage
      temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (300, '''', '''', 1, '''', 1)'
   else // on doit modifier le mariage
      begin
      no_eve:=Principale.Query1.Fields[0].AsString;
      temp:='UPDATE e SET X=1 WHERE no='+no_eve; // en fait pas de modification
   end;
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   if (no_eve='') then
      begin
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
      Principale.Query1.Open;
      Principale.Query1.First;
      no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
      temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_eve+', 1, '''', ''CONJOINT'')';
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.Add(temp);
      Principale.Query2.ExecSQL;
      temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mere)+', '+no_eve+', 1, '''', ''CONJOINT'')';
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.Add(temp);
      Principale.Query2.ExecSQL;
   end;
   // ajouter la présence des parrain/marraine/père au baptême
   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(parrain)+', '+no_bapt+', 0, '''', ''TEMOIN'')';
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(marraine)+', '+no_bapt+', 0, '''', ''TEMOIN'')';
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   if length(p_present)>0 then
      begin
      temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_bapt+', 0, '''', ''TEMOIN'')';
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.Add(temp);
      Principale.Query2.ExecSQL;
   end;
   // ajouter le célébrant
   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pretre)+', '+no_bapt+', 0, '''', ''CELEBRANT'')';
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add(temp);
   Principale.Query2.ExecSQL;
   SaveModificationTime(inttostr(baptise));
   // Affiche la personne
   Principale.Individu.Caption:=inttostr(baptise);
   PopulateNom;
   PopulateEvenements;
   PopulateParents;
   SaveFormPosition(TButton(Sender).Parent as TForm);
   Close;
end;

procedure TAjouteBapt.Button1Click(Sender: TObject);    // Interpréter la ligne
var
   ligne:TStringList;
   filename:string;
begin
  ligne:=TStringList.Create;
  ligne.text:=ReplaceText(Edit1.Text,#9,#13#10);
  if ligne.Count=38 then
     begin
     Edit2.Text:=ligne.strings[0];
     Edit3.Text:=ligne.strings[1];
     Edit4.Text:=ligne.strings[2];
     Edit5.Text:=ligne.strings[3];
     Edit6.Text:=InterpreteDate(AnsiReplaceStr(ligne.strings[4],'-','.'),0);
     Edit7.Text:=ligne.strings[5];
     Edit8.Text:=ligne.strings[6];
     Edit9.Text:=ligne.strings[7];
     Edit10.Text:=InterpreteDate(AnsiReplaceStr(ligne.strings[8],'-','.'),0);
     if ligne.strings[9]='M' then
        EditSexe.Hint:='M'
     else
        if ligne.strings[9]='F' then
           EditSexe.Hint:='F'
        else
           EditSexe.Hint:='?';
     Case EditSexe.Hint[1] of
        'F':begin
            filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
            end;
        '?':begin
            filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
            end;
        'M':begin
            filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
            end;
     end;
     EditSexe.Picture.Icon.LoadFromFile(filename);
     Edit11.Text:=ligne.strings[10];
     Edit12.Text:=ligne.strings[11];
     Edit13.Text:=ligne.strings[12];
     Edit14.Text:=ligne.strings[13];
     Edit15.Text:=ligne.strings[14];
     Edit16.Text:=ligne.strings[15];
     CheckBox1.checked:=(length(ligne.strings[16])>0);
     CheckBox2.checked:=(length(ligne.strings[17])>0);
     Edit17.Text:=ligne.strings[18];
     Edit18.Text:=ligne.strings[19];
     Edit19.Text:=ligne.strings[20];
     Edit20.Text:=ligne.strings[21];
     Edit21.Text:=ligne.strings[22];
     Edit22.Text:=ligne.strings[23];
     Edit23.Text:=ligne.strings[24];
     Edit24.Text:=ligne.strings[25];
     Edit25.Text:=ligne.strings[26];
     Edit26.Text:=ligne.strings[27];
     Edit27.Text:=ligne.strings[28];
     CheckBox3.checked:=(length(ligne.strings[29])>0);
     Edit29.Text:=ligne.strings[30];
     Edit30.Text:=ligne.strings[31];
     Edit31.Text:=ligne.strings[32];
     Edit32.Text:=ligne.strings[33];
     Edit33.Text:=ligne.strings[34];
     CheckBox4.checked:=(length(ligne.strings[35])>0);
     Edit34.Text:=ligne.strings[36];
     Edit28.Text:=ligne.strings[37];
     ligne.free;
  end;
end;

procedure TAjouteBapt.Button3Click(Sender: TObject);
begin
  SaveFormPosition(TButton(Sender).Parent as TForm);
  Close;
end;

procedure TAjouteBapt.Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit11.text:=Principale.Query1.Fields[1].AsString;
  Edit12.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit13.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit14.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit15.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
end;

procedure TAjouteBapt.Edit16EditingDone(Sender: TObject);
var
  j,k:integer;
  trouve:boolean;
  memo:string;
begin
  Principale.DataHist.Row:=0;
  memo:=trim(TEdit(Sender).Text);
  If Length(memo)>0 then
     begin
     // On doit vérifier avant d'insérer si le Memo existe déjà, si oui, déplace au début
     trouve:=false;
     for j:=0 to Principale.DataHist.RowCount-1 do
        begin
        if (Principale.DataHist.Cells[0,j]='M') and
           (Principale.DataHist.Cells[1,j]=memo) then
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
     Principale.DataHist.Cells[1,0]:=memo;
  end;
end;

procedure TAjouteBapt.Edit17DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit17.text:=Principale.Query1.Fields[1].AsString;
  Edit18.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit19.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit20.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit21.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;


procedure TAjouteBapt.Edit23DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit23.text:=Principale.Query1.Fields[1].AsString;
  Edit24.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit25.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit26.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit27.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteBapt.Edit29DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit29.text:=Principale.Query1.Fields[1].AsString;
  Edit30.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit31.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit32.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit33.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteBapt.Edit6EditingDone(Sender: TObject);
var
  temp:string;
  j,k:integer;
  trouve:boolean;
begin
  temp:=InterpreteDate(TEdit(Sender).Text,1);
  TEdit(Sender).Text:=ConvertDate(temp,1);
  if temp<>'100000000030000000000' then
     begin
     // On doit vérifier avant d'insérer si le Memo existe déjà, si oui, déplace au début
     trouve:=false;
     for j:=0 to Principale.DataHist.RowCount-1 do
        begin
        if (Principale.DataHist.Cells[0,j]='PD') and
           (Principale.DataHist.Cells[1,j]=temp) then
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
     Principale.DataHist.Cells[0,0]:='PD';
     Principale.DataHist.Cells[1,0]:=temp;
  end;
    Principale.DataHist.Row:=0;
end;

procedure TAjouteBapt.Edit7DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit7.text:=Principale.Query1.Fields[1].AsString;
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteBapt.Edit8DragDrop(Sender, Source: TObject; X, Y: Integer);
var
   filename:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit8.text:=Principale.Query1.Fields[1].AsString;
  Edit9.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  EditSexe.Hint:=Principale.Query1.Fields[9].AsString;
  Case EditSexe.Hint[1] of
     'F':begin
         EditSexe.Hint:='F';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
         end;
     '?':begin
         EditSexe.Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     'M':begin
         EditSexe.Hint:='M';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
         end;
  end;
  EditSexe.Picture.Icon.LoadFromFile(filename);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteBapt.Edit8DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragName.Caption)>0);
end;


procedure TAjouteBapt.EditSexeDblClick(Sender: TObject);
var
  filename:string;
begin
  Case EditSexe.Hint[1] of
     'M':begin
         EditSexe.Hint:='F';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
         end;
     'F':begin
         EditSexe.Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     '?':begin
         EditSexe.Hint:='M';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
         end;
  end;
  EditSexe.Picture.Icon.LoadFromFile(filename);
end;

procedure TAjouteBapt.MenuItem1Click(Sender: TObject);
begin
  Edit1.Text:='';
  Edit1.PasteFromClipboard;
end;

procedure TAjouteBapt.MenuItem6Click(Sender: TObject);
var
    j:integer;
    found:boolean;
    direction:integer;
begin
    found:=false;
    direction := Principale.DataHist.RowCount-1;
    if (ActiveControl.Name='Edit16') or
       (ActiveControl.Name='Edit22') then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to direction do
          begin
          if Principale.DataHist.Cells[0,j]='M' then
             begin
             TEdit(ActiveControl).Text:=Principale.DataHist.Cells[1,j];
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
                TEdit(ActiveControl).text:=Principale.DataHist.Cells[1,j];
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if (ActiveControl.Name='Edit6') or
       (ActiveControl.Name='Edit10') then
       begin
       found:=false;
       For j:=Principale.DataHist.Row to direction do
          begin
          if Principale.DataHist.Cells[0,j]='PD' then
             begin
             TEdit(ActiveControl).Text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
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
                TEdit(ActiveControl).text:=ConvertDate(Principale.DataHist.Cells[1,j],1);
                found:=true;
                break;
             end;
          end;
       end;
    end;
    if found then Principale.DataHist.Row:=j+1;
end;

end.

