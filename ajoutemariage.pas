unit AjouteMariage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls, FMutils, StrUtils, Noms, Parents, Evenements;

type

  { TAjouteMar }

  TAjouteMar = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    Edit100: TEdit;
    Edit101: TEdit;
    Edit102: TEdit;
    Edit103: TEdit;
    Edit104: TEdit;
    Edit105: TEdit;
    Edit106: TEdit;
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
    Edit117: TEdit;
    Edit118: TEdit;
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
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit88: TEdit;
    Edit89: TEdit;
    Edit90: TEdit;
    Edit91: TEdit;
    Edit92: TEdit;
    Edit93: TEdit;
    Edit94: TEdit;
    Edit95: TEdit;
    Edit96: TEdit;
    Edit97: TEdit;
    Edit98: TEdit;
    Edit99: TEdit;
    EditSexe: TImage;
    EditSexe1: TImage;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
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
    Label118: TLabel;
    Label119: TLabel;
    Label12: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
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
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit101DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit107DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit112DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit11DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Edit16EditingDone(Sender: TObject);
    procedure Edit18DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit24DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit6EditingDone(Sender: TObject);
    procedure Edit88DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Edit95DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EditSexeDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label10DblClick(Sender: TObject);
    procedure Label19DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  AjouteMar: TAjouteMar;

implementation

uses
  unit1;
{$R *.lfm}

{ TAjouteMar }

procedure TAjouteMar.Edit6EditingDone(Sender: TObject);
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

procedure TAjouteMar.Edit88DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit88.text:=Principale.Query1.Fields[1].AsString;
  Edit89.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit90.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit91.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit92.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
end;

procedure TAjouteMar.Edit95DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit95.text:=Principale.Query1.Fields[1].AsString;
  Edit96.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit97.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit98.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit99.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
end;

procedure TAjouteMar.EditSexeDblClick(Sender: TObject);
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

procedure TAjouteMar.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[436]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[437]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[441]); // Registre
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[442]); // Année
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[443]); // Feuillet
  Label5.Caption:=AnsitoUTF8(Principale.Traduction.Items[444]); // Acte
  Label6.Caption:=AnsitoUTF8(Principale.Traduction.Items[136]); // Date
  Label108.Caption:=AnsitoUTF8(Principale.Traduction.Items[445]); // # de célébrant
  GroupBox1.Caption:=AnsitoUTF8(Principale.Traduction.Items[457]); // Futur;
  Label12.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label13.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label14.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label15.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox2.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[459]); // Mineur
  Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[471]); // Fils de
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
  GroupBox5.Caption:=AnsitoUTF8(Principale.Traduction.Items[461]); // Future;
  Label89.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label90.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label91.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label92.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox14.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label93.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label94.Caption:=AnsitoUTF8(Principale.Traduction.Items[462]); // Mineure
  Label122.Caption:=AnsitoUTF8(Principale.Traduction.Items[473]); // Fille de
  Label95.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label96.Caption:=AnsitoUTF8(Principale.Traduction.Items[448]); // # de père
  Label97.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label98.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label99.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label100.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox15.Caption:=AnsitoUTF8(Principale.Traduction.Items[458]); // Décédé
  Label101.Caption:=AnsitoUTF8(Principale.Traduction.Items[449]); // Métier
  Label102.Caption:=AnsitoUTF8(Principale.Traduction.Items[452]); // # de mère
  Label103.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label104.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label105.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label106.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox16.Caption:=AnsitoUTF8(Principale.Traduction.Items[460]); // Décédée
  Label107.Caption:=AnsitoUTF8(Principale.Traduction.Items[453]); // Résidence
  Label109.Caption:=AnsitoUTF8(Principale.Traduction.Items[463]); // # témoin 1
  Label110.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label111.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label112.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label113.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox17.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label118.Caption:=AnsitoUTF8(Principale.Traduction.Items[464]); // Relation
  Label114.Caption:=AnsitoUTF8(Principale.Traduction.Items[465]); // # témoin 2
  Label115.Caption:=AnsitoUTF8(Principale.Traduction.Items[40]); // Titre
  Label121.Caption:=AnsitoUTF8(Principale.Traduction.Items[38]); // Prénom
  Label116.Caption:=AnsitoUTF8(Principale.Traduction.Items[37]); // Nom
  Label117.Caption:=AnsitoUTF8(Principale.Traduction.Items[39]); // Suffixe
  CheckBox18.Caption:=AnsitoUTF8(Principale.Traduction.Items[451]); // Signature
  Label119.Caption:=AnsitoUTF8(Principale.Traduction.Items[464]); // Relation
  Label120.Caption:=AnsitoUTF8(Principale.Traduction.Items[456]); // Commentaires
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[440]); // Interpréter
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]); // Ok
  Button3.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]); // Annuler
  EditSexe.Hint:='M';
  EditSexe.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  EditSexe1.Hint:='M';
  EditSexe1.Picture.Icon.LoadFromFile(ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico');
  Edit1.Text:='';
  Try
     Edit5.Text:='M'+inttostr(strtoint(copy(Edit5.Text,2,Length(Edit5.Text)))+1);
  except
     Edit5.Text:='';
  end;
  Edit6.Text:='';
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
  Edit88.Text:='';
  Edit89.Text:='';
  Edit90.Text:='';
  Edit91.Text:='';
  Edit92.Text:='';
  Edit93.Text:='';
  Edit94.Text:='';
  Edit95.Text:='';
  Edit96.Text:='';
  Edit97.Text:='';
  Edit98.Text:='';
  Edit99.Text:='';
  Edit100.Text:='';
  Edit101.Text:='';
  Edit102.Text:='';
  Edit103.Text:='';
  Edit104.Text:='';
  Edit105.Text:='';
  Edit106.Text:='';
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
  Edit117.Text:='';
  Edit118.Text:='';
  Edit119.Text:='';
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
  CheckBox14.Checked:=false;
  CheckBox15.Checked:=false;
  CheckBox16.Checked:=false;
  CheckBox17.Checked:=false;
  CheckBox18.Checked:=false;
  GetFormPosition(Sender as TForm,0,0,Height,Width);
end;

procedure TAjouteMar.Label10DblClick(Sender: TObject);
begin
   if TLabel(Sender).Caption=Principale.Traduction.Items[462] then
      TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[467]) // Majeure
   else
      if TLabel(Sender).Caption=Principale.Traduction.Items[467] then
         TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[462]) // Mineure
      else
         if TLabel(Sender).Caption=Principale.Traduction.Items[459] then
            TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[466]) // Majeur
         else
            if TLabel(Sender).Caption=Principale.Traduction.Items[466] then
               TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[459]); // Mineur
