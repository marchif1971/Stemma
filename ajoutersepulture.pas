unit AjouterSepulture;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, FMutils, StrUtils, Noms, Parents, Evenements;

type

  { TAjouterSep }

  TAjouterSep = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    Edit107: TEdit;
    Edit108: TEdit;
    Edit109: TEdit;
    Edit11: TEdit;
    Edit110: TEdit;
    Edit111: TEdit;
    Edit112: TEdit;
    Edit113: TEdit;
    Edit114: TEdit;
    Edit115: TEdit;
    Edit116: TEdit;
    Edit119: TEdit;
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
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    EditSexe: TImage;
    EditSexe1: TImage;
    EditSexe2: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label11: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label12: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
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
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
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
    procedure Edit107DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit112DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit11DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Edit16EditingDone(Sender: TObject);
    procedure Edit18DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit24DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit31DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit6EditingDone(Sender: TObject);
    procedure EditSexeDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  AjouterSep: TAjouterSep;

implementation

uses
     unit1;

{$R *.lfm}

{ TAjouterSep }

procedure TAjouterSep.MenuItem1Click(Sender: TObject);
begin
  Edit1.Text:='';
  Edit1.PasteFromClipboard;
end;

procedure TAjouterSep.MenuItem6Click(Sender: TObject);
var
    j:integer;
    found:boolean;
    direction:integer;
begin
    found:=false;
    direction := Principale.DataHist.RowCount-1;
    if (ActiveControl.Name='Edit16') or
       (ActiveControl.Name='Edit17') or
       (ActiveControl.Name='Edit23') or
       (ActiveControl.Name='Edit27') or
       (ActiveControl.Name='Edit36') or
       (ActiveControl.Name='Edit37') then
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
       (ActiveControl.Name='Edit8') then
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

procedure TAjouterSep.Edit11DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragName.Caption)>0);
end;

procedure TAjouterSep.Edit16EditingDone(Sender: TObject);
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

procedure TAjouterSep.Edit18DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit18.text:=Principale.Query1.Fields[1].AsString;
  Edit19.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit20.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit21.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit22.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouterSep.Edit24DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit24.text:=Principale.Query1.Fields[1].AsString;
  Edit25.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit26.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit29.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit30.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouterSep.Edit31DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit31.text:=Principale.Query1.Fields[1].AsString;
  Edit32.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit33.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit34.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit35.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouterSep.Edit6EditingDone(Sender: TObject);
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


procedure TAjouterSep.EditSexeDblClick(Sender: TObject);
var
  filename:string;
begin
  Case TImage(Sender).Hint[1] of
     'M':begin
         TImage(Sender).Hint:='F';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
         end;
     'F':begin
         TImage(Sender).Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     '?':begin
         TImage(Sender).Hint:='M';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
         end;
  end;
  TImage(Sender).Picture.Icon.LoadFromFile(filename);
end;


procedure TAjouterSep.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[438]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[439]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[441]); // Registre
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[442]); // Année
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[443]); // Feuillet
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[444]); // Acte
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[136]); // Date
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[204]); // Décès
  Label108.Caption:=AnsitoUTF8(Principale.Traduction.Items[445]); // # de célébrant
  GroupBox1.Caption:=AnsitoUTF8(Principale.Traduction.Items[468]); // Décédé;
  Label12.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label13.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label14.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label15.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label16.Caption:=AnsitoUTF8(Principale.Traduction.Items[448]); // # de père
  Label20.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label21.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label22.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label23.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox3.Caption:=AnsitoUTF8(Principale.Traduction.Items[458]); // Décédé
  Label9.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[452]); // # de mère
  Label24.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label25.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label26.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label27.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox4.Caption:=AnsitoUTF8(Principale.Traduction.Items[460]); // Décédée
  Label18.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[469]); // # de conjoint
  Label29.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label30.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label31.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label32.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox5.Caption:=AnsitoUTF8(Principale.Traduction.Items[458]); // Décédé
  Label33.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label34.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label35.Caption:=AnsitoUTF8(Principale.Traduction.Items[470]); // Âge
  Label109.Caption:=AnsitoUTF8(Principale.Traduction.Items[463]); // # témoin 1
  Label110.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label111.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label112.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label113.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox17.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label114.Caption:=AnsitoUTF8(Principale.Traduction.Items[465]); // # témoin 2
  Label115.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label121.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label116.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label117.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox18.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label120.Caption:=AnsitoUTF8(Principale.Traduction.Items[456]); // Commentaires
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[440]); // Interpréter
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]); // Ok
  Button3.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]); // Annuler
  EditSexe.Hint:='M';
  EditSexe.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  EditSexe1.Hint:='M';
  EditSexe1.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  EditSexe2.Hint:='M';
  EditSexe2.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  Edit1.Text:='';
  Try
     Edit5.Text:='S'+inttostr(strtoint(copy(Edit5.Text,2,Length(Edit5.Text)))+1);
  except
     Edit5.Text:='';
  end;
  Edit8.Text:='';
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
  Edit35.Text:='';
  Edit36.Text:='';
  Edit37.Text:='';
  Edit38.Text:='';
  Edit107.Text:='';
  Edit108.Text:='';
  Edit109.Text:='';
  Edit110.Text:='';
  Edit111.Text:='';
  Edit112.Text:='';
  Edit113.Text:='';
  Edit114.Text:='';
  Edit115.Text:='';
  Edit116.Text:='';
  Edit119.Text:='';
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
  CheckBox5.Checked:=false;
  CheckBox17.Checked:=false;
  CheckBox18.Checked:=false;
  GetFormPosition(Sender as TForm,0,0,Height,Width);
