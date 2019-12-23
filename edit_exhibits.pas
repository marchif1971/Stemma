unit Edit_Exhibits;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, FMUtils, StrUtils, IniFiles, Process;

type

  { TEditExhibits }

  TEditExhibits = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MenuItem2: TMenuItem;
    Z: TMemo;
    Label3: TLabel;
    Description: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Type1: TEdit;
    OpenDialog: TOpenDialog;
    Titre: TEdit;
    Label2: TLabel;
    Primaire: TCheckBox;
    No: TEdit;
    Label1: TLabel;
    Fichier: TEdit;
    N: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DescriptionEditingDone(Sender: TObject);
    procedure FichierDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure TitreEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  EditExhibits: TEditExhibits;

implementation

uses
  unit1, Show_Image, noms;

{ TEditExhibits }

procedure TEditExhibits.FormShow(Sender: TObject);
var
  code,nocode:string;
begin
  Principale.DataHist.Row:=0;
  EditExhibits.ActiveControl:=EditExhibits.Titre;
  GetFormPosition(Sender as TForm,0,0,208,497);
  Caption:=AnsitoUTF8(Principale.Traduction.Items[178]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[179]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[162]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[180]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Button3.Caption:=AnsitoUTF8(Principale.Traduction.Items[181]);
  GetCode(code,nocode);
  N.Text:=nocode;
  if code='A' then
     begin
     EditExhibits.Caption:=AnsitoUTF8(Principale.Traduction.Items[33]);
     No.Text:='0';
     Titre.text:='';
     Description.Text:='';
     Fichier.Text:='';
     Primaire.Checked:=false;
     GetCode(code,nocode);
     Type1.Text:=code;
     Z.Text:='';
     end
  else
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT X.no, X.X, X.T, X.D, X.F, X.Z, X.A FROM X WHERE (X.no='+
                               N.Text+')');
     Principale.Query1.Open;
     Principale.Query1.First;
     No.Text:=Principale.Query1.Fields[0].AsString;
     Primaire.Checked:=Principale.Query1.Fields[1].AsBoolean;
     Titre.Text:=Principale.Query1.Fields[2].AsString;
     Description.Text:=Principale.Query1.Fields[3].AsString;
     Fichier.Text:=Principale.Query1.Fields[4].AsString;
     Type1.Text:=Principale.Query1.Fields[6].AsString;
     Z.Text:=Principale.Query1.Fields[5].AsString;
  end;
end;

procedure TEditExhibits.MenuItem1Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditExhibits.MenuItem2Click(Sender: TObject);  // Repeat
var
  j:integer;
  found:boolean;
begin
  if EditExhibits.ActiveControl.Name='Titre' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='Titre' then
           begin
           Titre.text:=Principale.DataHist.Cells[1,j];
           TitreEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='Titre' then
              begin
              Titre.text:=Principale.DataHist.Cells[1,j];
              TitreEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if EditExhibits.ActiveControl.Name='Description' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='Description' then
           begin
           Description.text:=Principale.DataHist.Cells[1,j];
           DescriptionEditingDone(Sender);
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='Description' then
              begin
              Description.text:=Principale.DataHist.Cells[1,j];
              DescriptionEditingDone(Sender);
              found:=true;
              break;
           end;
        end;
     end;
  end;
  if found then Principale.DataHist.Row:=j+1;
end;

procedure TEditExhibits.TitreEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='Titre';
  Principale.DataHist.Cells[1,0]:=Titre.Text;
end;

procedure TEditExhibits.FichierDblClick(Sender: TObject);
begin
  OpenDialog.FileName:=Fichier.Text;
  OpenDialog.InitialDir:=ExtractFilePath(Fichier.Text);
  if OpenDialog.Execute then
     Fichier.Text:=OpenDialog.FileName;
end;

procedure TEditExhibits.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TEditExhibits.Button3Click(Sender: TObject);
var
  ini:TIniFile;
  pdf:string;
begin
  if length(Fichier.Text)=0 then
     begin
     ShowImage.Caption:=Principale.Traduction.Items[34];
     ShowImage.Image.Visible:=false;
     ShowImage.Memo.Visible:=true;
     ShowImage.Button1.Visible:=true;
     ShowImage.Button2.Visible:=true;
     if no.text='0' then
        ShowImage.Memo.Text:=''
     else
        ShowImage.Memo.Text:=Z.Text;
     if ShowImage.Showmodal=mrOk then
        begin
        if no.text='0' then
           Button1Click(Sender);
        Z.Text:=ShowImage.Memo.Text;
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('UPDATE X SET Z='''+
           AnsiReplaceStr(AnsiReplaceStr(ShowImage.Memo.Text,'"','\"'),'''','\''')+
           ''' WHERE X.no='+no.text);
        Principale.Query2.ExecSQL;
        // Enregistrer la date de la dernière modification pour tout les individus reliés
        // à cet exhibits.
        if type1.Text='I' then
           begin
           SaveModificationTime(Principale.Individu.Caption);
           PopulateNom;
        end;
        if type1.Text='E' then
           begin
           Principale.Query3.SQL.Clear;
           Principale.Query3.SQL.Add('SELECT W.I FROM (W JOIN E on W.E=E.no) JOIN X on X.N=E.no WHERE X.no='+
                                     no.Text);
           Principale.Query3.Open;
           Principale.Query3.First;
           while not Principale.Query3.EOF do
              begin
              SaveModificationTime(Principale.Query3.Fields[0].Asstring);
              Principale.Query3.Next;
           end;
           PopulateNom;
        end;
     end;
  end
  else
        begin
        if AnsiPos('.PDF',Fichier.Text)>0 then
           begin
           Ini := TIniFile.Create('Stemma.ini');
           pdf := ini.ReadString('Parametres','PDF','C:\Program Files (x86)\Adobe\Reader 10.0\Reader\AcroRd32.exe');
           with TProcess.Create(nil) do
           try
              CommandLine:=pdf+' '+Fichier.Text;
              Execute;
              ini.WriteString('Parametres','PDF',pdf);
           finally
              Free;
           end;
           Ini.Free;
        end
        else
           begin
           ShowImage.Caption:=Fichier.Text;
           ShowImage.Memo.Visible:=false;
           ShowImage.Button1.Visible:=false;
           ShowImage.Button2.Visible:=false;
           ShowImage.Image.Visible:=true;
           ShowImage.Image.Picture.LoadFromFile(Fichier.Text);
           ShowImage.Showmodal;
        end;
     end;
end;

procedure TEditExhibits.DescriptionEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='Description';
  Principale.DataHist.Cells[1,0]:=Description.Text;
end;

procedure TEditExhibits.Button1Click(Sender: TObject);
begin
  Principale.Query1.SQL.Clear;
  if no.text='0' then
     Principale.Query1.SQL.Add('INSERT INTO X (X, T, D, F, A, N) VALUES ( 0, '''+
       AnsiReplaceStr(AnsiReplaceStr(Titre.Text,'"','\"'),'''','\''')+
       ''', '''+AnsiReplaceStr(AnsiReplaceStr(Description.Text,'"','\"'),'''','\''')+
       ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Fichier.Text,'\','\\'),'"','\"'),'''','\''')+
       ''', '''+Type1.text+''', '+N.Text+')')
  else
     Principale.Query1.SQL.Add('UPDATE X SET T='''+
       AnsiReplaceStr(AnsiReplaceStr(Titre.Text,'"','\"'),'''','\''')+
       ''', D='''+AnsiReplaceStr(AnsiReplaceStr(Description.Text,'"','\"'),'''','\''')+
       ''', F='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Fichier.Text,'\','\\'),'"','\"'),'''','\''')+
       ''' WHERE X.no='+no.text);
  Principale.Query1.ExecSQL;
  // Enregistrer la date de la dernière modification pour tout les individus reliés
  // à cet exhibits.
  if no.text='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''X''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
  if type1.Text='I' then
     begin
     SaveModificationTime(Principale.Individu.Caption);
     PopulateNom;
  end;
  if type1.Text='E' then
     begin
     Principale.Query3.SQL.Clear;
     Principale.Query3.SQL.Add('SELECT W.I FROM (W JOIN E on W.E=E.no) JOIN X on X.N=E.no WHERE X.no='+
                                no.Text);
     Principale.Query3.Open;
     Principale.Query3.First;
     while not Principale.Query3.EOF do
       begin
       SaveModificationTime(Principale.Query3.Fields[0].Asstring);
       Principale.Query3.Next;
       end;
       PopulateNom;
  end;
end;

{ TEditExhibits }


{$R *.lfm}

end.