end;

procedure TAjouteMar.Label19DblClick(Sender: TObject);
begin
   if TLabel(Sender).Caption=Principale.Traduction.Items[473] then
      begin
      TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[474]); // Veuve de
      Label96.Caption:=AnsitoUTF8(Principale.Traduction.Items[469]); // # de conjoint
      Label102.Visible:=false;
      Label103.Visible:=false;
      Label104.Visible:=false;
      Label105.Visible:=false;
      Label106.Visible:=false;
      Label107.Visible:=false;
      Edit101.Visible:=false;
      Edit102.Visible:=false;
      Edit103.Visible:=false;
      Edit104.Visible:=false;
      Edit105.Visible:=false;
      Edit106.Visible:=false;
      CheckBox16.Visible:=false;
   end
   else
      if TLabel(Sender).Caption=Principale.Traduction.Items[474] then
         begin
         TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[473]); // Fille de
         Label96.Caption:=AnsitoUTF8(Principale.Traduction.Items[448]); // # de père
         Label102.Visible:=true;
         Label103.Visible:=true;
         Label104.Visible:=true;
         Label105.Visible:=true;
         Label106.Visible:=true;
         Label107.Visible:=true;
         Edit101.Visible:=true;
         Edit102.Visible:=true;
         Edit103.Visible:=true;
         Edit104.Visible:=true;
         Edit105.Visible:=true;
         Edit106.Visible:=true;
         CheckBox16.Visible:=true;
      end
      else
         if TLabel(Sender).Caption=Principale.Traduction.Items[471] then
            begin
            TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[472]); // Veuf de
            Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[469]); // # de conjoint
            Label16.Visible:=false;
            Label20.Visible:=false;
            Label21.Visible:=false;
            Label22.Visible:=false;
            Label23.Visible:=false;
            Label9.Visible:=false;
            Edit18.Visible:=false;
            Edit19.Visible:=false;
            Edit20.Visible:=false;
            Edit21.Visible:=false;
            Edit22.Visible:=false;
            Edit23.Visible:=false;
            CheckBox3.Visible:=false;
         end
         else
            if TLabel(Sender).Caption=Principale.Traduction.Items[472] then
               begin
               TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[471]); // Fils de
               Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[452]); // # mère
               Label16.Visible:=true;
               Label20.Visible:=true;
               Label21.Visible:=true;
               Label22.Visible:=true;
               Label23.Visible:=true;
               Label9.Visible:=true;
               Edit18.Visible:=true;
               Edit19.Visible:=true;
               Edit20.Visible:=true;
               Edit21.Visible:=true;
               Edit22.Visible:=true;
               Edit23.Visible:=true;
               CheckBox3.Visible:=true;
            end;
end;


procedure TAjouteMar.MenuItem1Click(Sender: TObject);
begin
  Edit1.Text:='';
  Edit1.PasteFromClipboard;
end;

procedure TAjouteMar.MenuItem6Click(Sender: TObject);
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
       (ActiveControl.Name='Edit93') or
       (ActiveControl.Name='Edit94') or
       (ActiveControl.Name='Edit100') or
       (ActiveControl.Name='Edit106') or
       (ActiveControl.Name='Edit117') or
       (ActiveControl.Name='Edit118') then
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
    if (ActiveControl.Name='Edit6') then
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

procedure TAjouteMar.Edit11DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragName.Caption)>0);
end;

procedure TAjouteMar.Edit16EditingDone(Sender: TObject);
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

procedure TAjouteMar.Edit18DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
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

procedure TAjouteMar.Edit24DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
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

procedure TAjouteMar.Edit11DragDrop(Sender, Source: TObject; X, Y: Integer);
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
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteMar.Edit101DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  Edit101.text:=Principale.Query1.Fields[1].AsString;
  Edit102.text:=Decodename(Principale.Query1.Fields[2].AsString,3);
  Edit103.text:=Decodename(Principale.Query1.Fields[2].AsString,4);
  Edit104.text:=Decodename(Principale.Query1.Fields[2].AsString,5);
  Edit105.text:=Decodename(Principale.Query1.Fields[2].AsString,6);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TAjouteMar.Button3Click(Sender: TObject);
begin
  SaveFormPosition(TButton(Sender).Parent as TForm);
  Close;
end;