end;

procedure TAjouterSep.Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
var
   filename:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit11.text:=Principale.Query1.Fields[1].AsString;
  Edit12.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit13.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit14.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit15.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
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

procedure TAjouterSep.Edit107DragDrop(Sender, Source: TObject; X, Y: Integer);
var
     filename:string;
begin
    Principale.Query1.SQL.Clear;
    Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
    Principale.Query1.Open;
    Principale.Query1.First;
    Edit107.text:=Principale.Query1.Fields[1].AsString;
    Edit108.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
    Edit109.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
    Edit110.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
    Edit111.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
    EditSexe1.Hint:=Principale.Query1.Fields[9].AsString;
    Case EditSexe1.Hint[1] of
       'F':begin
           EditSexe1.Hint:='F';
           filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
           end;
       '?':begin
           EditSexe1.Hint:='?';
           filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
           end;
       'M':begin
           EditSexe1.Hint:='M';
           filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
           end;
    end;
    EditSexe1.Picture.Icon.LoadFromFile(filename);
    Principale.DragValue.Caption:='0';
    Principale.DragName.Caption:='0';
end;

procedure TAjouterSep.Button2Click(Sender: TObject);  // Ajoute la sépulture
var
     temp, no_eve, no_inh, nom_personne, X, i3, i4, lieu, annee1, annee2, naissance:string;
     registre, annee, feuillet, acte, date, deces, commentaires, usager:string;
     d_titre, d_prenom, d_nom, d_suffixe, d_metier, d_residence, d_age, d_sexe:string;
     p_titre, p_prenom, p_nom, p_suffixe, p_metier, p_feu:string;
     m_titre, m_prenom, m_nom, m_suffixe, m_residence, m_feu:string;
     c_titre, c_prenom, c_nom, c_suffixe, c_metier, c_residence, c_feu:string;
     t1_titre, t1_prenom, t1_nom, t1_suffixe, t1_residence, t1_signature, t1_sexe:string;
     t2_titre, t2_prenom, t2_nom, t2_suffixe, t2_residence, t2_signature, t2_sexe:string;
     i, pretre, decede, pere, mere, conjoint, t1, t2, age:integer;