procedure TAjouteMar.Button2Click(Sender: TObject);
var
     temp, no_eve, no_mar, nom_personne, X, i3, i4, lieu, annee1, annee2, naissance:string;
     registre, annee, feuillet, acte, date, commentaires, usager:string;
     f_titre, f_prenom, f_nom, f_suffixe, f_metier, f_residence, f_age, f_signature:string;
     pf_titre, pf_prenom, pf_nom, pf_suffixe, pf_metier, pf_feu:string;
     mf_titre, mf_prenom, mf_nom, mf_suffixe, mf_residence, mf_feu:string;
     fe_titre, fe_prenom, fe_nom, fe_suffixe, fe_metier, fe_residence, fe_age, fe_signature:string;
     pfe_titre, pfe_prenom, pfe_nom, pfe_suffixe, pfe_metier, pfe_feu:string;
     mfe_titre, mfe_prenom, mfe_nom, mfe_suffixe, mfe_residence, mfe_feu:string;
     t1_titre, t1_prenom, t1_nom, t1_suffixe, t1_residence, t1_relation, t1_signature, t1_sexe:string;
     t2_titre, t2_prenom, t2_nom, t2_suffixe, t2_residence, t2_relation, t2_signature, t2_sexe:string;
     ligne:TStringList;
     i, pretre, futur, future, pf, pfe, mf, mfe, t1, t2:integer;
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
        futur:=strtoint(Edit11.Text);
     except
        futur:=0;
     end;
     f_titre:=Edit12.Text;
     f_prenom:=Edit13.Text;
     f_nom:=Edit14.Text;
     f_suffixe:=Edit15.Text;
     f_metier:=Edit16.Text;
     f_residence:=EstimatePlace(Edit17.Text,lieu);
     f_age:=Label10.Caption;
     if CheckBox2.Checked then
        f_signature:='X'
     else
        f_signature:='';
     try
        pf:=strtoint(Edit18.Text);
     except
        pf:=0;
     end;
     pf_titre:=Edit19.Text;
     pf_prenom:=Edit20.Text;
     pf_nom:=Edit21.Text;
     pf_suffixe:=Edit22.Text;
     pf_metier:=Edit23.Text;
     if CheckBox3.Checked then
        pf_feu:='X'
     else
        pf_feu:='';
     try
        mf:=strtoint(Edit24.Text);
     except
        mf:=0;
     end;
     mf_titre:=Edit25.Text;
     mf_prenom:=Edit26.Text;
     mf_nom:=Edit29.Text;
     mf_suffixe:=Edit30.Text;
     mf_residence:=EstimatePlace(Edit27.Text,lieu);
     if CheckBox4.Checked then
        mf_feu:='X'
     else
        mf_feu:='';
     try
        future:=strtoint(Edit88.Text);
     except
        future:=0;
     end;
     fe_titre:=Edit89.Text;
     fe_prenom:=Edit90.Text;
     fe_nom:=Edit91.Text;
     fe_suffixe:=Edit92.Text;
     fe_residence:=EstimatePlace(Edit94.Text,lieu);
     fe_age:=Label94.Caption;
     if CheckBox14.Checked then
        fe_signature:='X'
     else
        fe_signature:='';
     try
        pfe:=strtoint(Edit95.Text);
     except
        pfe:=0;
     end;
     pfe_titre:=Edit96.Text;
     pfe_prenom:=Edit97.Text;
     pfe_nom:=Edit98.Text;
     pfe_suffixe:=Edit99.Text;
     pfe_metier:=Edit100.Text;
     if CheckBox15.Checked then
        pfe_feu:='X'
     else
        pfe_feu:='';
     try
        mfe:=strtoint(Edit101.Text);
     except
        mfe:=0;
     end;
     mfe_titre:=Edit102.Text;
     mfe_prenom:=Edit103.Text;
     mfe_nom:=Edit104.Text;
     mfe_suffixe:=Edit105.Text;
     mfe_residence:=EstimatePlace(Edit106.Text,lieu);
     if CheckBox16.Checked then
        mfe_feu:='X'
     else
        mfe_feu:='';
     try
        t1:=strtoint(Edit107.Text);
     except
        t1:=0;
     end;
     t1_sexe:=EditSexe.Hint;
     t1_titre:=Edit108.Text;
     t1_prenom:=Edit109.Text;
     t1_nom:=Edit110.Text;
     t1_suffixe:=Edit111.Text;
     t1_relation:=Edit117.Text;
     if CheckBox17.Checked then
        t1_signature:='X'
     else
        t1_signature:='';
     try
        t2:=strtoint(Edit112.Text);
     except
        t2:=0;
     end;
     t2_sexe:=EditSexe1.Hint;
     t2_titre:=Edit113.Text;
     t2_prenom:=Edit114.Text;
     t2_nom:=Edit115.Text;
     t2_suffixe:=Edit116.Text;
     t2_relation:=Edit118.Text;
     if CheckBox18.Checked then
        t2_signature:='X'
     else
        t2_signature:='';
     commentaires:=Edit119.Text;
     usager:=Edit28.Text;
     // Ajouter le mariage
     // modifie ou ajoute le futur
     nom_personne:=CodeName(f_titre,f_prenom,f_nom,f_suffixe);
     if (futur=0) then // ajoute le futur
        begin
        // ajoute l'individu du bon sexe
        // cherche le prochain numéro vide
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
        Principale.Query2.Open;
        If Principale.Query2.EOF then
           futur:=0
        else
           futur:=Principale.Query2.Fields[0].AsInteger;
        // Créé l'individu
        Principale.Query1.SQL.Clear;
        if (futur=0) then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''M'', ''N'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(futur)+''', ''M'', ''N'', 0)');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
        Principale.Query1.Open;
        Principale.Query1.First;
        if (futur=0) then
           futur:=Principale.Query1.Fields[10].AsInteger-1;
     end;
     // Créé ou modifie le nom
     // cherche si le nom existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(futur)+''' AND N='''+nom_personne+'''');
     Principale.Query1.Open;
     // cherche si un nom principal existe
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(futur)+' AND X=1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        begin
        X:='1';
        if (lowercase(f_age)='mineur') then
           i3:=InterpreteDate('>'+inttostr(strtoint(annee)-21),1)
        else
           if (lowercase(f_age)='majeur') then
              i3:=InterpreteDate('<'+inttostr(strtoint(annee)-21),1)
           else
               i3:=InterpreteDate('',1);
        i4:='';
     end
     else
         begin
         X:='0';
         i3:=Principale.Query2.Fields[2].AsString;
         if (length(i3)=0) then
            if (lowercase(f_age)='mineur') then
               i3:=InterpreteDate('>'+inttostr(strtoint(annee)-21),1)
            else
               if (lowercase(f_age)='majeur') then
                  i3:=InterpreteDate('<'+inttostr(strtoint(annee)-21),1)
               else
                   i3:=InterpreteDate('',1);
         i4:=Principale.Query2.Fields[3].AsString;
     end;
     naissance:=i3;
     no_eve:='';
     If Principale.Query1.EOF then // on doit ajouter le nom
        temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
              inttostr(futur)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
              ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(f_prenom,'\','\\'),'"','\"'),'''','\''')+
              ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(f_nom,'\','\\'),'"','\"'),'''','\''')+
              ''', '''', '''', '''', '''+i3+''','''', '+X+', '''+
              AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(f_titre+' '+f_prenom+' '+f_nom+' '+f_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
     else  // on doit modifier le nom
        begin
        X:=Principale.Query1.Fields[3].AsString;
        no_eve:=Principale.Query1.Fields[2].AsString;
        temp:='UPDATE n SET i3='''+i3+''' WHERE no='+no_eve;
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
     // modifie ou ajoute sa naissance
     // cherche si la naissance existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE I='''+inttostr(futur)+
                                       ''' AND e.X=1 AND w.X=1 AND y.Y=''B''');
     Principale.Query1.Open;
     no_eve:='';
     If Principale.Query1.EOF then // on doit ajouter la naissance
        temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (100, '''+i3+''', '''+i3+''', 1, '''', 1)'
     else // on doit modifier la naissance
        begin
        no_eve:=Principale.Query1.Fields[0].AsString;
        temp:='UPDATE e SET X=1 WHERE no='+no_eve; // en fait ne fait pas de changement
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
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(futur)+', '+no_eve+', 1, '''', ''ENFANT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
     end;
     // ajoute une source pour l'événement
     Principale.Query1.SQL.Clear;
     temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' ('+f_age+')'+' {'+usager+'}';
     Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
     Principale.Query1.ExecSQL;
     if Label19.Caption=AnsitoUTF8(Principale.Traduction.Items[471]) then // si "fils de"
         begin
         // ajoute ses parents
         // si le # de père est pas là
         nom_personne:=CodeName(pf_titre,pf_prenom,pf_nom,pf_suffixe);
         if (pf=0) then // ajoute le père
            begin
            // ajoute l'individu du bon sexe
            // cherche le prochain numéro vide
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
            Principale.Query2.Open;
            If Principale.Query2.EOF then
               pf:=0
            else
               pf:=Principale.Query2.Fields[0].AsInteger;
            // Créé l'individu
            Principale.Query1.SQL.Clear;
            if (pf=0) then
               Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''M'', ''N'', 0)')
            else
               Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(pf)+''', ''M'', ''N'', 0)');
            Principale.Query1.ExecSQL;
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
            Principale.Query1.Open;
            Principale.Query1.First;
            if (pf=0) then
               pf:=Principale.Query1.Fields[10].AsInteger-1;
         end;
         // Créé ou modifie le nom
         // cherche si le nom existe
         Principale.Query1.SQL.Clear;
         Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(pf)+''' AND N='''+nom_personne+'''');
         Principale.Query1.Open;
         // cherche si un nom principal existe
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(pf)+' AND X=1');
         Principale.Query2.Open;
         If Principale.Query2.EOF then
            begin
            X:='1';
            i3:='';
            if (length(pf_feu)>0) then
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
                if (length(pf_feu)>0) then
                   i4:=InterpreteDate('<'+annee,1)
         end;
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter le nom
            temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                  inttostr(pf)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pf_prenom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pf_nom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pf_titre+' '+pf_prenom+' '+pf_nom+' '+pf_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
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
         Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(futur)+' AND B='+inttostr(pf));
         Principale.Query1.Open;
         X:='1';
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter la relation
            temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(futur)+
                  ', '+inttostr(pf)+', '''', '+X+', '''', '''+naissance+''')'
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
         if length(pf_metier)>0 then
            begin
            // cherche si l'occupation existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no, e.PD FROM e JOIN w on e.no=w.E WHERE e.M='''+pf_metier+''' AND e.Y=511 AND w.I='+inttostr(pf));
            Principale.Query1.Open;
            no_eve:='';
            If Principale.Query1.EOF then // on doit ajouter l'occupation
               begin
               if length(pf_feu)=0 then
                  temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''+interpretedate(annee,1)+
                        ''', '''+interpretedate(annee,1)+''', 1, '''+pf_metier+''', 0)'
               else
                  temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''', '''', 1, '''+pf_metier+''', 0)';
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pf)+', '+no_eve+', 1, '''', ''EMPLOYÉ'')';
            end
            else  // on doit modifier l'occupation
               begin
               no_eve:=Principale.Query1.Fields[0].AsString;
               // ne pas modifier les années si pfe est décée
               if length(pf_feu)=0 then
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
         if length(pf_feu)>0 then
            begin
            // cherche si un décès principal existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(pf)+''' AND y.y=''D'' and e.X=1 and w.X=1');
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pf)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
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
         // si le # de mère est pas là
         nom_personne:=CodeName(mf_titre,mf_prenom,mf_nom,mf_suffixe);
         if (mf=0) then // ajoute la mère
            begin
            // ajoute l'individu du bon sexe
            // cherche le prochain numéro vide
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
            Principale.Query2.Open;
            If Principale.Query2.EOF then
               mf:=0
            else
               mf:=Principale.Query2.Fields[0].AsInteger;
            // Créé l'individu
            Principale.Query1.SQL.Clear;
            if (mf=0) then
               Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''F'', ''N'', 0)')
            else
               Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(mf)+''', ''F'', ''N'', 0)');
            Principale.Query1.ExecSQL;
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
            Principale.Query1.Open;
            Principale.Query1.First;
            if (mf=0) then
               mf:=Principale.Query1.Fields[10].AsInteger-1;
         end;
         // Créé ou modifie le nom
         // cherche si le nom existe
         Principale.Query1.SQL.Clear;
         Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(mf)+''' AND N='''+nom_personne+'''');
         Principale.Query1.Open;
         // cherche si un nom principal existe
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(mf)+' AND X=1');
         Principale.Query2.Open;
         If Principale.Query2.EOF then
            begin
            X:='1';
            i3:='';
            if (length(mf_feu)>0) then
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
                if (length(mf_feu)>0) then
                   i4:=InterpreteDate('<'+annee,1)
         end;
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter le nom
            temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                  inttostr(mf)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mf_prenom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mf_nom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mf_titre+' '+mf_prenom+' '+mf_nom+' '+mf_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
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
         Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(futur)+' AND B='+inttostr(mf));
         Principale.Query1.Open;
         X:='1';
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter la relation
            temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(futur)+
                  ', '+inttostr(mf)+', '''', '+X+', '''', '''+naissance+''')'
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
         if length(mf_feu)>0 then
            begin
            // cherche si un décès principal existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(mf)+''' AND y.y=''D'' and e.X=1 and w.X=1');
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mf)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
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
         if (length(mf_residence)>0) then
            begin
            // cherche si la residence existe
            Principale.Query1.SQL.Clear;
            if (length(pf_feu)+length(mf_feu))=0 then
               Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                         +mf_residence+' AND e.Y=550 AND w1.I='+inttostr(pf)+' AND w2.I='+inttostr(mf)+') HAVING temp=2')
            else
               if length(pf_feu)=0 then
                  Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                            +mf_residence+' AND e.Y=550 AND w1.I='+inttostr(pf)+') HAVING temp=1')
               else
                  Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                            +mf_residence+' AND e.Y=550 AND w1.I='+inttostr(mf)+') HAVING temp=1');
            Principale.Query1.Open;
            no_eve:='';
            If Principale.Query1.EOF then // on doit ajouter la résidence
               begin
               temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                     ''', '''+interpretedate(annee,1)+''', '+mf_residence+', '''', 0)';
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
               if (length(pf_feu)+length(mf_feu))=0 then
                  begin
                  temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pf)+', '+no_eve+', 1, '''', ''TEMOIN'')';
                  Principale.Query2.SQL.Clear;
                  Principale.Query2.SQL.Add(temp);
                  Principale.Query2.ExecSQL;
                  temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mf)+', '+no_eve+', 1, '''', ''TEMOIN'')';
               end
               else
                  if length(pf_feu)=0 then
                     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pf)+', '+no_eve+', 1, '''', ''TEMOIN'')'
                  else
                     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mf)+', '+no_eve+', 1, '''', ''TEMOIN'')';
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
     end; // fin de fils de, TODO ajouter le cas "Veuf de"
     // modifie ou ajoute la résidence du futur si 'cette paroisse'
     if (length(f_residence)>0) then
        begin
        // cherche si la residence existe
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E WHERE e.L='
                                  +f_residence+' AND e.Y=550 AND w1.I='+inttostr(futur)+') HAVING temp=1');
        Principale.Query1.Open;
        no_eve:='';
        If Principale.Query1.EOF then // on doit ajouter la résidence
           begin
           temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                 ''', '''+interpretedate(annee,1)+''', '+f_residence+', '''', 0)';
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
           temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(futur)+', '+no_eve+', 1, '''', ''TEMOIN'')';
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
     // ajouter ou modifier la future
     nom_personne:=CodeName(fe_titre,fe_prenom,fe_nom,fe_suffixe);
     if (future=0) then // ajoute la future
        begin
        // ajoute l'individu du bon sexe
        // cherche le prochain numéro vide
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
        Principale.Query2.Open;
        If Principale.Query2.EOF then
           future:=0
        else
           future:=Principale.Query2.Fields[0].AsInteger;
        // Créé l'individu
        Principale.Query1.SQL.Clear;
        if (future=0) then
           Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''F'', ''N'', 0)')
        else
           Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(future)+''', ''F'', ''N'', 0)');
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
        Principale.Query1.Open;
        Principale.Query1.First;
        if (future=0) then
           future:=Principale.Query1.Fields[10].AsInteger-1;
     end;
     // Créé ou modifie le nom
     // cherche si le nom existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(future)+''' AND N='''+nom_personne+'''');
     Principale.Query1.Open;
     // cherche si un nom principal existe
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(future)+' AND X=1');
     Principale.Query2.Open;
     If Principale.Query2.EOF then
        begin
        X:='1';
        if (lowercase(fe_age)='mineure') then
           i3:=InterpreteDate('>'+inttostr(strtoint(annee)-21),1)
        else
           if (lowercase(fe_age)='majeure') then
              i3:=InterpreteDate('<'+inttostr(strtoint(annee)-21),1)
           else
               i3:=InterpreteDate('',1);
        i4:='';
     end
     else
         begin
         X:='0';
         i3:=Principale.Query2.Fields[2].AsString;
         if (length(i3)=0) then
            if (lowercase(fe_age)='mineure') then
               i3:=InterpreteDate('>'+inttostr(strtoint(annee)-21),1)
            else
               if (lowercase(fe_age)='majeure') then
                  i3:=InterpreteDate('<'+inttostr(strtoint(annee)-21),1)
               else
                   i3:=InterpreteDate('',1);
         i4:=Principale.Query2.Fields[3].AsString;
     end;
     naissance:=i3;
     no_eve:='';
     If Principale.Query1.EOF then // on doit ajouter le nom
        temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
              inttostr(future)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
              ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fe_prenom,'\','\\'),'"','\"'),'''','\''')+
              ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fe_nom,'\','\\'),'"','\"'),'''','\''')+
              ''', '''', '''', '''', '''+i3+''','''', '+X+', '''+
              AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(fe_titre+' '+fe_prenom+' '+fe_nom+' '+fe_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
     else  // on doit modifier le nom
        begin
        X:=Principale.Query1.Fields[3].AsString;
        no_eve:=Principale.Query1.Fields[2].AsString;
        temp:='UPDATE n SET i3='''+i3+''' WHERE no='+no_eve;
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
     // modifie ou ajoute sa naissance
     // cherche si la naissance existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT e.no, w.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE I='''+inttostr(future)+
                                       ''' AND e.X=1 AND w.X=1 AND y.Y=''B''');
     Principale.Query1.Open;
     no_eve:='';
     If Principale.Query1.EOF then // on doit ajouter la naissance
        temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (100, '''+i3+''', '''+i3+''', 1, '''', 1)'
     else // on doit modifier la naissance
        begin
        no_eve:=Principale.Query1.Fields[0].AsString;
        temp:='UPDATE e SET X=1 WHERE no='+no_eve; // en fait ne fait pas de changement
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
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(future)+', '+no_eve+', 1, '''', ''ENFANT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
     end;
     // ajoute une source pour l'événement
     Principale.Query1.SQL.Clear;
     temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' ('+fe_age+')'+' {'+usager+'}';
     Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_eve+', 100, 3, '''+temp+''')');
     Principale.Query1.ExecSQL;
     PopulateEvenements;
     if Label122.Caption=AnsitoUTF8(Principale.Traduction.Items[473]) then // si "fille de"
         begin
         // ajoute ses parents
         // si le # de père est pas là
         nom_personne:=CodeName(pfe_titre,pfe_prenom,pfe_nom,pfe_suffixe);
         if (pfe=0) then // ajoute le père
            begin
            // ajoute l'individu du bon sexe
            // cherche le prochain numéro vide
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
            Principale.Query2.Open;
            If Principale.Query2.EOF then
               pfe:=0
            else
               pfe:=Principale.Query2.Fields[0].AsInteger;
            // Créé l'individu
            Principale.Query1.SQL.Clear;
            if (pfe=0) then
               Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''M'', ''N'', 0)')
            else
               Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(pfe)+''', ''M'', ''N'', 0)');
            Principale.Query1.ExecSQL;
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
            Principale.Query1.Open;
            Principale.Query1.First;
            if (pfe=0) then
               pfe:=Principale.Query1.Fields[10].AsInteger-1;
         end;
         // Créé ou modifie le nom
         // cherche si le nom existe
         Principale.Query1.SQL.Clear;
         Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(pfe)+''' AND N='''+nom_personne+'''');
         Principale.Query1.Open;
         // cherche si un nom principal existe
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(pfe)+' AND X=1');
         Principale.Query2.Open;
         If Principale.Query2.EOF then
            begin
            X:='1';
            i3:='';
            if (length(pfe_feu)>0) then
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
                if (length(pfe_feu)>0) then
                   i4:=InterpreteDate('<'+annee,1)
         end;
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter le nom
            temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                  inttostr(pfe)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pfe_prenom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pfe_nom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(pfe_titre+' '+pfe_prenom+' '+pfe_nom+' '+pfe_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
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
         Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(future)+' AND B='+inttostr(pfe));
         Principale.Query1.Open;
         X:='1';
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter la relation
            temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(future)+
                  ', '+inttostr(pfe)+', '''', '+X+', '''', '''+naissance+''')'
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
         if length(pfe_metier)>0 then
            begin
            // cherche si l'occupation existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no, e.PD FROM e JOIN w on e.no=w.E WHERE e.M='''+pfe_metier+''' AND e.Y=511 AND w.I='+inttostr(pfe));
            Principale.Query1.Open;
            no_eve:='';
            If Principale.Query1.EOF then // on doit ajouter l'occupation
               begin
               if length(pfe_feu)=0 then
                  temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''+interpretedate(annee,1)+
                        ''', '''+interpretedate(annee,1)+''', 1, '''+pfe_metier+''', 0)'
               else
                  temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (511, '''', '''', 1, '''+
                                        pfe_metier+''', 0)';
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pfe)+', '+no_eve+', 1, '''', ''EMPLOYÉ'')';
            end
            else  // on doit modifier l'occupation
               begin
               no_eve:=Principale.Query1.Fields[0].AsString;
               // ne pas modifier les années si pfe est décée
               if length(pfe_feu)=0 then
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
         if length(pfe_feu)>0 then
            begin
            // cherche si un décès principal existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(pfe)+''' AND y.y=''D'' and e.X=1 and w.X=1');
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pfe)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
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
         // si le # de mère est pas là
         nom_personne:=CodeName(mfe_titre,mfe_prenom,mfe_nom,mfe_suffixe);
         if (mfe=0) then // ajoute la mère
            begin
            // ajoute l'individu du bon sexe
            // cherche le prochain numéro vide
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('select l.no+1 as start from i as l left outer join i as r on l.no+1 = r.no where r.no is null limit 1');
            Principale.Query2.Open;
            If Principale.Query2.EOF then
               mfe:=0
            else
               mfe:=Principale.Query2.Fields[0].AsInteger;
            // Créé l'individu
            Principale.Query1.SQL.Clear;
            if (mfe=0) then
               Principale.Query1.SQL.Add('INSERT INTO I (S, V, I) VALUES (''F'', ''N'', 0)')
            else
               Principale.Query1.SQL.Add('INSERT INTO I (no, S, V, I) VALUES ('''+inttostr(mfe)+''', ''F'', ''N'', 0)');
            Principale.Query1.ExecSQL;
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
            Principale.Query1.Open;
            Principale.Query1.First;
            if (mfe=0) then
               mfe:=Principale.Query1.Fields[10].AsInteger-1;
         end;
         // Créé ou modifie le nom
         // cherche si le nom existe
         Principale.Query1.SQL.Clear;
         Principale.Query1.SQL.Add('SELECT I, N, no, X FROM n WHERE I='''+inttostr(mfe)+''' AND N='''+nom_personne+'''');
         Principale.Query1.Open;
         // cherche si un nom principal existe
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.Add('SELECT I, X, I3, I4 FROM n WHERE I='+inttostr(mfe)+' AND X=1');
         Principale.Query2.Open;
         If Principale.Query2.EOF then
            begin
            X:='1';
            i3:='';
            if (length(mf_feu)>0) then
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
                if (length(mfe_feu)>0) then
                   i4:=InterpreteDate('<'+annee,1)
         end;
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter le nom
            temp:='INSERT INTO n (Y, I, M, N, I2, I1, PD, SD, P, I3, I4, X, R) VALUES (20, '+
                  inttostr(mfe)+', '''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(nom_personne,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mfe_prenom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mfe_nom,'\','\\'),'"','\"'),'''','\''')+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''+InterpreteDate('',1)+
                  ''', '''', '''+i3+''','''+i4+''', '+X+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mfe_titre+' '+mfe_prenom+' '+mfe_nom+' '+mfe_suffixe,'\','\\'),'"','\"'),'''','\''')+''')'
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
         Principale.Query1.SQL.Add('SELECT no, A, B, X, SD FROM r WHERE Y=10 AND A='+inttostr(future)+' AND B='+inttostr(mfe));
         Principale.Query1.Open;
         X:='1';
         no_eve:='';
         If Principale.Query1.EOF then // on doit ajouter la relation
            temp:='INSERT INTO r (Y, A, B, M, X, P, SD) VALUES (10, '+inttostr(future)+
                  ', '+inttostr(mfe)+', '''', '+X+', '''', '''+naissance+''')'
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
         if length(mfe_feu)>0 then
            begin
            // cherche si un décès principal existe
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.Add('SELECT e.no FROM e JOIN w on e.no=w.e JOIN y on e.y=y.no WHERE w.I='''+inttostr(mfe)+''' AND y.y=''D'' and e.X=1 and w.X=1');
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
               temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mfe)+', '+no_eve+', 1, '''', ''DÉCÉDÉ'')';
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
         if (length(mfe_residence)>0) then
            begin
            // cherche si la residence existe
            Principale.Query1.SQL.Clear;
            if (length(pfe_feu)+length(mfe_feu))=0 then
               Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                         +mfe_residence+' AND e.Y=550 AND w1.I='+inttostr(pfe)+' AND w2.I='+inttostr(mfe)+') HAVING temp=2')
            else
               if length(pfe_feu)=0 then
                  Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                            +mfe_residence+' AND e.Y=550 AND w1.I='+inttostr(pfe)+') HAVING temp=1')
               else
                  Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E join w w2 on e.no=w2.E WHERE e.L='
                                            +mfe_residence+' AND e.Y=550 AND w1.I='+inttostr(mfe)+') HAVING temp=1');
            Principale.Query1.Open;
            no_eve:='';
            If Principale.Query1.EOF then // on doit ajouter la résidence
               begin
               temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                     ''', '''+interpretedate(annee,1)+''', '+mfe_residence+', '''', 0)';
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
               if (length(pfe_feu)+length(mfe_feu))=0 then
                  begin
                  temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pfe)+', '+no_eve+', 1, '''', ''TEMOIN'')';
                  Principale.Query2.SQL.Clear;
                  Principale.Query2.SQL.Add(temp);
                  Principale.Query2.ExecSQL;
                  temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mfe)+', '+no_eve+', 1, '''', ''TEMOIN'')';
               end
               else
                  if length(pfe_feu)=0 then
                     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pfe)+', '+no_eve+', 1, '''', ''TEMOIN'')'
                  else
                     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mfe)+', '+no_eve+', 1, '''', ''TEMOIN'')';
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
         end; // fin de fils de, TODO ajouter le cas "Veuf de"
     end;
     // modifie ou ajoute la résidence de la future si 'cette paroisse'
     if (length(fe_residence)>0) then
        begin
        // cherche si la residence existe
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT w.e, e.PD, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.E IN (SELECT e.no FROM e join w w1 ON e.no=w1.E WHERE e.L='
                                  +fe_residence+' AND e.Y=550 AND w1.I='+inttostr(future)+') HAVING temp=1');
        Principale.Query1.Open;
        no_eve:='';
        If Principale.Query1.EOF then // on doit ajouter la résidence
           begin
           temp:='INSERT INTO e (Y, PD, SD, L, M, X) VALUES (550, '''+interpretedate(annee,1)+
                 ''', '''+interpretedate(annee,1)+''', '+fe_residence+', '''', 0)';
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
           temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(future)+', '+no_eve+', 1, '''', ''TEMOIN'')';
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
     // modifier ou ajouter le mariage des parents du futur
     // cherche si le mariage existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT w.e, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.X=1 AND w.E IN (SELECT e.no FROM e JOIN w w1 ON e.no=w1.E JOIN w w2 on e.no=w2.E WHERE e.Y=300 AND w1.I='
                                +inttostr(pf)+' AND w2.I='+inttostr(mf)+' AND e.X=1 AND w1.X=1 AND w2.X=1) HAVING temp=2');
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
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pf)+', '+no_eve+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mf)+', '+no_eve+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
     end;
     // modifier ou ajouter le mariage des parents de la future
     // cherche si le mariage existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT w.e, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.X=1 AND w.E IN (SELECT e.no FROM e JOIN w w1 ON e.no=w1.E JOIN w w2 on e.no=w2.E WHERE e.Y=300 AND w1.I='
                                +inttostr(pfe)+' AND w2.I='+inttostr(mfe)+' AND e.X=1 AND w1.X=1 AND w2.X=1) HAVING temp=2');
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
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pfe)+', '+no_eve+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(mfe)+', '+no_eve+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
     end;
     // modifier ou ajouter le mariage
     // cherche si le mariage existe
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT w.e, COUNT(*) as temp FROM w join e on w.e=e.no WHERE w.X=1 AND w.E IN (SELECT e.no FROM e JOIN w w1 ON e.no=w1.E JOIN w w2 on e.no=w2.E WHERE e.Y=300 AND w1.I='
                                +inttostr(futur)+' AND w2.I='+inttostr(future)+' AND e.X=1 AND w1.X=1 AND w2.X=1) HAVING temp=2');
     Principale.Query1.Open;
     no_mar:='';
     If Principale.Query1.EOF then // on doit ajouter le mariage
        temp:='INSERT into e (Y, PD, SD, L, M, X) VALUES (300, '''+date+''', '''+date+''', '+lieu+', '''', 1)'
     else // on doit modifier le mariage
        begin
        no_mar:=Principale.Query1.Fields[0].AsString;
        temp:='UPDATE e SET PD='''+date+''', SD='''+date+''', L='+lieu+' WHERE no='+no_mar;
     end;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     if (no_mar='') then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
        Principale.Query1.Open;
        Principale.Query1.First;
        no_mar:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(futur)+', '+no_mar+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
        temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(future)+', '+no_mar+', 1, '''', ''CONJOINT'')';
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add(temp);
        Principale.Query2.ExecSQL;
     end;
     // ajoute une source pour l'événement
     Principale.Query1.SQL.Clear;
     temp:=Registre+', '+Annee+', p. '+feuillet+', '+acte+' {'+usager+'}';
     Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''E'', '+no_mar+', 100, 3, '''+temp+''')');
     Principale.Query1.ExecSQL;
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
     // vérifier si la source existe déjà au cas où le témoin est le père ou mère
     Principale.Query1.SQL.Add('SELECT no FROM c WHERE y=''N'' AND N='+no_eve+' AND S=100 AND M='''+temp+'''');
     Principale.Query1.Open;
     If Principale.Query1.EOF then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
        Principale.Query1.ExecSQL;
     end;
     // ajoute le temoin #2
     nom_personne:=CodeName(t2_titre,t2_prenom,t2_nom,t2_suffixe);
     if (t2=0) then // ajoute le témoin #2
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
     // vérifier si la source existe déjà au cas où le témoin est le père ou mère
     Principale.Query1.SQL.Add('SELECT no FROM c WHERE y=''N'' AND N='+no_eve+' AND S=100 AND M='''+temp+'''');
     Principale.Query1.Open;
     If Principale.Query1.EOF then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('INSERT INTO c (Y, N, S, Q, M) VALUES (''N'', '+no_eve+', 100, 3, '''+temp+''')');
        Principale.Query1.ExecSQL;
     end;
     // ajouter le célébrant
     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(pretre)+', '+no_mar+', 0, '''', ''CELEBRANT'')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     // ajouter le témoin #1
     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(t1)+', '+no_mar+', 0, '''', ''TEMOIN'')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     // ajouter le témoin #2
     temp:='INSERT into w (I, E, X, P, R) VALUES ('+inttostr(t2)+', '+no_mar+', 0, '''', ''TEMOIN'')';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add(temp);
     Principale.Query2.ExecSQL;
     // Affiche la personne
     SaveModificationTime(inttostr(futur));
     SaveModificationTime(inttostr(future));
     Principale.Individu.Caption:=inttostr(futur);
     PopulateNom;
     PopulateEvenements;
     PopulateParents;
     SaveFormPosition(TButton(Sender).Parent as TForm);
     Close;
end;

procedure TAjouteMar.Button1Click(Sender: TObject);
var
   ligne:TStringList;
   filename:string;
begin
  ligne:=TStringList.Create;
  ligne.text:=ReplaceText(Edit1.text,#9,#13#10);
  if ligne.Count=69 then
     begin
     Edit2.Text:=ligne.strings[0];
     Edit3.Text:=ligne.strings[1];
     Edit4.Text:=ligne.strings[2];
     Edit5.Text:=ligne.strings[3];
     Edit6.Text:=InterpreteDate(AnsiReplaceStr(ligne.strings[4],'-','.'),0);
     Edit7.Text:=ligne.strings[5];
     Edit11.Text:=ligne.strings[6];
     Edit12.Text:=ligne.strings[7];
     Edit13.Text:=ligne.strings[8];
     Edit14.Text:=ligne.strings[9];
     Edit15.Text:=ligne.strings[10];
     Edit16.Text:=ligne.strings[11];
     Edit17.Text:=ligne.strings[12];
     if copy(lowercase(ligne.strings[13]),1,6)='majeur' then
        Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[459]) // Mineur
     else
        Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[466]); // Majeur
     CheckBox2.checked:=length(ligne.strings[14])>0;
     If length(ligne.strings[15])>0 then
        begin
        Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[471]); // Fils de
        Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[452]); // # mère
        Label16.Visible:=true;
        Label20.Visible:=true;
        Label21.Visible:=true;
        Label22.Visible:=true;
        Label23.Visible:=true;
        Label9.Visible:=true;
        Edit18.Visible:=true;
        Edit19.Visible:=true;
        Edit20.Visible:=true;
        Edit21.Visible:=true;
        Edit22.Visible:=true;
        Edit23.Visible:=true;
        CheckBox3.Visible:=true;
     end;
     If length(ligne.strings[16])>0 then
        begin
        Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[472]); // Veuf de
        Label17.Caption:=AnsitoUTF8(Principale.Traduction.Items[469]); // # de conjoint
        Label16.Visible:=false;
        Label20.Visible:=false;
        Label21.Visible:=false;
        Label22.Visible:=false;
        Label23.Visible:=false;
        Label9.Visible:=false;
        Edit18.Visible:=false;
        Edit19.Visible:=false;
        Edit20.Visible:=false;
        Edit21.Visible:=false;
        Edit22.Visible:=false;
        Edit23.Visible:=false;
        CheckBox3.Visible:=false;
     end;
     Edit18.Text:=ligne.strings[17];
     Edit19.Text:=ligne.strings[18];
     Edit20.Text:=ligne.strings[19];
     Edit21.Text:=ligne.strings[20];
     Edit22.Text:=ligne.strings[21];
     Edit23.Text:=ligne.strings[22];
     CheckBox3.checked:=length(ligne.strings[23])>0;
     Edit24.Text:=ligne.strings[24];
     Edit25.Text:=ligne.strings[25];
     Edit26.Text:=ligne.strings[26];
     Edit29.Text:=ligne.strings[27];
     Edit30.Text:=ligne.strings[28];
     Edit27.Text:=ligne.strings[29];
     CheckBox4.checked:=length(ligne.strings[30])>0;
     Edit88.Text:=ligne.strings[31];
     Edit89.Text:=ligne.strings[32];
     Edit90.Text:=ligne.strings[33];
     Edit91.Text:=ligne.strings[34];
     Edit92.Text:=ligne.strings[35];
     Edit94.Text:=ligne.strings[36];
     if copy(lowercase(ligne.strings[37]),1,6)='majeur' then
        Label94.Caption:=AnsitoUTF8(Principale.Traduction.Items[462]) // Mineure
     else
        Label94.Caption:=AnsitoUTF8(Principale.Traduction.Items[467]); // Majeure
     CheckBox14.checked:=length(ligne.strings[38])>0;
     If length(ligne.strings[39])>0 then
        begin
        Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[473]); // Fille de
        Label96.Caption:=AnsitoUTF8(Principale.Traduction.Items[448]); // # de père
        Label102.Visible:=true;
        Label103.Visible:=true;
        Label104.Visible:=true;
        Label105.Visible:=true;
        Label106.Visible:=true;
        Label107.Visible:=true;
        Edit101.Visible:=true;
        Edit102.Visible:=true;
        Edit103.Visible:=true;
        Edit104.Visible:=true;
        Edit105.Visible:=true;
        Edit106.Visible:=true;
        CheckBox16.Visible:=true;
     end;
     If length(ligne.strings[40])>0 then
        begin
        Label19.Caption:=AnsitoUTF8(Principale.Traduction.Items[474]); // Veuve de
        TLabel(Sender).Caption:=AnsitoUTF8(Principale.Traduction.Items[474]); // Veuve de
        Label96.Caption:=AnsitoUTF8(Principale.Traduction.Items[469]); // # de conjoint
        Label102.Visible:=false;
        Label103.Visible:=false;
        Label104.Visible:=false;
        Label105.Visible:=false;
        Label106.Visible:=false;
        Label107.Visible:=false;
        Edit101.Visible:=false;
        Edit102.Visible:=false;
        Edit103.Visible:=false;
        Edit104.Visible:=false;
        Edit105.Visible:=false;
        Edit106.Visible:=false;
        CheckBox16.Visible:=false;
     end;
     Edit95.Text:=ligne.strings[41];
     Edit96.Text:=ligne.strings[42];
     Edit97.Text:=ligne.strings[43];
     Edit98.Text:=ligne.strings[44];
     Edit99.Text:=ligne.strings[45];
     Edit100.Text:=ligne.strings[46];
     CheckBox15.checked:=length(ligne.strings[47])>0;
     Edit101.Text:=ligne.strings[48];
     Edit102.Text:=ligne.strings[49];
     Edit103.Text:=ligne.strings[50];
     Edit104.Text:=ligne.strings[51];
     Edit105.Text:=ligne.strings[52];
     Edit106.Text:=ligne.strings[53];
     CheckBox16.checked:=length(ligne.strings[54])>0;
     Edit107.Text:=ligne.strings[55];
     if ligne.strings[56]='M' then
        EditSexe.Hint:='M'
     else
        if ligne.strings[56]='F' then
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
     Edit107.Text:=ligne.strings[57];
     Edit108.Text:=ligne.strings[58];
     Edit109.Text:=ligne.strings[59];
     Edit110.Text:=ligne.strings[60];
     Edit117.Text:=ligne.strings[61];
     CheckBox17.checked:=length(ligne.strings[62])>0;
     Edit112.Text:=ligne.strings[63];
     if ligne.strings[64]='M' then
        EditSexe1.Hint:='M'
     else
        if ligne.strings[64]='F' then
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
     Edit113.Text:=ligne.strings[65];
     Edit114.Text:=ligne.strings[66];
     Edit115.Text:=ligne.strings[67];
     Edit116.Text:=ligne.strings[68];
     Edit118.Text:=ligne.strings[69];
     CheckBox18.checked:=length(ligne.strings[71])>0;
     Edit118.Text:=ligne.strings[71];
     Edit28.Text:=ligne.strings[72];
  end;
  ligne.free;
end;

procedure TAjouteMar.Edit107DragDrop(Sender, Source: TObject; X, Y: Integer);
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

procedure TAjouteMar.Edit112DragDrop(Sender, Source: TObject; X, Y: Integer);
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
  EditSexe.Hint:=Principale.Query1.Fields[9].AsString;
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

end.