begin
       registre:=Edit2.Text;
       lieu:=EstimatePlace(registre,registre);
       annee:=Edit3.Text;
       feuillet:=Edit4.Text;
       acte:=Edit5.Text;
       date:=InterpreteDate(Edit6.Text,1);
       try
          pretre:=strtoint(Edit7.Text);
       except
          pretre:=0;
       end;
       try
          decede:=strtoint(Edit11.Text);
       except
          decede:=0;
       end;
       d_sexe:=EditSexe.Hint;
       d_titre:=Edit12.Text;
       d_prenom:=Edit13.Text;
       d_nom:=Edit14.Text;
       d_suffixe:=Edit15.Text;
       d_metier:=Edit16.Text;
       d_residence:=EstimatePlace(Edit17.Text,lieu);
       deces:=Edit8.Text;
       d_age:=Edit38.Text;
       try
          pere:=strtoint(Edit18.Text);
       except
          pere:=0;
       end;
       p_titre:=Edit19.Text;
       p_prenom:=Edit20.Text;
       p_nom:=Edit21.Text;
       p_suffixe:=Edit22.Text;
       if CheckBox3.checked then
          p_feu:='X'
       else
          p_feu:='';
       p_metier:=Edit23.Text;
       try
          mere:=strtoint(Edit24.Text);
       except
          mere:=0;
       end;
       m_titre:=Edit25.Text;
       m_prenom:=Edit26.Text;
       m_nom:=Edit29.Text;
       m_suffixe:=Edit30.Text;
       if CheckBox4.checked then
          m_feu:='X'
       else
          m_feu:='';
       m_residence:=EstimatePlace(Edit27.Text,lieu);
       try
          conjoint:=strtoint(Edit31.Text);
       except
          conjoint:=0;
       end;
       c_titre:=Edit32.Text;
       c_prenom:=Edit33.Text;
       c_nom:=Edit34.Text;
       c_suffixe:=Edit35.Text;
       if CheckBox5.checked then
          c_feu:='X'
       else
          c_feu:='';
       c_metier:=Edit36.Text;
       c_residence:=EstimatePlace(Edit37.Text,lieu);
       try
          t1:=strtoint(Edit107.Text);
       except
          t1:=0;
       end;
       t1_sexe:=EditSexe1.Hint;
       t1_titre:=Edit108.Text;
       t1_prenom:=Edit109.Text;
       t1_nom:=Edit110.Text;
       t1_suffixe:=Edit111.Text;
       if CheckBox17.checked then
          t1_signature:='X'
       else
          t1_signature:='';
       try
          t2:=strtoint(Edit112.Text);
       except
          t2:=0;
       end;
       t2_sexe:=EditSexe2.Hint;
       t2_titre:=Edit113.Text;
       t2_prenom:=Edit114.Text;
       t2_nom:=Edit115.Text;
       t2_suffixe:=Edit116.Text;
       if CheckBox18.checked then
          t2_signature:='X'
       else
          t2_signature:='';
       commentaires:=Edit119.Text;
       usager:=Edit28.Text;
       naissance:='';
       // ajouter le décédé
       nom_personne:=CodeName(d_titre,d_prenom,d_nom,d_suffixe);
       // modifie ou ajoute le décédé
       if (decede=0) then // ajoute le décédé
          begin
          // ajoute l'individu du bon sexe
          // cherche le prochain numéro vide
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
          Principale.Query2.Open;
          If Principale.Query2.EOF then
             decede:=0
          else
             decede:=Principale.Query2.Fields[0].AsInteger;
          // Créé l'individu
          Principale.Query1.SQL.Clear;
          if (decede=0) then
             Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('+d_sexe+', ''N'', 0)')
          else
             Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(decede)+''', '''+d_sexe+''', ''N'', 0)');
          Principale.Query1.ExecSQL;
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
          Principale.Query1.Open;
          Principale.Query1.First;
          if (decede=0) then
             decede:=Principale.Query1.Fields[10].AsInteger-1;
       end;
       // Créé ou modifie le nom
       // cherche si le nom existe
       Principale.Query1.SQL.Clear;
       Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(decede)+''' AND N='''+nom_personne+'''');
       Principale.Query1.Open;
       // cherche si un nom principal existe
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(decede)+' AND X=1');
       Principale.Query2.Open;
       If Principale.Query2.EOF then
          begin
          X:='1';
          i4:=InterpreteDate(deces,1);
          i3:='';
       end
       else
           begin
           X:='0';
           i3:=Principale.Query2.Fields[2].AsString;
           i4:=InterpreteDate(deces,1);
       end;
       naissance:=i3;
       no_eve:='';
       If Principale.Query1.EOF then // on doit ajouter le nom
          temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                inttostr(decede)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(d_prenom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(d_nom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''', '''', '''', '''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(d_prenom+' '+d_nom,'\','\\'),'"','\"'),'''','\''')+''')'
       else  // on doit modifier le nom
          begin
          X:=Principale.Query1.Fields[3].AsString;
          no_eve:=Principale.Query1.Fields[2].AsString;
          temp:='UPDATE n SET no='+no_eve+' WHERE no='+no_eve; // pas de changement
       end;
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       // Ajouter une source pour le nom
       if (no_eve='') then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
          Principale.Query1.Open;
          Principale.Query1.First;
          no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
       end;
       Principale.Query1.SQL.Clear;
       temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
       Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
       Principale.Query1.ExecSQL;
       // ajouter le décès
       // cherche si le décès existe
       Principale.Query1.SQL.Clear;
       Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e WHERE I='''+inttostr(decede)+
                                         ''' AND e.X=1 AND w.X=1 AND (e.Y=200 or e.Y=201 or e.Y=202 or e.Y=203 or e.Y=204)');
       Principale.Query1.Open;
       no_eve:='';
       If Principale.Query1.EOF then // on doit ajouter la naissance
          temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (200, '''+i4+''', '''+i4+''', 1, '''', 1)'
       else // on doit modifier le décès
          begin
          no_eve:=Principale.Query1.Fields[0].AsString;
          temp:='UPDATE e SET PD='''+i4+''', SD='''+i4+''' WHERE no='+no_eve;
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
          temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
       end;
       // ajoute une source pour l'événement
       Principale.Query1.SQL.Clear;
       temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
       Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
       Principale.Query1.ExecSQL;
       // Doit-on ajouter la naissance
       if length(d_age)>0 then // si age est connu
          begin
          try
             age:=strtoint(d_age);
          except
             age:=0;
          end;
          if age>0 then
             begin
             // si naissance existe simplement ajouter référence avec date de naissance calculée entre parenthèse
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e JOIN Y on e.y=y.no WHERE I='''+inttostr(decede)+
                                               ''' AND w.X=1 AND y.Y=''B''');
             Principale.Query1.Open;
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter la naissance
                begin
                temp:=InterpreteDate('c'+inttostr(strtoint(annee)-age),1);
                temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (100, '''+temp+''', '''+temp+''', 1, '''', 1)';
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
                   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_eve+', 1, '''', ''ENFANT'')';
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add(temp);
                   Principale.Query2.ExecSQL;
                end;
             end
             else // simplement ajouter une référence avec l'age entre parenthèse
                no_eve:=Principale.Query1.Fields[0].AsString;
             // ajoute une source pour l'événement
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' ('+d_age+' ans)'+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
       end;
       // ajouter la sépulture
       // cherche si la sépulture existe
       Principale.Query1.SQL.Clear;
       Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e WHERE I='''+inttostr(decede)+
                                         ''' AND w.X=1 AND e.Y=210');
       Principale.Query1.Open;
       no_inh:='';
       If Principale.Query1.EOF then // on doit ajouter la naissance
          temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (210, '''+date
                +''', '''+date+''', '+lieu+', '''', 0)'
       else // on doit modifier la sépulture
          begin
          no_inh:=Principale.Query1.Fields[0].AsString;
          temp:='UPDATE e SET PD='''+date+''', SD='''+date+''' WHERE no='+no_inh;
       end;
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       if (no_inh='') then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
          Principale.Query1.Open;
          Principale.Query1.First;
          no_inh:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_inh+', 1, '''', ''DÉCÉDÉ'')';
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
       end;
       // ajoute une source pour l'événement
       Principale.Query1.SQL.Clear;
       temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
       Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_inh+', 100, 3, '''+temp+''')');
       Principale.Query1.ExecSQL;
       // si présent, ajouter le père
       // si le # de père est pas là
       nom_personne:=CodeName(p_titre,p_prenom,p_nom,p_suffixe);
       if length(nom_personne)>0 then
          begin
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
             if (length(p_feu)>0) then
                i4:=InterpreteDate('<'+annee,1)
             else
                i4:='';
          end
          else
              begin
              X:='0';
              i3:=Principale.Query2.Fields[2].AsString;
              i4:=Principale.Query2.Fields[3].AsString;
              if (length(i4)=0) then
                 if (length(p_feu)>0) then
                    i4:=InterpreteDate('<'+annee,1)
          end;
          no_eve:='';
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
             no_eve:=Principale.Query1.Fields[2].AsString;
             temp:='UPDATE n SET i4='''+i4+''' WHERE no='+no_eve;
          end;
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
          // Ajouter une source pour le nom
          if (no_eve='') then
             begin
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
             Principale.Query1.Open;
             Principale.Query1.First;
             no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          end;
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // modifie ou ajoute la relation au père
          // cherche si la relation existe
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(decede)+' AND B='+inttostr(pere));
          Principale.Query1.Open;
          X:='1';
          no_eve:='';
          If Principale.Query1.EOF then // on doit ajouter la relation
             temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(decede)+
                   ', '+inttostr(pere)+', '''', '+X+', '''', '''+naissance+''')'
          else  // on doit modifier la relation
             begin
             X:=Principale.Query1.Fields[3].AsString;
             no_eve:=Principale.Query1.Fields[0].AsString;
             temp:='UPDATE r SET X='+X+' WHERE no='+no_eve;  // En fait on ne fait pas de modification
          end;
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
          if (no_eve='') then
             begin
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
             Principale.Query1.Open;
             Principale.Query1.First;
             no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          end;
          // ajoute la référence pour la relation
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // modifie ou ajoute le métier du père
          if length(p_metier)>0 then
             begin
             // cherche si l'occupation existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no, e.PD FROM e JOIN w on e.no=w.E WHERE e.M='''+p_metier+''' AND e.Y=511 AND w.I='+inttostr(pere));
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter l'occupation
                begin
                if length(p_feu)=0 then
                   temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''+interpretedate(annee,1)+
                         ''', '''+interpretedate(annee,1)+''', 1, '''+p_metier+''', 0)'
                else
                   temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''', '''', 1, '''+
                                         p_metier+''', 0)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin à l'occupation
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_eve+', 1, '''', ''EMPLOYÉ'')';
             end
             else  // on doit modifier l'occupation
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
                // ne pas modifier les années si pere est décée
                if length(p_feu)=0 then
                   begin
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
                   end
                else
                   annee1:=Principale.Query1.Fields[1].AsString;
                temp:='UPDATE e SET PD='''+annee1+
                                ''',SD='''+annee1+''' WHERE no='+no_eve;  // On change PD SD
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
             end;
             // ajoute la référence pour l'occupation
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
          // ajouter ou modifier le décès du père
          if length(p_feu)>0 then
             begin
             // cherche si un décès principal existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(pere)+''' AND y.y=''D'' and e.X=1 and w.X=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter le décès
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (200, '''+interpretedate('<'+annee,1)+
                      ''', '''+interpretedate('<'+annee,1)+''', 1, '''', 1)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin au décès
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
             end
             else  // on doit modifier le décès (not)
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
                temp:='UPDATE e SET X=1 WHERE no='+no_eve;  // pas de changements
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
             end;
             // ajoute la référence pour le décès
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
       end;
       // si présent, ajouter la mère
       // si le # de mère est pas là
       nom_personne:=CodeName(m_titre,m_prenom,m_nom,m_suffixe);
       if length(nom_personne)>0 then
          begin
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
             if (length(m_feu)>0) then
               i4:=InterpreteDate('<'+annee,1)
             else
                i4:='';
          end
          else
              begin
              X:='0';
              i3:=Principale.Query2.Fields[2].AsString;
              i4:=Principale.Query2.Fields[3].AsString;
              if (length(i4)=0) then
                 if (length(m_feu)>0) then
                   i4:=InterpreteDate('<'+annee,1)
          end;
          no_eve:='';
          If Principale.Query1.EOF then // on doit ajouter le nom
             temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                   inttostr(mere)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_prenom,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_nom,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''', '''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(m_titre+' '+m_prenom+' '+m_nom+' '+m_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
          else  // on doit modifier le nom
             begin
             X:=Principale.Query1.Fields[3].AsString;
             no_eve:=Principale.Query1.Fields[2].AsString;
             temp:='UPDATE n SET i4='''+i4+''' WHERE no='+no_eve;
          end;
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
          // Ajouter une source pour le nom
          if (no_eve='') then
             begin
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
             Principale.Query1.Open;
             Principale.Query1.First;
             no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          end;
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // modifie ou ajoute la relation a la mère
          // cherche si la relation existe
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(decede)+' AND B='+inttostr(mere));
          Principale.Query1.Open;
          X:='1';
          no_eve:='';
          If Principale.Query1.EOF then // on doit ajouter la relation
             temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(decede)+
                   ', '+inttostr(mere)+', '''', '+X+', '''', '''+naissance+''')'
          else  // on doit modifier la relation
             begin
             X:=Principale.Query1.Fields[3].AsString;
             no_eve:=Principale.Query1.Fields[0].AsString;
             temp:='UPDATE r SET X='+X+' WHERE no='+no_eve;  // En fait on ne fait pas de modification
          end;
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
          if (no_eve='') then
             begin
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
             Principale.Query1.Open;
             Principale.Query1.First;
             no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          end;
          // ajoute la référence pour la relation
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''R'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // ajouter ou modifier le décès de la mère
          if length(m_feu)>0 then
             begin
             // cherche si un décès principal existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(mere)+''' AND y.y=''D'' and e.X=1 and w.X=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter le décès
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (200, '''+interpretedate('<'+annee,1)+
                      ''', '''+interpretedate('<'+annee,1)+''', 1, '''', 1)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin au décès
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mere)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
             end
             else  // on doit modifier le décès (not)
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
                temp:='UPDATE e SET X=1 WHERE no='+no_eve;  // pas de changements
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
             end;
             // ajoute la référence pour le décès
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
          // modifie ou ajoute la résidence des parents si 'cette paroisse'
          if (length(m_residence)>0) then
             begin
             // cherche si la residence existe
             Principale.Query1.SQL.Clear;
             if (length(p_feu)+length(m_feu))=0 then
                Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                          +m_residence+' AND e.Y=550 AND w1.I='+inttostr(pere)+' AND w2.I='+inttostr(mere)+') HAVING temp=2')
             else
                if length(p_feu)=0 then
                   Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                             +m_residence+' AND e.Y=550 AND w1.I='+inttostr(pere)+') HAVING temp=1')
                else
                   Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                             +m_residence+' AND e.Y=550 AND w1.I='+inttostr(mere)+') HAVING temp=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter la résidence
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                      ''', '''+interpretedate(annee,1)+''', '+m_residence+', '''', 0)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin à la résidence
                if (length(p_feu)+length(m_feu))=0 then
                   begin
                   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_eve+', 1, '''', ''TEMOIN'')';
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add(temp);
                   Principale.Query2.ExecSQL;
                   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mere)+', '+no_eve+', 1, '''', ''TEMOIN'')';
                end
                else
                   if length(p_feu)=0 then
                      temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pere)+', '+no_eve+', 1, '''', ''TEMOIN'')'
                   else
                      temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mere)+', '+no_eve+', 1, '''', ''TEMOIN'')';
             end
             else  // on doit modifier la residence
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
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
                                ''',SD='''+annee1+''' WHERE no='+no_eve;  // On change PD SD
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
             end;
             // ajoute la référence pour la residence
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
             // modifier ou ajouter le mariage des parents du décédé
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
          end;
       end;
       // si présent, ajouter le conjoint
       // si le # de conjoint est pas là
       nom_personne:=CodeName(c_titre,c_prenom,c_nom,c_suffixe);
       if length(nom_personne)>0 then
          begin
          if (conjoint=0) then // ajoute le conjoint
             begin
             // ajoute l'individu du bon sexe
             // cherche le prochain numéro vide
             Principale.Query2.SQL.Clear;
             Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
             Principale.Query2.Open;
             If Principale.Query2.EOF then
                conjoint:=0
             else
                conjoint:=Principale.Query2.Fields[0].AsInteger;
             // Créé l'individu
             Principale.Query1.SQL.Clear;
             if d_sexe='M' then
                temp:='F'
             else
                temp:='M';
             if (conjoint=0) then
                Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+temp+''', ''N'', 0)')
             else
                Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(conjoint)+''', '''+temp+''', ''N'', 0)');
             Principale.Query1.ExecSQL;
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
             Principale.Query1.Open;
             Principale.Query1.First;
             if (conjoint=0) then
                conjoint:=Principale.Query1.Fields[10].AsInteger-1;
          end;
          // Créé ou modifie le nom
          // cherche si le nom existe
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(conjoint)+''' AND N='''+nom_personne+'''');
          Principale.Query1.Open;
          // cherche si un nom principal existe
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(conjoint)+' AND X=1');
          Principale.Query2.Open;
          If Principale.Query2.EOF then
             begin
             X:='1';
             i3:='';
             if (length(c_feu)>0) then
                i4:=InterpreteDate('<'+annee,1)
             else
                i4:='';
          end
          else
              begin
              X:='0';
              i3:=Principale.Query2.Fields[2].AsString;
              i4:=Principale.Query2.Fields[3].AsString;
              if (length(i4)=0) then
                 if (length(c_feu)>0) then
                    i4:=InterpreteDate('<'+annee,1)
          end;
          no_eve:='';
          If Principale.Query1.EOF then // on doit ajouter le nom
             temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                   inttostr(conjoint)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(c_prenom,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(c_nom,'\','\\'),'"','\"'),'''','\''')+
                   ''', '''+InterpreteDate('',1)+
                   ''', '''+InterpreteDate('',1)+
                   ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(c_titre+' '+c_prenom+' '+c_nom+' '+c_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
          else  // on doit modifier le nom
             begin
             X:=Principale.Query1.Fields[3].AsString;
             no_eve:=Principale.Query1.Fields[2].AsString;
             temp:='UPDATE n SET i4='''+i4+''' WHERE no='+no_eve;
          end;
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add(temp);
          Principale.Query2.ExecSQL;
          // Ajouter une source pour le nom
          if (no_eve='') then
             begin
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
             Principale.Query1.Open;
             Principale.Query1.First;
             no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
          end;
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // modifie ou ajoute le mariage au conjoint
          // cherche si le mariage existe
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SELECT w.e, e.PD, e.X, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.X=1 AND w.E IN '+
                                    '(SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.Y=300 AND w1.I='
                                    +inttostr(decede)+' AND w2.I='+inttostr(conjoint)+' AND w1.X=1 AND w2.X=1) HAVING temp=2');
          Principale.Query1.Open;
          X:='1';
          no_eve:='';
          If Principale.Query1.EOF then // on doit ajouter le mariage
             begin
             temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (300, '''', '''', 1, '''', 1)';
             Principale.Query2.SQL.Clear;
             Principale.Query2.SQL.Add(temp);
             Principale.Query2.ExecSQL;
             // ajouter les témoins au mariage
             if (no_eve='') then
                begin
                Principale.Query1.SQL.Clear;
                Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                Principale.Query1.Open;
                Principale.Query1.First;
                no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
             end;
             temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_eve+', 1, '''', ''CONJOINT'')';
             Principale.Query2.SQL.Clear;
             Principale.Query2.SQL.Add(temp);
             Principale.Query2.ExecSQL;
             temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(conjoint)+', '+no_eve+', 1, '''', ''CONJOINT'')';
          end
          else  // on doit modifier le mariage
             begin
             X:=Principale.Query1.Fields[3].AsString;
             no_eve:=Principale.Query1.Fields[0].AsString;
             temp:='UPDATE e SET X='+X+' WHERE no='+no_eve;  // En fait on ne fait pas de modification
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
          end;
          // ajoute la référence pour la relation
          Principale.Query1.SQL.Clear;
          temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
          // modifie ou ajoute le métier du conjoint
          if length(c_metier)>0 then
             begin
             // cherche si l'occupation existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no, e.PD FROM e JOIN w on e.no=w.E WHERE e.M='''+c_metier+''' AND e.Y=511 AND w.I='+inttostr(conjoint));
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter l'occupation
                begin
                if length(c_feu)=0 then
                   temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''+interpretedate(annee,1)+
                         ''', '''+interpretedate(annee,1)+''', 1, '''+c_metier+''', 0)'
                else
                   temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''', '''', 1, '''+
                                         c_metier+''', 0)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin à l'occupation
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(conjoint)+', '+no_eve+', 1, '''', ''EMPLOYÉ'')';
             end
             else  // on doit modifier l'occupation
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
                // ne pas modifier les années si pere est décée
                if length(c_feu)=0 then
                   begin
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
                   end
                else
                   annee1:=Principale.Query1.Fields[1].AsString;
                temp:='UPDATE e SET PD='''+annee1+
                                ''',SD='''+annee1+''' WHERE no='+no_eve;  // On change PD SD
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
             end;
             // ajoute la référence pour l'occupation
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
          // ajouter ou modifier le décès du conjoint
          if length(c_feu)>0 then
             begin
             // cherche si un décès principal existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(conjoint)+''' AND y.y=''D'' and e.X=1 and w.X=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter le décès
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (200, '''+interpretedate('<'+annee,1)+
                      ''', '''+interpretedate('<'+annee,1)+''', 1, '''', 1)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin au décès
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(conjoint)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
             end
             else  // on doit modifier le décès (not)
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
                temp:='UPDATE e SET X=1 WHERE no='+no_eve;  // pas de changements
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
             end;
             // ajoute la référence pour le décès
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
          // modifie ou ajoute la résidence des conjoints si 'cette paroisse'
          if length(c_residence)=0 then
             c_residence:='1';
          if strtoint(c_residence)=1 then
             c_residence:=d_residence;
          if strtoint(c_residence)>1 then
             begin
             // cherche si la residence existe
             Principale.Query1.SQL.Clear;
             if (length(c_feu))=0 then
                Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                          +c_residence+' AND e.Y=550 AND w1.I='+inttostr(decede)+' AND w2.I='+inttostr(conjoint)+') HAVING temp=2')
             else
                Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                             +c_residence+' AND e.Y=550 AND w1.I='+inttostr(decede)+') HAVING temp=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter la résidence
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                      ''', '''+interpretedate(annee,1)+''', '+c_residence+', '''', 0)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin à la résidence
                if (length(c_feu))=0 then
                   begin
                   temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(conjoint)+', '+no_eve+', 1, '''', ''TEMOIN'')';
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add(temp);
                   Principale.Query2.ExecSQL;
                end;
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_eve+', 1, '''', ''TEMOIN'')'
             end
             else  // on doit modifier la residence
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
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
                                ''',SD='''+annee1+''' WHERE no='+no_eve;  // On change PD SD
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
             end;
             // ajoute la référence pour la residence
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
       end
       else // ajouter la résidence du décédé si pas de conjoint
          begin
          // modifie ou ajoute la résidence des conjoints si 'cette paroisse'
          if (length(d_residence)>0) then
             begin
             // cherche si la residence existe
             Principale.Query1.SQL.Clear;
             Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                       +d_residence+' AND e.Y=550 AND w1.I='+inttostr(decede)+') HAVING temp=1');
             Principale.Query1.Open;
             no_eve:='';
             If Principale.Query1.EOF then // on doit ajouter la résidence
                begin
                temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                      ''', '''+interpretedate(annee,1)+''', '+d_residence+', '''', 0)';
                Principale.Query2.SQL.Clear;
                Principale.Query2.SQL.Add(temp);
                Principale.Query2.ExecSQL;
                if (no_eve='') then
                   begin
                   Principale.Query2.SQL.Clear;
                   Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
                   Principale.Query2.Open;
                   Principale.Query2.First;
                   no_eve:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
                end;
                // et ajouter le temoin à la résidence
                temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(decede)+', '+no_eve+', 1, '''', ''TEMOIN'')'
             end
             else  // on doit modifier la residence
                begin
                no_eve:=Principale.Query1.Fields[0].AsString;
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
                                ''',SD='''+annee1+''' WHERE no='+no_eve;  // On change PD SD
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
             end;
             // ajoute la référence pour la residence
             Principale.Query1.SQL.Clear;
             temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
             Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
             Principale.Query1.ExecSQL;
          end;
       end;
       // ajoute le temoin #1
       nom_personne:=CodeName(t1_titre,t1_prenom,t1_nom,t1_suffixe);
       if (t1=0) then // ajoute le temoin #1
          begin
          // ajoute l'individu du bon sexe
          // cherche le prochain numéro vide
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
          Principale.Query2.Open;
          If Principale.Query2.EOF then
             t1:=0
          else
             t1:=Principale.Query2.Fields[0].AsInteger;
          // Créé l'individu
          Principale.Query1.SQL.Clear;
          if (t1=0) then
             Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+t1_sexe+''', ''N'', 0)')
          else
             Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(t1)+''', '''+t1_sexe+''', ''N'', 0)');
          Principale.Query1.ExecSQL;
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
          Principale.Query1.Open;
          Principale.Query1.First;
          if (t1=0) then
             t1:=Principale.Query1.Fields[10].AsInteger-1;
       end;
       // Créé ou modifie le nom
       // cherche si le nom existe
       Principale.Query1.SQL.Clear;
       Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(t1)+''' AND N='''+nom_personne+'''');
       Principale.Query1.Open;
       // cherche si un nom principal existe
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(t1)+' AND X=1');
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
       no_eve:='';
       If Principale.Query1.EOF then // on doit ajouter le nom
          temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                inttostr(t1)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t1_prenom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t1_nom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+InterpreteDate('',1)+
                ''', '''+InterpreteDate('',1)+
                ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t1_titre+' '+t1_prenom+' '+t1_nom+' '+t1_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
       else  // on doit modifier le nom
          begin
          X:=Principale.Query1.Fields[3].AsString;
          no_eve:=Principale.Query1.Fields[2].AsString;
          temp:='UPDATE n SET X='+X+' WHERE no='+no_eve;  // En fait on ne fait pas de modification
       end;
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       // Ajouter une source pour le nom
       if (no_eve='') then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
          Principale.Query1.Open;
          Principale.Query1.First;
          no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
       end;
       Principale.Query1.SQL.Clear;
       temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
       // vérifier si la source existe déjà au cas où le témoin est le conjoint,père ou mère
       Principale.Query1.SQL.Add('SELECT no FROM c WHERE y=''N'' AND N='+no_eve+' AND S=100 AND M='''+temp+'''');
       Principale.Query1.Open;
       If Principale.Query1.EOF then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
       end;
       // ajouter le témoin 2
       nom_personne:=CodeName(t2_titre,t2_prenom,t2_nom,t2_suffixe);
       if (t2=0) then // ajoute le temoin #1
          begin
          // ajoute l'individu du bon sexe
          // cherche le prochain numéro vide
          Principale.Query2.SQL.Clear;
          Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
          Principale.Query2.Open;
          If Principale.Query2.EOF then
             t2:=0
          else
             t2:=Principale.Query2.Fields[0].AsInteger;
          // Créé l'individu
          Principale.Query1.SQL.Clear;
          if (t2=0) then
             Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES ('''+t2_sexe+''', ''N'', 0)')
          else
             Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(t2)+''', '''+t2_sexe+''', ''N'', 0)');
          Principale.Query1.ExecSQL;
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
          Principale.Query1.Open;
          Principale.Query1.First;
          if (t2=0) then
             t2:=Principale.Query1.Fields[10].AsInteger-1;
       end;
       // Créé ou modifie le nom
       // cherche si le nom existe
       Principale.Query1.SQL.Clear;
       Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(t2)+''' AND N='''+nom_personne+'''');
       Principale.Query1.Open;
       // cherche si un nom principal existe
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(t2)+' AND X=1');
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
       no_eve:='';
       If Principale.Query1.EOF then // on doit ajouter le nom
          temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                inttostr(t2)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t2_prenom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t2_nom,'\','\\'),'"','\"'),'''','\''')+
                ''', '''+InterpreteDate('',1)+
                ''', '''+InterpreteDate('',1)+
                ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(t2_titre+' '+t2_prenom+' '+t2_nom+' '+t2_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
       else  // on doit modifier le nom
          begin
          X:=Principale.Query1.Fields[3].AsString;
          no_eve:=Principale.Query1.Fields[2].AsString;
          temp:='UPDATE n SET X='+X+' WHERE no='+no_eve;  // En fait on ne fait pas de modification
       end;
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       // Ajouter une source pour le nom
       if (no_eve='') then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
          Principale.Query1.Open;
          Principale.Query1.First;
          no_eve:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
       end;
       Principale.Query1.SQL.Clear;
       temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
       // vérifier si la source existe déjà au cas où le témoin est le conjoint,père ou mère
       Principale.Query1.SQL.Add('SELECT no FROM c WHERE y=''N'' AND N='+no_eve+' AND S=100 AND M='''+temp+'''');
       Principale.Query1.Open;
       If Principale.Query1.EOF then
          begin
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
          Principale.Query1.ExecSQL;
       end;
       // ajouter le célébrant
       temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pretre)+', '+no_inh+', 0, '''', ''CELEBRANT'')';
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       // ajouter le témoin #1
       temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(t1)+', '+no_inh+', 0, '''', ''TEMOIN'')';
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       // ajouter le témoin #2
       temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(t2)+', '+no_inh+', 0, '''', ''TEMOIN'')';
       Principale.Query2.SQL.Clear;
       Principale.Query2.SQL.Add(temp);
       Principale.Query2.ExecSQL;
       SaveModificationTime(inttostr(decede));
       Principale.Individu.Caption:=inttostr(decede);
       PopulateNom;
       PopulateEvenements;
       PopulateParents;
       SaveFormPosition(TButton(Sender).Parent as TForm);
       Close;
end;

procedure TAjouterSep.Button1Click(Sender: TObject);    // Interprete ligne
var
   ligne:TStringList;
   filename:string;
begin
   ligne:=TStringList.Create;
   ligne.text:=ReplaceText(Edit1.Text,#9,#13#10);
   if ligne.Count=54 then
      begin
      Edit2.Text:=ligne.strings[0];
      Edit3.Text:=ligne.strings[1];
      Edit4.Text:=ligne.strings[2];
      Edit5.Text:=ligne.strings[3];
      Edit6.Text:=InterpreteDate(AnsiReplaceStr(ligne.strings[4],'-','.'),0);
      Edit7.Text:=ligne.strings[5];
      Edit11.Text:=ligne.strings[6];
      if ligne.strings[7]='M' then
         EditSexe.Hint:='M'
      else
         if ligne.strings[7]='F' then
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
      Edit12.Text:=ligne.strings[8];
      Edit13.Text:=ligne.strings[9];
      Edit14.Text:=ligne.strings[10];
      Edit15.Text:=ligne.strings[11];
      Edit16.Text:=ligne.strings[12];
      Edit17.Text:=ligne.strings[13];
      Edit8.Text:=InterpreteDate(AnsiReplaceStr(ligne.strings[14],'-','.'),0);
      Edit38.Text:=ligne.strings[15];
      Edit18.Text:=ligne.strings[16];
      Edit19.Text:=ligne.strings[17];
      Edit20.Text:=ligne.strings[18];
      Edit21.Text:=ligne.strings[19];
      Edit22.Text:=ligne.strings[20];
      CheckBox3.Checked:=length(ligne.strings[21])>0;
      Edit23.Text:=ligne.strings[22];
      Edit24.Text:=ligne.strings[23];
      Edit25.Text:=ligne.strings[24];
      Edit26.Text:=ligne.strings[25];
      Edit29.Text:=ligne.strings[26];
      Edit30.Text:=ligne.strings[27];
      CheckBox4.Checked:=length(ligne.strings[28])>0;
      Edit27.Text:=ligne.strings[29];
      Edit31.Text:=ligne.strings[30];
      Edit32.Text:=ligne.strings[31];
      Edit33.Text:=ligne.strings[32];
      Edit34.Text:=ligne.strings[33];
      Edit35.Text:=ligne.strings[34];
      CheckBox5.Checked:=length(ligne.strings[35])>0;
      Edit36.Text:=ligne.strings[36];
      Edit37.Text:=ligne.strings[37];
      Edit107.Text:=ligne.strings[38];
      if ligne.strings[39]='M' then
         EditSexe1.Hint:='M'
      else
         if ligne.strings[39]='F' then
            EditSexe1.Hint:='F'
         else
            EditSexe1.Hint:='?';
      Case EditSexe1.Hint[1] of
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
      EditSexe1.Picture.Icon.LoadFromFile(filename);
      Edit108.Text:=ligne.strings[40];
      Edit109.Text:=ligne.strings[41];
      Edit110.Text:=ligne.strings[42];
      Edit111.Text:=ligne.strings[43];
      CheckBox17.Checked:=length(ligne.strings[44])>0;
      Edit112.Text:=ligne.strings[45];
      if ligne.strings[46]='M' then
         EditSexe2.Hint:='M'
      else
         if ligne.strings[46]='F' then
            EditSexe2.Hint:='F'
         else
            EditSexe1.Hint:='?';
      Case EditSexe2.Hint[1] of
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
      EditSexe2.Picture.Icon.LoadFromFile(filename);
      Edit113.Text:=ligne.strings[47];
      Edit114.Text:=ligne.strings[48];
      Edit115.Text:=ligne.strings[49];
      Edit116.Text:=ligne.strings[50];
      CheckBox17.Checked:=length(ligne.strings[51])>0;
      Edit119.Text:=ligne.strings[52];
      Edit28.Text:=ligne.strings[53];
   end;
   ligne.free;
end;

procedure TAjouterSep.Button3Click(Sender: TObject);
begin
  SaveFormPosition(TButton(Sender).Parent as TForm);
  Close;
end;

procedure TAjouterSep.Edit112DragDrop(Sender, Source: TObject; X, Y: Integer);
var
   filename:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I, I.S FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit112.text:=Principale.Query1.Fields[1].AsString;
  Edit113.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit114.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit115.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit116.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  EditSexe2.Hint:=Principale.Query1.Fields[9].AsString;
  Case EditSexe2.Hint[1] of
     'F':begin
         EditSexe2.Hint:='F';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
         end;
     '?':begin
         EditSexe2.Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     'M':begin
         EditSexe2.Hint:='M';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
         end;
  end;
  EditSexe2.Picture.Icon.LoadFromFile(filename);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;


end.

