unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, StdCtrls, ZConnection, ZDataset, FMUtils, ConnectDb,
  IniFiles, Noms, dbf, mysql57conn, sqldb, StrUtils, Math, DateUtils,
  Explorateur, Parents, Historique, Enfants, Fratrie, Evenements, Exhibits,
  Ancetres, Descendants, Image, Lieux, Sources, Depots, unitTypes, LCLType,
  Grids, a_propos, Edit_Nom, SelectPersonne, Edit_Evenements, ToDoList,
  ZoneTampon, Explorateur2, AjouteBapteme, AjouteMariage, AjouterSepulture{%H-};

type

  { TPrincipale }

  TPrincipale = class(TForm)
    DataHist: TStringGrid;
    DragValue: TEdit;
    DragName: TEdit;
    DragList: TEdit;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    FILO: TStringGrid;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem70: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    MenuItem73: TMenuItem;
    MenuItem74: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem79: TMenuItem;
    MenuItem80: TMenuItem;
    MenuItem81: TMenuItem;
    MenuItem82: TMenuItem;
    Traduction: TListBox;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    Individu: TEdit;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    OldIndividu: TListBox;
    Old1: TMenuItem;
    Old2: TMenuItem;
    Old3: TMenuItem;
    Old4: TMenuItem;
    Old5: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    OpenDialog1: TOpenDialog;
    ProgressBar: TProgressBar;
    Query2: TZQuery;
    Query3: TZQuery;
    Query4: TZQuery;
    StatusBar: TStatusBar;
    Timer1: TTimer;
    TMG: TDbf;
    MainMenu: TMainMenu;
    Menu1_1: TMenuItem;
    Creer_projet: TMenuItem;
    Connexion: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    Supprimer_projet: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Ouvrir_projet: TMenuItem;
    Importer_projet: TMenuItem;
    MenuItem4: TMenuItem;
    Quitter: TMenuItem;
    Database: TZConnection;
    Query1: TZQuery;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure ConnexionClick(Sender: TObject);
    procedure Creer_projetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Importer_projetClick(Sender: TObject);
    procedure IndividuChange(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem61Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem67Click(Sender: TObject);
    procedure MenuItem68Click(Sender: TObject);
    procedure MenuItem69Click(Sender: TObject);
    procedure MenuItem71Click(Sender: TObject);
    procedure MenuItem72Click(Sender: TObject);
    procedure MenuItem73Click(Sender: TObject);
    procedure MenuItem76Click(Sender: TObject);
    procedure MenuItem77Click(Sender: TObject);
    procedure MenuItem78Click(Sender: TObject);
    procedure MenuItem79Click(Sender: TObject);
    procedure MenuItem81Click(Sender: TObject);
    procedure MenuItem82Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure OldClick(Sender: TObject);
    procedure Supprimer_projetClick(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Ouvrir_projetClick(Sender: TObject);
    procedure QuitterClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure GetFirstRecord();

var
  Principale: TPrincipale;

implementation

{$R *.lfm}

{ TPrincipale }

procedure TPrincipale.QuitterClick(Sender: TObject);
begin
  if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[0])),pchar(AnsitoUTF8(Traduction.Items[1])),MB_YESNO)=IDYES then
      Principale.close;
end;

procedure TPrincipale.Timer1Timer(Sender: TObject);
begin
  Principale.StatusBar.Panels[0].Text := FormatDateTime('DD/MM/YYYY hh:nn:ss',now);
end;

procedure TPrincipale.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
     ini:TIniFile;
     i:integer;
begin
     SaveFormPosition(Sender as TForm);
     Ini := TIniFile.Create('Stemma.ini');
     If (Principale.Database.Connected) and (not (Principale.Individu.Caption='Individu')) then
     begin
        Ini.WriteInteger('DB','Connecté',1);
        Ini.WriteString('DB','DB',Principale.Database.Database);
        Ini.WriteString('DB','Individu',Principale.Individu.Caption);
        If MenuItem13.Checked then
        begin
           Ini.WriteInteger('Fenetre','Explorateur',1);
           FormExplorateur.Close;
        end
        else
           Ini.WriteInteger('Fenetre','Explorateur',0);
        If MenuItem8.Checked then
        begin
           Ini.WriteInteger('Fenetre','Noms',1);
           FormNoms.Close;
        end
        else
           Ini.WriteInteger('Fenetre','Noms',0);
        If MenuItem9.Checked then
           Ini.WriteInteger('Fenetre','Événements',1)
        else
           Ini.WriteInteger('Fenetre','Événements',0);
        If MenuItem10.Checked then
        begin
           Ini.WriteInteger('Fenetre','Parents',1);
           FormParents.Close;
        end
        else
           Ini.WriteInteger('Fenetre','Parents',0);
        If MenuItem11.Checked then
           Ini.WriteInteger('Fenetre','Exhibits',1)
        else
           Ini.WriteInteger('Fenetre','Exhibits',0);
        If MenuItem14.Checked then
           Ini.WriteInteger('Fenetre','Enfants',1)
        else
           Ini.WriteInteger('Fenetre','Enfants',0);
        If MenuItem15.Checked then
           Ini.WriteInteger('Fenetre','Fratrie',1)
        else
           Ini.WriteInteger('Fenetre','Fratrie',0);
        If MenuItem16.Checked then
           Ini.WriteInteger('Fenetre','Ancêtres',1)
        else
           Ini.WriteInteger('Fenetre','Ancêtres',0);
        If MenuItem23.Checked then
           Ini.WriteInteger('Fenetre','Descendants',1)
        else
           Ini.WriteInteger('Fenetre','Descendants',0);
        If MenuItem26.Checked then
           Ini.WriteInteger('Fenetre','Image',1)
        else
           Ini.WriteInteger('Fenetre','Image',0);
        If MenuItem72.Checked then
           Ini.WriteInteger('Fenetre','ToDoList',1)
        else
           Ini.WriteInteger('Fenetre','ToDoList',0);
        If MenuItem73.Checked then
           Ini.WriteInteger('Fenetre','ZoneTampon',1)
        else
           Ini.WriteInteger('Fenetre','ZoneTampon',0);
        If MenuItem77.Checked then
           Ini.WriteInteger('Fenetre','Explorateur2',1)
        else
           Ini.WriteInteger('Fenetre','Explorateur2',0);
     end
     else
        Ini.WriteInteger('DB','Connecté',0);
     Ini.Free;
     // Sauvegarde l'historique de données
     if DataHist.RowCount>1000 then
        DataHist.RowCount:=1000;
     DataHist.SaveToFile('HistD.data');
     // Sauvegarde l'historique d'individu
     if OldIndividu.Items.Count>1000 then
        for i:=OldIndividu.Items.Count-1 downto 1000 do
        OldIndividu.Items.Delete(i);
     OldIndividu.Items.SaveToFile('HistP.data');
end;





procedure TPrincipale.ConnexionClick(Sender: TObject);
begin
  If ConnexionDb.Showmodal = mrOK then
  begin
    Principale.Database.LibraryLocation:='C:\Stemma\libmysql.dll';
    Principale.Database.HostName := ConnexionDb.HostName.Caption;
    Principale.Database.User := ConnexionDb.USager.Caption;
    Principale.Database.Password := ConnexionDb.Password.Caption;
    try
      Principale.Database.Connected:=true;
    except
      on e:Exception do
      begin
            Showmessage(AnsitoUTF8(Traduction.Items[2]));
            Showmessage(e.Message);
      end;
    end;
    if Principale.Database.Connected then
    begin
      Principale.Creer_projet.Enabled:=true;
      Principale.Ouvrir_projet.Enabled:=true;
      Principale.Importer_projet.Enabled:=true;
      Principale.Supprimer_projet.Enabled:=true;
    end;
  end;
end;

procedure TPrincipale.Creer_projetClick(Sender: TObject);
var
   ini:TIniFile;
   db,buffer:string;
   temp:TStringList;
   i:integer;
   tdata:textfile;
begin
  Ini := TIniFile.Create('Stemma.ini');
  db:=ini.ReadString('DB','DB','Stemma_data');
  if InputQuery(AnsitoUTF8(Traduction.Items[3]),AnsitoUTF8(Traduction.Items[4]),db) then
     begin
     // Avant de créer le projet, fermer le project actif
     // Créer la base de données          CREATE DATABASE `stemma_data`
     try
        Principale.Caption := 'Stemma';
        // Fermer toutes les fenêtres ouvertes
        If MenuItem13.Checked then FormExplorateur.Close;
        If MenuItem8.Checked then FormNoms.Close;
        If MenuItem9.Checked then FormEvenements.Close;
        If MenuItem10.Checked then FormParents.Close;
        If MenuItem11.Checked then FormExhibits.Close;
        If MenuItem14.Checked then FormEnfants.Close;
        If MenuItem15.Checked then FormFratrie.Close;
        If MenuItem16.Checked then FormAncetres.Close;
        If MenuItem23.Checked then FormDescendants.Close;
        If MenuItem26.Checked then FormImage.Close;
        Principale.Individu.Caption:='0';
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('CREATE DATABASE '+db);
        Principale.Query1.ExecSQL;
        Principale.Database.Connected:=false;
        Principale.Database.Database := db;
        Principale.Database.Connected:= true;
        temp := TStringList.Create;
        // Réviser structure
        temp.add('CREATE TABLE Y (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), Y CHAR(1), P MEDIUMTEXT NULL, R MEDIUMTEXT NULL);');
        temp.add('CREATE TABLE L (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, L TINYTEXT);');
        temp.add('CREATE TABLE N (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED, Y SMALLINT(5) UNSIGNED, N TEXT, X BOOL, M TEXT, P MEDIUMTEXT, PD TINYTEXT, SD TINYTEXT, I1 VARCHAR(35), I2 VARCHAR(35), I3 VARCHAR(21), I4 VARCHAR(21));');
        temp.add('CREATE FULLTEXT INDEX N ON N (N);');
        temp.add('CREATE INDEX I ON N (I);');
        temp.add('CREATE INDEX I1 ON N (I1);');
        temp.add('CREATE INDEX I2 ON N (I2);');
        temp.add('CREATE INDEX I3 ON N (I3);');
        temp.add('CREATE INDEX I4 ON N (I4);');
        temp.add('CREATE TABLE R (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y SMALLINT(5) UNSIGNED, A MEDIUMINT(8) UNSIGNED, B MEDIUMINT(8) UNSIGNED, M TINYTEXT NULL, X BOOL, P MEDIUMTEXT NULL, SD TINYTEXT NULL);');
        temp.add('CREATE INDEX A ON R (A);');
        temp.add('CREATE INDEX B ON R (B);');
        temp.add('CREATE TABLE E (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y SMALLINT(5) UNSIGNED, PD TINYTEXT, SD TINYTEXT, L MEDIUMINT(8) UNSIGNED, M TEXT NULL, X BOOL);');
        temp.add('CREATE FULLTEXT INDEX M ON E (M);');
        temp.add('CREATE TABLE W (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED, E MEDIUMINT(8) UNSIGNED, X BOOL, P TINYTEXT NULL, R VARCHAR(20));');
        temp.add('CREATE INDEX E ON W (E);');
        temp.add('CREATE INDEX I ON W (I);');
        temp.add('CREATE TABLE I (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S CHAR(1), V CHAR(1), I TINYINT(2) UNSIGNED, date CHAR(8));');
        temp.add('CREATE TABLE X (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, X BOOL, T VARCHAR(35), D TINYTEXT NULL, F TINYTEXT NULL, Z LONGTEXT NULL, A CHAR(1), N MEDIUMINT(9) UNSIGNED);');
        temp.add('CREATE INDEX N ON X (N);');
        temp.add('CREATE TABLE A (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S SMALLINT(8) UNSIGNED, D SMALLINT(8) UNSIGNED, M TINYTEXT NULL);');
        temp.add('CREATE INDEX S ON A (S);');
        temp.add('CREATE INDEX D ON A (D);');
        temp.add('CREATE TABLE D (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT NULL, M TINYTEXT NULL, I MEDIUMINT(9) UNSIGNED);');
        temp.add('CREATE TABLE S (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT NULL, M TINYTEXT NULL, A TINYTEXT NULL, Q SMALLINT(2) UNSIGNED);');
        temp.add('CREATE TABLE C (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y CHAR(1), N MEDIUMINT(9) UNSIGNED, S SMALLINT(6) UNSIGNED, Q SMALLINT(2) UNSIGNED, M TEXT NULL);');
        temp.add('CREATE INDEX N ON C (N);');
        temp.add('CREATE INDEX S ON C (S);');
        // Populer par défaut la table "Types" à partir d'un fichier texte (TDATA.TXT)
        assignfile(tdata,'tdata.txt');
        reset(tdata);
        while not eof(tdata) do
           begin
           readln(tdata,buffer);
           temp.add('INSERT INTO Y (no, Y, T, R, P) VALUES ('+buffer+');');
        end;
        Closefile(tdata);
        // Créer les tables
        for i:=0 to temp.Count-1 do
        begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.add(temp[i]);
           Principale.Query1.ExecSQL;
        end;
        temp.free;
        // Créer un individu
        Principale.Individu.Text:='0';
        MenuItem50Click(Sender);
     except
//        Showmessage('Base de données déjà existante.');
        Showmessage(AnsitoUTF8(Traduction.Items[5]));
        Principale.Database.Connected:=false;
        Principale.Database.Database := db;
        Principale.Database.Connected:= true;
{ TODO 12 : Doit vérifier si c'est le bon format... - fonction car utilisée à plus d'un endroi }
     end;
     GetFirstRecord();
     Principale.Caption := 'Stemma - '+db;
     Principale.MenuItem7.Enabled:=true;
     Principale.MenuItem17.Enabled:=true;
     Principale.MenuItem27.Enabled:=true;
     Principale.MenuItem32.Enabled:=true;
     Principale.MenuItem61.Enabled:=true;
     Principale.MenuItem62.Enabled:=true;
     Ini.WriteString('DB','DB',Principale.Database.Database);
     Ini.Free;
  end;
end;


procedure TPrincipale.FormShow(Sender: TObject);
var
   ini:TIniFile;
begin
  { TODO 20 : Ajouter Splash Screen }
  // Récupère l'historique de données
  DataHist.Clear;
  DataHist.SaveOptions:=soAll;
  DataHist.LoadFromFile('HistD.data');
  if DataHist.RowCount=0 then
     DataHist.RowCount:=1;
  // Récupère l'historique d'individu
  OldIndividu.Items.Clear;
  OldIndividu.Items.LoadFromFile('HistP.data');
  Ini := TIniFile.Create('Stemma.ini');
  Traduction.Items.LoadFromFile(ini.ReadString('Parametres','Langue','francais'));
  Menu1_1.Caption:=AnsitoUTF8(Principale.Traduction.Items[248]);
  Connexion.Caption:=AnsitoUTF8(Principale.Traduction.Items[249]);
  Creer_projet.Caption:=AnsitoUTF8(Principale.Traduction.Items[250]);
  Ouvrir_projet.Caption:=AnsitoUTF8(Principale.Traduction.Items[251]);
  Importer_projet.Caption:=AnsitoUTF8(Principale.Traduction.Items[252]);
  Supprimer_projet.Caption:=AnsitoUTF8(Principale.Traduction.Items[254]);
  Quitter.Caption:=AnsitoUTF8(Principale.Traduction.Items[256]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[257]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[258]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[259]);
  MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[260]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[285]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[287]);
  MenuItem9.Caption:=AnsitoUTF8(Principale.Traduction.Items[288]);
  MenuItem10.Caption:=AnsitoUTF8(Principale.Traduction.Items[289]);
  MenuItem11.Caption:=AnsitoUTF8(Principale.Traduction.Items[290]);
  MenuItem13.Caption:=AnsitoUTF8(Principale.Traduction.Items[286]);
  MenuItem14.Caption:=AnsitoUTF8(Principale.Traduction.Items[291]);
  MenuItem15.Caption:=AnsitoUTF8(Principale.Traduction.Items[292]);
  MenuItem16.Caption:=AnsitoUTF8(Principale.Traduction.Items[294]);
  MenuItem17.Caption:=AnsitoUTF8(Principale.Traduction.Items[276]);
  MenuItem18.Caption:=AnsitoUTF8(Principale.Traduction.Items[277]);
  MenuItem21.Caption:=AnsitoUTF8(Principale.Traduction.Items[280]);
  MenuItem23.Caption:=AnsitoUTF8(Principale.Traduction.Items[295]);
  MenuItem24.Caption:=AnsitoUTF8(Principale.Traduction.Items[278]);
  MenuItem25.Caption:=AnsitoUTF8(Principale.Traduction.Items[279]);
  MenuItem26.Caption:=AnsitoUTF8(Principale.Traduction.Items[293]);
  MenuItem27.Caption:=AnsitoUTF8(Principale.Traduction.Items[281]);
  MenuItem28.Caption:=AnsitoUTF8(Principale.Traduction.Items[282]);
  MenuItem29.Caption:=AnsitoUTF8(Principale.Traduction.Items[283]);
  MenuItem30.Caption:=AnsitoUTF8(Principale.Traduction.Items[233]);
  MenuItem31.Caption:=AnsitoUTF8(Principale.Traduction.Items[284]);
  MenuItem32.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem33.Caption:=AnsitoUTF8(Principale.Traduction.Items[264]);
  MenuItem34.Caption:=AnsitoUTF8(Principale.Traduction.Items[265]);
  MenuItem35.Caption:=AnsitoUTF8(Principale.Traduction.Items[266]);
  MenuItem36.Caption:=AnsitoUTF8(Principale.Traduction.Items[267]);
  MenuItem37.Caption:=AnsitoUTF8(Principale.Traduction.Items[268]);
  MenuItem38.Caption:=AnsitoUTF8(Principale.Traduction.Items[269]);
  MenuItem40.Caption:=AnsitoUTF8(Principale.Traduction.Items[272]);
  MenuItem41.Caption:=AnsitoUTF8(Principale.Traduction.Items[273]);
  MenuItem42.Caption:=AnsitoUTF8(Principale.Traduction.Items[274]);
  MenuItem43.Caption:=AnsitoUTF8(Principale.Traduction.Items[275]);
  MenuItem44.Caption:=AnsitoUTF8(Principale.Traduction.Items[270]);
  MenuItem46.Caption:=AnsitoUTF8(Principale.Traduction.Items[261]);
  MenuItem47.Caption:=AnsitoUTF8(Principale.Traduction.Items[262]);
  MenuItem48.Caption:=AnsitoUTF8(Principale.Traduction.Items[296]);
  MenuItem49.Caption:=AnsitoUTF8(Principale.Traduction.Items[297]);
  MenuItem50.Caption:=AnsitoUTF8(Principale.Traduction.Items[271]);
  MenuItem51.Caption:=AnsitoUTF8(Principale.Traduction.Items[253]);
  MenuItem53.Caption:=AnsitoUTF8(Principale.Traduction.Items[263]);
  MenuItem55.Caption:=AnsitoUTF8(Principale.Traduction.Items[308]);
  MenuItem56.Caption:=AnsitoUTF8(Principale.Traduction.Items[302]);
  MenuItem57.Caption:=AnsitoUTF8(Principale.Traduction.Items[303]);
  MenuItem58.Caption:=AnsitoUTF8(Principale.Traduction.Items[255]);
  MenuItem59.Caption:=AnsitoUTF8(Principale.Traduction.Items[309]);
  MenuItem60.Caption:=AnsitoUTF8(Principale.Traduction.Items[310]);
  MenuItem62.Caption:=AnsitoUTF8(Principale.Traduction.Items[321]);
  MenuItem63.Caption:=AnsitoUTF8(Principale.Traduction.Items[322]);
  MenuItem65.Caption:=AnsitoUTF8(Principale.Traduction.Items[335]);
  MenuItem66.Caption:=AnsitoUTF8(Principale.Traduction.Items[336]);
  MenuItem67.Caption:=AnsitoUTF8(Principale.Traduction.Items[338]);
  MenuItem68.Caption:=AnsitoUTF8(Principale.Traduction.Items[339]);
  MenuItem69.Caption:=AnsitoUTF8(Principale.Traduction.Items[340]);
  MenuItem71.Caption:=AnsitoUTF8(Principale.Traduction.Items[393]);
  MenuItem72.Caption:=AnsitoUTF8(Principale.Traduction.Items[399]);
  MenuItem73.Caption:=AnsitoUTF8(Principale.Traduction.Items[401]);
  MenuItem74.Caption:=AnsitoUTF8(Principale.Traduction.Items[404]);
  MenuItem75.Caption:=AnsitoUTF8(Principale.Traduction.Items[405]);
  MenuItem76.Caption:=AnsitoUTF8(Principale.Traduction.Items[406]);
  MenuItem77.Caption:=AnsitoUTF8(Principale.Traduction.Items[407]);
  MenuItem78.Caption:=AnsitoUTF8(Principale.Traduction.Items[415]);
  MenuItem79.Caption:=AnsitoUTF8(Principale.Traduction.Items[434]);
  MenuItem81.Caption:=AnsitoUTF8(Principale.Traduction.Items[436]);
  MenuItem82.Caption:=AnsitoUTF8(Principale.Traduction.Items[438]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  ProgressBar:= TProgressBar.Create(StatusBar);
  with ProgressBar do
  begin
     Parent := StatusBar;
     Left := 0;
     Visible:= false;
     Height:=8;
     Width:=Principale.Width;
     Max:=100;
     Position:=0;
  end;
  if ini.ReadInteger('DB','Connecté',0)=1 then
     begin
     Principale.Database.HostName := ini.ReadString('DB','Serveur','localhost');
     Principale.Database.User := ini.ReadString('DB','Nom','root');
     Principale.Database.Password := ini.ReadString('DB','Mot de passe','');
     try
       Principale.Database.Connected:=true;
     except
       Showmessage(AnsitoUTF8(Traduction.Items[2]));
     end;
     if Principale.Database.Connected then
        begin
        Principale.Creer_projet.Enabled:=true;
        Principale.Ouvrir_projet.Enabled:=true;
        Principale.Importer_projet.Enabled:=true;
        Principale.Supprimer_projet.Enabled:=true;
        Principale.MenuItem61.Enabled:=true;
        Principale.MenuItem62.Enabled:=true;
        Principale.Database.Connected:=false;
        try
           Principale.Database.Database := ini.ReadString('DB','DB','Stemma_data');
           Principale.Database.Connected:= true;
        except
           Showmessage(AnsitoUTF8(Traduction.Items[2]));
        end;
     end;
     if Principale.Database.Connected then
        begin
        Principale.Caption := 'Stemma - '+Principale.Database.Database;
        Principale.MenuItem7.Enabled:=true;
        Principale.MenuItem17.Enabled:=true;
        Principale.MenuItem32.Enabled:=true;
        Principale.MenuItem27.Enabled:=true;
        if ini.ReadString('DB','DB','Stemma_data')=Principale.Database.Database then
           begin
           Individu.Caption:=ini.ReadString('DB','Individu','1');
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Noms',1)=1 then
              MenuItem8Click(Principale.MenuItem8);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Événements',1)=1 then MenuItem9Click(Principale.MenuItem9);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Parents',1)=1 then MenuItem10Click(Principale.MenuItem10);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Exhibits',1)=1 then MenuItem11Click(Principale.MenuItem11);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Enfants',1)=1 then MenuItem14Click(Principale.MenuItem14);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Fratrie',1)=1 then MenuItem15Click(Principale.MenuItem15);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Ancêtres',0)=1 then MenuItem16Click(Principale.MenuItem16);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Descendants',0)=1 then MenuItem23Click(Principale.MenuItem23);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Image',0)=1 then MenuItem26Click(Principale.MenuItem26);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','ToDoList',0)=1 then MenuItem72Click(Principale.MenuItem72);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','ZoneTampon',0)=1 then MenuItem73Click(Principale.MenuItem73);
           Application.ProcessMessages;
           If Ini.ReadInteger('Fenetre','Explorateur',1)=1 then
              begin
              MenuItem24.Enabled:=true;
              MenuItem25.Enabled:=true;
              MenuItem13Click(Principale.MenuItem13);
           end;
           If Ini.ReadInteger('Fenetre','Explorateur2',1)=1 then MenuItem77Click(Principale.MenuItem77);
           if OldIndividu.Items.Count>0 then
              begin
              Old1.Visible:=true;
              Old1.Hint:=OldIndividu.Items[0];
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[0]);
              Principale.Query1.Open;
              Old1.Caption := '&1- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[0]+')';
           end;
           if OldIndividu.Items.Count>1 then
              begin
              Old2.Visible:=true;
              Old2.Hint:=OldIndividu.Items[1];
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[1]);
              Principale.Query1.Open;
              Old2.Caption := '&2- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[1]+')';
           end;
           if OldIndividu.Items.Count>2 then
              begin
              Old3.Visible:=true;
              Old3.Hint:=OldIndividu.Items[2];
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[2]);
              Principale.Query1.Open;
              Old3.Caption := '&3- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[2]+')';
           end;
           if OldIndividu.Items.Count>3 then
              begin
              Old4.Visible:=true;
              Old4.Hint:=OldIndividu.Items[3];
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[3]);
              Principale.Query1.Open;
              Old4.Caption := '&4- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[3]+')';
           end;
           if OldIndividu.Items.Count>4 then
              begin
              Old5.Visible:=true;
              Old5.Hint:=OldIndividu.Items[4];
              Principale.Query1.SQL.Clear;
              Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[4]);
              Principale.Query1.Open;
              Old5.Caption := '&5- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[4]+')';
           end;
        end;
     end;
  end;
  ini.Free;
end;

procedure GetFirstRecord();
begin
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.add('SELECT no FROM I LIMIT 1');
   Principale.Query1.Open;
   Principale.Individu.Caption := Principale.Query1.Fields[0].AsString;
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
   Principale.Query1.Open;
   Principale.Caption := 'Stemma - '+Principale.Database.Database+' - '+
                         (DecodeName(Principale.Query1.Fields[0].AsString,1))+
                         ' ['+Principale.Individu.Caption+']';
end;

procedure TPrincipale.Importer_projetClick(Sender: TObject);
var
   ini:TIniFile;
   db,buffer,buffer2,buffer3,buffer4,buffer5,I3,I4,role,roles,insert,y,pd,sd,filename:string;
   temp:TStringList;
   i,j:integer;
   tdata:textfile;
   debut,restant,oldrestant:TDateTime;
   MyCursor: TCursor;
begin
  Ini := TIniFile.Create('Stemma.ini');
  db:=ini.ReadString('DB','DB','Stemma_data');
  if InputQuery(AnsitoUTF8(Traduction.Items[3]),AnsitoUTF8(Traduction.Items[4]),db) then
     begin
     // Créer la base de données          CREATE DATABASE `stemma_data`
     try
        // Avant d'importer le projet, fermer le project actif
        Principale.Caption := 'Stemma';
        // Fermer toutes les fenêtres ouvertes
        If MenuItem13.Checked then FormExplorateur.Close;
        If MenuItem8.Checked then FormNoms.Close;
        If MenuItem9.Checked then FormEvenements.Close;
        If MenuItem10.Checked then FormParents.Close;
        If MenuItem11.Checked then FormExhibits.Close;
        If MenuItem14.Checked then FormEnfants.Close;
        If MenuItem15.Checked then FormFratrie.Close;
        If MenuItem16.Checked then FormAncetres.Close;
        If MenuItem23.Checked then FormDescendants.Close;
        If MenuItem26.Checked then FormImage.Close;
        Principale.Individu.Caption:='0';
        MyCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        Query1.SQL.Clear;
        Query1.SQL.add('CREATE DATABASE '+db);
        Query1.ExecSQL;
        Database.Connected:=false;
        Database.Database := db;
        Database.Connected:= true;
        OpenDialog1.InitialDir := 'C:\';
        OpenDialog1.DefaultExt := '*.Dbf';
        OpenDialog1.Filter:='Base de données (*.dbf)|*.dbf';
        OpenDialog1.Title := AnsitoUTF8(Traduction.Items[6]);
        if OpenDialog1.execute then
           begin
           temp := TStringList.Create;
           temp.add('CREATE TABLE Y (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), Y CHAR(1), P MEDIUMTEXT NULL, R MEDIUMTEXT NULL);');
           temp.add('CREATE TABLE L (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, L TINYTEXT);');
           temp.add('CREATE TABLE N (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED, Y SMALLINT(5) UNSIGNED, N TEXT, X BOOL, M TEXT, P MEDIUMTEXT, PD TINYTEXT, SD TINYTEXT, I1 VARCHAR(35), I2 VARCHAR(35), I3 VARCHAR(21), I4 VARCHAR(21));');
           temp.add('CREATE FULLTEXT INDEX N ON N (N);');
           temp.add('CREATE INDEX I ON N (I);');
           temp.add('CREATE INDEX I1 ON N (I1);');
           temp.add('CREATE INDEX I2 ON N (I2);');
           temp.add('CREATE INDEX I3 ON N (I3);');
           temp.add('CREATE INDEX I4 ON N (I4);');
           temp.add('CREATE TABLE R (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y SMALLINT(5) UNSIGNED, A MEDIUMINT(8) UNSIGNED, B MEDIUMINT(8) UNSIGNED, M TINYTEXT NULL, X BOOL, P MEDIUMTEXT NULL, SD TINYTEXT NULL);');
           temp.add('CREATE INDEX A ON R (A);');
           temp.add('CREATE INDEX B ON R (B);');
           temp.add('CREATE TABLE E (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y SMALLINT(5) UNSIGNED, PD TINYTEXT, SD TINYTEXT, L MEDIUMINT(8) UNSIGNED, M TEXT NULL, X BOOL);');
           temp.add('CREATE FULLTEXT INDEX M ON E (M);');
           temp.add('CREATE TABLE W (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED, E MEDIUMINT(8) UNSIGNED, X BOOL, P TINYTEXT NULL, R VARCHAR(20));');
           temp.add('CREATE INDEX E ON W (E);');
           temp.add('CREATE INDEX I ON W (I);');
           temp.add('CREATE TABLE I (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S CHAR(1), V CHAR(1), I TINYINT(2) UNSIGNED, date CHAR(8));');
           temp.add('CREATE TABLE X (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, X BOOL, T VARCHAR(35), D TINYTEXT NULL, F TINYTEXT NULL, Z LONGTEXT NULL, A CHAR(1), N MEDIUMINT(9) UNSIGNED);');
           temp.add('CREATE INDEX N ON X (N);');
           temp.add('CREATE TABLE A (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S SMALLINT(8) UNSIGNED, D SMALLINT(8) UNSIGNED, M TINYTEXT NULL);');
           temp.add('CREATE INDEX S ON A (S);');
           temp.add('CREATE INDEX D ON A (D);');
           temp.add('CREATE TABLE D (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT NULL, M TINYTEXT NULL, I MEDIUMINT(9) UNSIGNED);');
           temp.add('CREATE TABLE S (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT NULL, M TINYTEXT NULL, A TINYTEXT NULL, Q SMALLINT(2) UNSIGNED);');
           temp.add('CREATE TABLE C (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y CHAR(1), N MEDIUMINT(9) UNSIGNED, S SMALLINT(6) UNSIGNED, Q SMALLINT(2) UNSIGNED, M TEXT NULL);');
           temp.add('CREATE INDEX N ON C (N);');
           temp.add('CREATE INDEX S ON C (S);');
           // Populer par défaut la table "Types" à partir d'un fichier texte (TDATA.TXT)
           assignfile(tdata,'tdata.txt');
           reset(tdata);
           while not eof(tdata) do
              begin
              readln(tdata,buffer);
              temp.add('INSERT INTO Y (no, Y, T, R, P) VALUES ('+buffer+');');
           end;
           Closefile(tdata);
           // Créer les tables
           for i:=0 to temp.Count-1 do
           begin
              Query1.SQL.Clear;
              Query1.SQL.add(temp[i]);
              Query1.ExecSQL;
           end;
           temp.free;
           // Créer une barre de progression..
           ProgressBar.Visible := true;
           ProgressBar.Max:=0;
           ProgressBar.Position:=0;
           // Importer Y Types d'événements (_T)
           TMG.FilePath := ExcludeTrailingPathDelimiter(ExtractFilePath(OpenDialog1.FileName));
           TMG.FilePathFull := TMG.FilePath;
           filename:=ExtractFileName(OpenDialog1.FileName);
           filename:=Copy(filename,1,AnsiPos('_',filename));
           TMG.Tablename := filename+'I.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'E.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'M.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'F.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'N.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount*20;
           TMG.Active := false;
           TMG.Tablename := filename+'P.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'$.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'S.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'G.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'R.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'W.DBF';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           TMG.Active := false;
           TMG.Tablename := filename+'T.DBF';
           insert := 'INSERT IGNORE INTO Y (no, Y, P, T, R) VALUES (';
           TMG.Active := true;
           TMG.Open;
           ProgressBar.Max:=ProgressBar.Max+TMG.RecordCount;
           StatusBar.SimpleText:=AnsitoUTF8(Traduction.Items[7]);
           debut:=now;
           oldrestant:=0;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              Application.ProcessMessages;
              if TMG.Fields[1].Value then
                 begin
                 if TMG.Fields[6].IsNull then
                    buffer:=''
                 else
                    begin
                    buffer:=TMG.Fields[6].Value;
                    buffer:=AnsiReplaceStr(buffer,'"','\"');
                    buffer:=AnsiReplaceStr(buffer,'''','\''');
                 end;
                 case TMG.Fields[3].Value of
                      1: y:='N';
                      2..3: y:='R';
                      4: y:='B';
                      5: y:='D';
                      6..7: y:='M';
                      8: y:='X';
                      9: y:='D';
                      10: y:='X';
                      12: y:='R';
                      99: y:='X';
                 end;
                 // Need to parse and translate phrase or parse STEMMA and TMG type of phrase when reporting
                 // Extract roles
                 buffer2 := buffer;
                 roles :='';
                 While (AnsiPos('[R=',buffer2) > 0) do
                 begin
                    buffer2 := copy(buffer2,AnsiPos('[R=',buffer2)+3,length(buffer2));
                    role := uppercase(copy(buffer2,1,AnsiPos(']',buffer2)-1));
                    if AnsiPos(role,roles) < 1 then roles := roles + '|'+role;
                 end;
                 roles := copy(roles,2,length(roles));
                 buffer := inttostr(TMG.Fields[2].Value+1000) + ', ''' + y + ''', ''!TMG' + buffer + ''', '''+ TMG.Fields[5].Value +' (TMG)'', '''+roles+''');';
                 Query1.SQL.Clear;
                 Query1.SQL.add(insert+buffer);
                 Query1.ExecSQL;
              end;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer A Association Source-Dépots (_W)
           TMG.Tablename := filename+'W.DBF';
           insert := 'INSERT IGNORE INTO A (S, D, M) VALUES (';
           TMG.Active := true;
           TMG.Open;
           StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[8]);
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              Application.ProcessMessages;
              if TMG.Fields[2].IsNull then
                 buffer:=''
              else
                 buffer:=TMG.Fields[2].Value;
              buffer := inttostr(TMG.Fields[0].Value)+','+inttostr(TMG.Fields[1].Value)+','''+buffer+''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer D Dépots (_R)
           TMG.Tablename := filename+'R.DBF';
           insert := 'INSERT IGNORE INTO D (no, T, M, D, I) VALUES (';
           TMG.Active := true;
           TMG.Open;
           StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[9]);
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              Application.ProcessMessages;
              if TMG.Fields[3].IsNull then
                 buffer2:=''
              else
                 buffer2:=AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[3].Value,'"','\"'),'''','\''');
              buffer := inttostr(TMG.Fields[5].Value)+','''+TMG.Fields[0].Value+''','''+buffer2+''','''+TMG.Fields[0].Value+''','+inttostr(TMG.Fields[4].Value)+');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer E Événements (_G)
           TMG.Tablename := filename+'G.DBF';
           insert := 'INSERT IGNORE INTO E (no, Y, PD, SD, L, M, X) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
              begin
              // Mettre temporairement P1 et P2 dans une base de données pour pouvoir déterminer
              // les témoins principaux
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[10])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[8].IsNull then
                 buffer2:=''
              else
                 buffer2:=AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[8].Value,'"','\"'),'''','\''');
              buffer := inttostr(TMG.Fields[0].Value)+','+inttostr(TMG.Fields[1].Value+1000)+','''+AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[6].Value,'"','\"'),'''','\''')+''','''+AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[14].Value,'"','\"'),'''','\''')+''','+inttostr(TMG.Fields[7].Value)+','''+buffer2+''',0);';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer C Citations (_S)
           TMG.Tablename := filename+'S.DBF';
           insert := 'INSERT IGNORE INTO C (Y, N, S, M, Q) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
              begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[11])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if (TMG.Fields[0].Value='F') then
                 buffer:='R'
              else
                 buffer:=TMG.Fields[0].Value;
              if TMG.Fields[3].IsNull then
                 buffer2:=''
              else
                 buffer2:=AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[3].Value,'"','\"'),'''','\''');
              i:=10;
              for j:=4 to 8 do
                 if not TMG.Fields[j].IsNull then
                    if (TMG.Fields[j].Value='-') then
                       i:=0
                    else
                       i:=min(i,TMG.Fields[j].Value);
              buffer := ''''+buffer+''','+inttostr(TMG.Fields[1].Value)+','+inttostr(TMG.Fields[2].Value)+','''+buffer2+''','+inttostr(i)+');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer I Individus (_$)
           TMG.Tablename := filename+'$.DBF';
           insert := 'INSERT IGNORE INTO I (no, S, V, I, date) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
              begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[12])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[10].Value='Y' then
                 buffer := 'O'
              else
                 buffer := TMG.Fields[10].Value;
              case TMG.Fields[14].Value of
                   0:i:=0;
                   1:i:=7;
                   2:i:=8;
                   3:i:=9;
              end;
              buffer2 := Format('%.4d',[yearof(TMG.Fields[3].Value)])+Format('%.2d',[monthof(TMG.Fields[3].Value)])+Format('%.2d',[dayof(TMG.Fields[3].Value)]);
              buffer := inttostr(TMG.Fields[0].Value)+','''+TMG.Fields[9].Value+''','''+buffer+''','+inttostr(i)+','''+buffer2+''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer L Lieus (_P)
           TMG.Tablename := filename+'P.DBF';
           insert := 'INSERT IGNORE INTO L (no, L) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[13])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[1].IsNull then
                 buffer:=''
              else
                 buffer := '!TMG'+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[1].Value,'"','\"'),'''','\'''),'$!&','|');
              buffer := inttostr(TMG.Fields[0].Value)+','''+buffer+''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer W Témoins (_E)
           TMG.Tablename := filename+'E.DBF';
           insert := 'INSERT IGNORE INTO W (I, E, X, P, R) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[14])+TimeToStr(restant);
              end;
              Application.ProcessMessages;
              if TMG.Fields[3].IsNull then
                 buffer:=''
              else
                 buffer := '!TMG'+AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[3].Value,'"','\"'),'''','\''');
              // Mettre l'information du X dans la base de données des événements
              if TMG.Fields[2].Value then
                 begin
                 Query1.SQL.Clear;
                 Query1.SQL.add('UPDATE E SET X=1 WHERE no='+inttostr(TMG.Fields[1].Value));
                 Query1.ExecSQL;
              end;
              // Si role = PRINCIPAL, c'est un témoin X=1, sinon X=0
              i:=1;
              role:=UpperCase(TMG.Fields[4].Value);
              if role='ASSASSIN' then i:=0 else
              if role='CELEBRANT' then i:=0 else
              if role='DEPOSITAIRE' then i:=0 else
              if role='NOTAIRE' then i:=0 else
              if role='EXECUTEUR' then i:=0 else
              if role='NOMMEUR' then i:=0 else
              if role='ORDONNEUR' then i:=0 else
              if role='TEMOIN' then i:=0 else
              if role='WITNESS' then i:=0 else
              if role='BENEFICIAIRE' then i:=0;
              buffer := inttostr(TMG.Fields[0].Value)+','+inttostr(TMG.Fields[1].Value)+','+inttostr(i)+
                        ','''+buffer+''','''+UpperCase(TMG.Fields[4].Value)+''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer N Noms (_N)
           TMG.Tablename := filename+'N.DBF';
           insert := 'INSERT IGNORE INTO N (no, I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+20;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[15])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[3].IsNull then
                 buffer:=''
              else
                 buffer := '!TMG|'+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[3].Value,'"','\"'),'''','\'''),'$!&','|');
              buffer4:=RemoveUTF8(ExtractDelimited(2,copy(buffer,5,length(buffer)),['|']));
              buffer5:=RemoveUTF8(ExtractDelimited(4,copy(buffer,5,length(buffer)),['|']));
              if TMG.Fields[12].IsNull then
                 buffer2:=''
              else
                 buffer2 := '!TMG'+AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[12].Value,'"','\"'),'''','\''');
              if TMG.Fields[10].IsNull then
                 buffer3:=''
              else
                 buffer3 := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[10].Value,'"','\"'),'''','\''');
              if TMG.Fields[13].IsNull then
                 pd:='100000000030000000000'
              else
                 pd := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[13].Value,'"','\"'),'''','\''');
              if TMG.Fields[14].IsNull then
                 sd:='100000000030000000000'
              else
                 sd := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[14].Value,'"','\"'),'''','\''');
              if TMG.Fields[6].Value then i:=1 else i:=0;
              Query2.SQL.Clear;
              Query2.SQL.add('SELECT E.SD FROM E LEFT JOIN W ON W.E=E.no WHERE (E.Y=1069 or E.Y=2017 OR E.Y=1002 OR E.Y=1012 OR E.Y=1069) AND W.X=1 AND W.I='+inttostr(TMG.Fields[0].Value)+' ORDER BY E.SD');
              Query2.Open;
              I3:=AnsiReplaceStr(AnsiReplaceStr(Query2.Fields[0].AsString,'"','\"'),'''','\''');
              Query2.SQL.Clear;
              Query2.SQL.add('SELECT E.SD FROM E LEFT JOIN W ON W.E=E.no WHERE (E.Y=1003 or E.Y=1006 OR E.Y=2001 OR E.Y=2004 OR E.Y=2007 OR E.Y=2009 OR E.Y=2010 OR E.Y=2014 OR E.Y=2018 OR E.Y=2020) AND W.X=1 AND W.I='+inttostr(TMG.Fields[0].Value)+' ORDER BY E.SD');
              Query2.Open;
              I4:=AnsiReplaceStr(AnsiReplaceStr(Query2.Fields[0].AsString,'"','\"'),'''','\''');
              buffer := inttostr(TMG.Fields[11].Value)+','+inttostr(TMG.Fields[0].Value)+','+
                        inttostr(TMG.Fields[1].Value+1000)+','''+buffer+''','+inttostr(i)+','''+
                        buffer3+''','''+buffer2+''','''+PD+''','''+SD+''','''+buffer4+''','''+
                        buffer5+''','''+I3+''','''+I4+''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer R Relations (_F)
           TMG.Tablename := filename+'F.DBF';
           insert := 'INSERT IGNORE INTO R (no, Y, A, B, M, X, SD, P) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[16])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[4].IsNull then
                 buffer:=''
              else
                 buffer := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[4].Value,'"','\"'),'''','\''');
              sd:='100000000030000000000';
              if TMG.Fields[0].Value then i:=1 else i:=0;
              buffer := inttostr(TMG.Fields[7].Value)+','+inttostr(TMG.Fields[3].Value+1000)+','+inttostr(TMG.Fields[1].Value)+','+inttostr(TMG.Fields[2].Value)+','''+buffer+''','+inttostr(i)+','''+sd+''','''');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer S Sources (_M)
           TMG.Tablename := filename+'M.DBF';
           insert := 'INSERT IGNORE INTO S (no, T, M, D, A, Q) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
           begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[17])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[2].IsNull then
                 buffer:=''
              else
                 buffer := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[2].Value,'"','\"'),'''','\''');
              if TMG.Fields[4].IsNull then
                 buffer2:=''
              else
                 buffer2 := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[4].Value,'"','\"'),'''','\''');
              // extraire auteur et e-mail d'auteur de TMG.Fields[22].Value (sd et buffer3)
              if TMG.Fields[23].IsNull then
                 begin
                 buffer3:='';
                 sd:='';
              end
              else
                 begin
                 buffer5:=AnsiReplaceStr(TMG.Fields[23].Value,'$!&','|');
                 sd:=AnsiReplaceStr(AnsiReplaceStr(ExtractDelimited(6,buffer5,['|']),'"','\"'),'''','\''');
                 buffer3:=ExtractDelimited(14,buffer5,['|']);
              end;
              if TMG.Fields[13].Value > 0 then sd := inttostr(TMG.Fields[13].Value);
              if not TMG.Fields[11].IsNull then
                 if buffer3='' then
                    buffer3:=AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[11].Value,'"','\"'),'''','\''');
              buffer := inttostr(TMG.Fields[1].Value)+','''+buffer+''','''+buffer3+
                        ''','''+buffer2+''','''+sd+''','+inttostr(TMG.Fields[3].Value)+');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
           // Importer X Exhibits (_I)
           TMG.Tablename := filename+'I.DBF';
           insert := 'INSERT IGNORE INTO X (X, T, D, F, Z, A, N) VALUES (';
           TMG.Active := true;
           TMG.Open;
           while not (TMG.eof) do
              begin
              ProgressBar.Position:=ProgressBar.Position+1;
              restant:=((ProgressBar.Max/ProgressBar.Position)-1)*(now-debut);
              if abs(oldrestant-restant)>0.00001 then
                 begin
                 oldrestant:=restant;
                 StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[18])+TimeToStr(restant);
                 Application.ProcessMessages;
              end;
              if TMG.Fields[54].IsNull then i:=0 else if TMG.Fields[54].Value then i:=1 else i:=0;
              if TMG.Fields[0].IsNull then
                 buffer:=''
              else
                 buffer := AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[0].Value,'"','\"'),'''','\''');
              if TMG.Fields[26].IsNull then
                 buffer2:=''
              else
                 buffer2:= AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[26].Value,'"','\"'),'''','\''');
              if TMG.Fields[1].IsNull then
                 buffer3:=''
              else
                 buffer3:= AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[1].Value,'"','\"'),'''','\'''),'\','\\');
              if TMG.Fields[23].IsNull then
                 sd:=''
              else
                 sd:= AnsiReplaceStr(AnsiReplaceStr(TMG.Fields[23].Value,'"','\"'),'''','\''');
              if TMG.Fields[41].Value='_' then
                 pd:='I'
              else
                 if uppercase(TMG.Fields[41].Value)='M' then
                    pd:='S'
                 else
                    pd:='E';
              buffer := inttostr(i)+','''+buffer+''','''+buffer2+
                        ''','''+buffer3+''','''+sd+''','''+pd+''','+inttostr(TMG.Fields[42].Value)+');';
              Query1.SQL.Clear;
              Query1.SQL.add(insert+buffer);
              Query1.ExecSQL;
              TMG.Next;
           end;
           TMG.Active := false;
        end;
     except
        Showmessage(AnsitoUTF8(Traduction.Items[19]));
        Database.Connected:=false;
        Database.Database := db;
        Database.Connected:= true;
     end;
  end;
  ProgressBar.Visible:=False;
  StatusBar.Panels[1].Text:='';
  Principale.Caption := 'Stemma - '+Database.Database;
  Principale.MenuItem7.Enabled:=true;
  Principale.MenuItem17.Enabled:=true;
  Principale.MenuItem27.Enabled:=true;
  Principale.MenuItem32.Enabled:=true;
  Principale.MenuItem61.Enabled:=true;
  Principale.MenuItem62.Enabled:=true;
  GetFirstRecord();
  Screen.Cursor := MyCursor;
end;

procedure TPrincipale.IndividuChange(Sender: TObject);
var
   i:integer;
begin
   Query1.SQL.Clear;
   Query1.SQL.Add('SELECT no FROM I WHERE no='+Principale.Individu.Caption);
   Query1.Open;
   If not Query1.EOF then
      begin
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
      Principale.Query1.Open;
      Principale.Caption := 'Stemma - '+Principale.Database.Database+' - '+
                            (DecodeName(Principale.Query1.Fields[0].AsString,1))+
                            ' ['+Principale.Individu.Caption+']';
      if (OldIndividu.Items.Count>0) then
         if (not (OldIndividu.Items[0]=Individu.Caption)) then
            begin
            Old5.Hint:=Old4.Hint;
            Old5.Caption:='&5- '+Copy(Old4.Caption,5,length(Old4.Caption));
            If not (Old5.Hint = '0') then Old5.Visible:=true;
            Old4.Hint:=Old3.Hint;
            Old4.Caption:='&4- '+Copy(Old3.Caption,5,length(Old3.Caption));
            If not (Old4.Hint = '0') then Old4.Visible:=true;
            Old3.Hint:=Old2.Hint;
            Old3.Caption:='&3- '+Copy(Old2.Caption,5,length(Old2.Caption));
            If not (Old3.Hint = '0') then Old3.Visible:=true;
            Old2.Hint:=Old1.Hint;
            Old2.Caption:='&2- '+Copy(Old1.Caption,5,length(Old1.Caption));
            If not (Old2.Hint = '0') then Old2.Visible:=true;
            Old1.Hint:=OldIndividu.Items[0];
            Principale.Query1.SQL.Clear;
            Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+OldIndividu.Items[0]);
            Principale.Query1.Open;
            Old1.Caption := '&1- '+DecodeName(Query1.Fields[0].AsString,1)+' ('+OldIndividu.Items[0]+')';
            If not (Old1.Hint = '0') then Old1.Visible:=true;
         end;
      if OldIndividu.Items.Count > 1 then
         for i:=1 to OldIndividu.Items.Count-1 do
            if OldIndividu.Items[i]=Individu.Caption then
               begin
               OldIndividu.Items.Delete(i);
               break;
            end;
      OldIndividu.Items.Insert(0,Individu.Caption);
      If MenuItem8.Checked then PopulateNom;
      If MenuItem9.Checked then PopulateEvenements;
      If MenuItem10.Checked then PopulateParents;
      If MenuItem11.Checked then PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
      If MenuItem14.Checked then PopulateEnfants;
      If MenuItem15.Checked then PopulateFratrie;
      If MenuItem16.Checked then PopulateAncetres;
//      If MenuItem13.Checked then TrouveIndividu;
//      If MenuItem77.Checked then TrouveIndividu2;
      If MenuItem23.Checked then PopulateDescendants;
      If MenuItem26.Checked then
         if FormExhibits.TableauExhibits.RowCount>1 then
            if FormExhibits.TableauExhibits.Cells[1,FormExhibits.TableauExhibits.Row]='*' then
                PopulateImage(0)
             else
                PopulateImage(StrToInt(FormExhibits.TableauExhibits.Cells[0,FormExhibits.TableauExhibits.Row]))
         else
             PopulateImage(0);
   end
   else
      begin
      if Principale.Individu.Caption<>'0' then
         begin
         Showmessage(AnsitoUTF8(Traduction.Items[22])+Principale.Individu.Caption+AnsitoUTF8(Traduction.Items[23]));
         Principale.Individu.Caption:=OldIndividu.Items[0]
      end;
   end;
end;

procedure TPrincipale.MenuItem10Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormParents.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormParents.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem11Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormExhibits.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormExhibits.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem13Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormExplorateur.Show;
     (Sender as TMenuItem).checked := true;
     MenuItem24.Enabled:=true;
     MenuItem25.Enabled:=true;
  end
  else
  begin
     MenuItem24.Enabled:=false;
     MenuItem25.Enabled:=false;
     FormExplorateur.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem14Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormEnfants.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormEnfants.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem15Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormFratrie.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormFratrie.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem16Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormAncetres.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormAncetres.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem18Click(Sender: TObject);
var
   i:string;
begin
  i := InputBox(AnsitoUTF8(Traduction.Items[20]),AnsitoUTF8(Traduction.Items[21]),'');
  try
     if length(i)>0 then
        if strtoint(i)>0 then
           Individu.Caption:=i;
  except
    Showmessage(AnsitoUTF8(Traduction.Items[22])+i+AnsitoUTF8(Traduction.Items[23]));
  end;
end;

procedure TPrincipale.MenuItem21Click(Sender: TObject);
begin
  FormHistorique.ShowModal;
end;

procedure TPrincipale.MenuItem23Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormDescendants.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormDescendants.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem24Click(Sender: TObject);
begin
   if (FormExplorateur.Index.Row>1) then
      begin
      FormExplorateur.Index.Row:=FormExplorateur.Index.Row-1;
      Principale.Individu.Caption:=FormExplorateur.Index.Cells[1,FormExplorateur.Index.Row];
   end;
end;

procedure TPrincipale.MenuItem25Click(Sender: TObject);
begin
   if (FormExplorateur.Index.Row<FormExplorateur.Index.RowCount) then
      begin
      FormExplorateur.Index.Row:=FormExplorateur.Index.Row+1;
      Principale.Individu.Caption:=FormExplorateur.Index.Cells[1,FormExplorateur.Index.Row];
   end;
end;

procedure TPrincipale.MenuItem26Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormImage.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormImage.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem28Click(Sender: TObject);
begin
  FormSources.ShowModal;
end;

procedure TPrincipale.MenuItem29Click(Sender: TObject);
begin
  FormLieux.ShowModal;
end;

procedure TPrincipale.MenuItem30Click(Sender: TObject);
begin
  FormDepots.ShowModal;
end;

procedure TPrincipale.MenuItem31Click(Sender: TObject);
begin
  FormTypes.ShowModal;
end;

procedure TPrincipale.MenuItem33Click(Sender: TObject);
begin
  // Ajouter un père
  PutCode('P','0');
  PutCode('A','0');
  if EditNom.Showmodal = mrOK then
     Principale.Individu.Caption:=EditNom.I.Text;
end;

procedure TPrincipale.MenuItem34Click(Sender: TObject);
begin
  // Ajouter une mère
  PutCode('M','0');
  PutCode('A','0');
  if EditNom.Showmodal = mrOK then
     Principale.Individu.Caption:=EditNom.I.Text;
end;

procedure TPrincipale.MenuItem35Click(Sender: TObject);
begin
  // Avant d'ajouter vérifier si l'individu sélectionné à au moins un parent principal
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT R.no, R.B FROM R WHERE R.X=1 AND R.A='+
     Principale.Individu.Caption);
  Principale.Query2.Open;
  if not Principale.Query2.EOF then
     begin
     // Ajouter un frère
     PutCode('F','0');
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        Principale.Individu.Caption:=EditNom.I.Text;
  end;
end;

procedure TPrincipale.MenuItem36Click(Sender: TObject);
begin
  // Avant d'ajouter vérifier si l'individu sélectionné à au moins un parent principal
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SELECT R.no, R.B FROM R WHERE R.X=1 AND R.A='+
     Principale.Individu.Caption);
  Principale.Query2.Open;
  if not Principale.Query2.EOF then
     begin
     // Ajouter une soeur
     PutCode('S','0');
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        Principale.Individu.Caption:=EditNom.I.Text;
  end;
end;

procedure TPrincipale.MenuItem37Click(Sender: TObject);
var
   i:integer;
   existe:boolean;
begin
  // Sélectionne toutes les autres personnes ayant des enfants principaux avec cette personne
  FormSelectPersonne.Liste.RowCount:=2;
  FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:='0';
  FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=AnsitoUTF8(Principale.Traduction.Items[317]);
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT R.A FROM R WHERE R.X=1 AND R.B='+
                            Principale.Individu.Caption);
  Principale.Query1.Open;
  while not Principale.Query1.Eof do
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT R.B FROM R WHERE R.X=1 AND R.A='+
                               Principale.Query1.Fields[0].AsString+' AND NOT R.B='+
                               Principale.Individu.Caption);
     Principale.Query2.Open;
     if not Principale.Query2.EOF then
        begin
        existe:=false;
        for i:=1 to FormSelectPersonne.Liste.RowCount-1 do
           existe:=existe or (FormSelectPersonne.Liste.Cells[0,i]=Principale.Query2.Fields[0].AsString);
        if not existe then
           begin
           FormSelectPersonne.Liste.RowCount:=FormSelectPersonne.Liste.RowCount+1;
           FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:=Principale.Query2.Fields[0].AsString;
           FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=GetName(Principale.Query2.Fields[0].AsString);
        end;
     end;
     Principale.Query1.Next;
  end;
  // Sélectionne toutes les autres personnes en union avec cette personne
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN Y on E.Y=Y.no JOIN W on W.E=E.no WHERE E.X=1 AND W.X=1 AND Y.Y=''M'' AND W.I='+
                            Principale.Individu.Caption);
  Principale.Query1.Open;
  while not Principale.Query1.Eof do
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT W.I FROM W WHERE W.X=1 AND W.E='+
                               Principale.Query1.Fields[0].AsString+' AND NOT W.I='+
                               Principale.Individu.Caption);
     Principale.Query2.Open;
     if not Principale.Query2.EOF then
        begin
        existe:=false;
        for i:=1 to FormSelectPersonne.Liste.RowCount-1 do
           existe:=existe or (FormSelectPersonne.Liste.Cells[0,i]=Principale.Query2.Fields[0].AsString);
        if not existe then
           begin
           FormSelectPersonne.Liste.RowCount:=FormSelectPersonne.Liste.RowCount+1;
           FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:=Principale.Query2.Fields[0].AsString;
           FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=GetName(Principale.Query2.Fields[0].AsString);
        end;
     end;
     Principale.Query1.Next;
  end;
  if FormSelectPersonne.Showmodal = mrOK then
     begin
     // Ajouter un fils
     PutCode('I',FormSelectPersonne.no.text);
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        Principale.Individu.Caption:=EditNom.I.Text;
  end;
end;

procedure TPrincipale.MenuItem38Click(Sender: TObject);
var
   i:integer;
   existe:boolean;
begin
  // Sélectionne toutes les autres personnes ayant des enfants principaux avec cette personne
  FormSelectPersonne.Liste.RowCount:=2;
  FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:='0';
  FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=AnsitoUTF8(Principale.Traduction.Items[317]);
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT R.A FROM R WHERE R.X=1 AND R.B='+
                            Principale.Individu.Caption);
  Principale.Query1.Open;
  while not Principale.Query1.Eof do
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT R.B FROM R WHERE R.X=1 AND R.A='+
                               Principale.Query1.Fields[0].AsString+' AND NOT R.B='+
                               Principale.Individu.Caption);
     Principale.Query2.Open;
     if not Principale.Query2.EOF then
        begin
        existe:=false;
        for i:=1 to FormSelectPersonne.Liste.RowCount-1 do
           existe:=existe or (FormSelectPersonne.Liste.Cells[0,i]=Principale.Query2.Fields[0].AsString);
        if not existe then
           begin
           FormSelectPersonne.Liste.RowCount:=FormSelectPersonne.Liste.RowCount+1;
           FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:=Principale.Query2.Fields[0].AsString;
           FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=GetName(Principale.Query2.Fields[0].AsString);
        end;
     end;
     Principale.Query1.Next;
  end;
  // Sélectionne toutes les autres personnes en union avec cette personne
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN Y on E.Y=Y.no JOIN W on W.E=E.no WHERE E.X=1 AND W.X=1 AND Y.Y=''M'' AND W.I='+
                            Principale.Individu.Caption);
  Principale.Query1.Open;
  while not Principale.Query1.Eof do
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT W.I FROM W WHERE W.X=1 AND W.E='+
                               Principale.Query1.Fields[0].AsString+' AND NOT W.I='+
                               Principale.Individu.Caption);
     Principale.Query2.Open;
     if not Principale.Query2.EOF then
        begin
        existe:=false;
        for i:=1 to FormSelectPersonne.Liste.RowCount-1 do
           existe:=existe or (FormSelectPersonne.Liste.Cells[0,i]=Principale.Query2.Fields[0].AsString);
        if not existe then
           begin
           FormSelectPersonne.Liste.RowCount:=FormSelectPersonne.Liste.RowCount+1;
           FormSelectPersonne.Liste.Cells[0,FormSelectPersonne.Liste.RowCount-1]:=Principale.Query2.Fields[0].AsString;
           FormSelectPersonne.Liste.Cells[1,FormSelectPersonne.Liste.RowCount-1]:=GetName(Principale.Query2.Fields[0].AsString);
        end;
     end;
     Principale.Query1.Next;
  end;
  if FormSelectPersonne.Showmodal = mrOK then
     begin
     // Ajouter un fille
     PutCode('L',FormSelectPersonne.no.text);
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        Principale.Individu.Caption:=EditNom.I.Text;
  end;
end;

procedure TPrincipale.MenuItem40Click(Sender: TObject);
begin
  // Ajoute la naissance
  PutCode('A','N');
  if EditEvenement.Showmodal = mrOK then
     PopulateEvenements;
end;

procedure TPrincipale.MenuItem41Click(Sender: TObject);
begin
  // Ajoute le baptême
  PutCode('A','B');
  if EditEvenement.Showmodal = mrOK then
     PopulateEvenements;
end;

procedure TPrincipale.MenuItem42Click(Sender: TObject);
begin
  // Ajoute le décès
  PutCode('A','D');
  if EditEvenement.Showmodal = mrOK then
     PopulateEvenements;
end;

procedure TPrincipale.MenuItem43Click(Sender: TObject);
begin
  // Ajoute la sépulture
  PutCode('A','S');
  if EditEvenement.Showmodal = mrOK then
     PopulateEvenements;
end;

procedure TPrincipale.MenuItem44Click(Sender: TObject);
begin
  // Ajouter un conjoint, le sexe ne doit pas être '?'
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT S FROM I WHERE no='+Principale.Individu.Caption);
  Principale.Query1.Open;
  if not (Principale.Query1.Fields[0].AsString='?') then
     begin
     // Ajouter un conjoint
     if (Principale.Query1.Fields[0].AsString='M') then
        PutCode('J','F')
     else
        PutCode('J','M');
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        Principale.Individu.Caption:=EditNom.I.Text;
  end;
end;

procedure TPrincipale.MenuItem46Click(Sender: TObject);
begin
  // Copier nom
  If MenuItem8.Checked Then
     begin
     Query1.SQL.Clear;
     Query1.SQL.Add('SELECT I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4 FROM N WHERE no='+
                FormNoms.TableauNoms.Cells[0,FormNoms.TableauNoms.Row]);
     Query1.Open;
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO N (I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4) VALUES ('+
                Query1.Fields[0].AsString+', '+
                Query1.Fields[1].AsString+', '''+
                AnsiReplaceStr(Query1.Fields[2].AsString,'''','\''')+''', '+
                '0'+', '''+
                Query1.Fields[4].AsString+''', '''+
                Query1.Fields[5].AsString+''', '''+
                Query1.Fields[6].AsString+''', '''+
                Query1.Fields[7].AsString+''', '''+
                Query1.Fields[8].AsString+''', '''+
                Query1.Fields[9].AsString+''', '''+
                Query1.Fields[10].AsString+''', '''+
                Query1.Fields[11].AsString+''')');
     Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''N'' AND N='+
                FormNoms.TableauNoms.Cells[0,FormNoms.TableauNoms.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'"','\"'),'''','\''')+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     SaveModificationTime(Principale.Individu.Caption);
     PopulateNom;
  end;
end;

procedure TPrincipale.MenuItem47Click(Sender: TObject);
var
   nouveau, i1, i2, i3, i4, temp:string;
   j:integer;
begin
  // Copier individu
  Query1.SQL.Clear;
  Query1.SQL.Add('SELECT S, V, I FROM I WHERE no='+
             Principale.Individu.Caption);
  Query1.Open;
  Query2.SQL.Clear;
  Query2.SQL.Add('INSERT IGNORE INTO I (S, V, I) VALUES ('''+
             Query1.Fields[0].AsString+''', '''+
             Query1.Fields[1].AsString+''', '+
             Query1.Fields[2].AsString+')');
  Query2.ExecSQL;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''I''');
  Principale.Query2.Open;
  Principale.Query2.First;
  nouveau:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
  // Copie toutes les relations
  Query1.SQL.Clear;
  Query1.SQL.Add('SELECT Y, A, B, M, P, X, SD, no FROM R WHERE A='+
             Principale.Individu.Caption+' OR B='+
             Principale.Individu.Caption);
  Query1.Open;
  while not query1.eof do
     begin
     Query2.SQL.Clear;
     if Query1.Fields[1].AsString=Principale.Individu.Caption then
        begin
        Query2.SQL.Add('INSERT IGNORE INTO R (Y, A, B, M, P, X, SD) VALUES ('+
                   Query1.Fields[0].AsString+', '+
                   nouveau+', '+
                   Query1.Fields[2].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', '+
                   Query1.Fields[5].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Principale.Query4.SQL.Clear;
        Principale.Query4.SQL.Add('UPDATE I SET date='''+FormatDateTime('YYYYMMDD',now)+
                       ''' WHERE no='+Query1.Fields[2].AsString);
        Principale.Query4.ExecSQL;
        end
     else
        begin
        Query2.SQL.Add('INSERT IGNORE INTO R (Y, A, B, M, P, X, SD) VALUES ('+
                   Query1.Fields[0].AsString+', '+
                   Query1.Fields[1].AsString+', '+
                   nouveau+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', '+
                   Query1.Fields[5].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Principale.Query4.SQL.Clear;
        Principale.Query4.SQL.Add('UPDATE I SET date='''+FormatDateTime('YYYYMMDD',now)+
                       ''' WHERE no='+Query1.Fields[1].AsString);
        Principale.Query4.ExecSQL;
     end;
     Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''R'' AND N='+
                Query1.Fields[7].AsString);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     Query1.Next;
  end;
  // Copie tous les noms
  Query1.SQL.Clear;
  Query1.SQL.Add('SELECT I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4, no FROM N WHERE I='+
             Principale.Individu.Caption);
  Query1.Open;
  while not query1.EOF do
     begin
     i1:=Query1.Fields[8].AsString;
     i2:=Query1.Fields[9].AsString;
     i3:=Query1.Fields[10].AsString;
     i4:=Query1.Fields[11].AsString;
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO N (I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4) VALUES ('+
                nouveau+', '+
                Query1.Fields[1].AsString+', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''', '+
                Query1.Fields[3].AsString+', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[7].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[8].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[9].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[10].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[11].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
     Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''N''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''N'' AND N='+
                Query1.Fields[12].AsString);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     { Ajoute le nom dans l'explorateur...
     if MenuItem13.Checked then
        begin
        if FormExplorateur.O.text='1' then
           temp:=RemoveUTF8(i2+' '+i1);
        if FormExplorateur.O.text='2' then
           temp:=RemoveUTF8(i1+', '+i2);
        if FormExplorateur.O.text='3' then
           temp:=i3;
        if FormExplorateur.O.text='4' then
           temp:=i4;
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
        FormExplorateur.Index.Cells[0,j]:=InttoStr(Principale.Query2.Fields[10].AsInteger-1);
        FormExplorateur.Index.Cells[1,j]:=nouveau;
        if FormExplorateur.O.text='1' then
           FormExplorateur.Index.Cells[2,j]:=DecodeName(Query1.Fields[2].AsString,1)
        else
           FormExplorateur.Index.Cells[2,j]:=DecodeName(Query1.Fields[2].AsString,2);
        FormExplorateur.Index.Cells[3,j]:=ConvertDate(i3,1);
        FormExplorateur.Index.Cells[4,j]:=ConvertDate(i4,1);
        FormExplorateur.Index.Cells[5,j]:='';
        FormExplorateur.Index.Cells[6,j]:=temp;
        FormExplorateur.Index.Row:=j;
     end; }
     Query1.Next;
  end;
  // Copie tous les documents
  Query1.SQL.Clear;
  Query1.SQL.Add('SELECT X, T, D, F, Z, A, N FROM X WHERE A=''I'' AND N='+
             Principale.Individu.Caption);
  Query1.Open;
  while not query1.EOF do
     begin
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO X (X, T, D, F, Z, A, N) VALUES ('+
                Query1.Fields[0].AsString+', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                'I'+''', '+
                nouveau+')');
     Query2.ExecSQL;
     Query1.Next;
  end;
  // Copie tous les événements
  Query1.SQL.Clear;
  Query1.SQL.Add('SELECT E.Y, E.PD, E.SD, E.L, E.M, E.X, E.no FROM E JOIN W on E.no=W.E WHERE W.I='+
             Principale.Individu.Caption);
  Query1.Open;
  while not Query1.EOF do
     begin
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO E (Y, PD, SD, L, M, X) VALUES ('+
                Query1.Fields[0].AsString+', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''', '+
                Query1.Fields[3].AsString+', '''+
                AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', '+
                Query1.Fields[5].AsString+')');
     Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''E'' AND N='+
                Query1.Fields[6].AsString);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT X, T, D, F, Z FROM X WHERE A=''E'' AND N='+
                Query1.Fields[6].AsString);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO X (X, T, D, F, Z, A, N) VALUES ('+
                   '0'+', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[1].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[2].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                   AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''', ''E'', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT I, E, X, P, R FROM W WHERE E='+
                Query1.Fields[6].AsString);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        if Principale.Individu.Caption=Query3.Fields[0].AsString then
           Query4.SQL.Add('INSERT IGNORE INTO W (I, E, X, P, R) VALUES ('+
                      nouveau+', '+
                      InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                      Query3.Fields[2].AsString+', '''+
                      AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                      AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''')')
        else
           Query4.SQL.Add('INSERT IGNORE INTO W (I, E, X, P, R) VALUES ('+
                      Query3.Fields[0].AsString+', '+
                      InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                      Query3.Fields[2].AsString+', '''+
                      AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[3].AsString,'\','\\'),'"','\"'),'''','\''')+''', '''+
                      AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query3.Fields[4].AsString,'\','\\'),'"','\"'),'''','\''')+''')');
        Query4.ExecSQL;
        Principale.Query4.SQL.Clear;
        Principale.Query4.SQL.Add('UPDATE I SET date='''+FormatDateTime('YYYYMMDD',now)+
                       ''' WHERE no='+Query3.Fields[0].AsString);
        Principale.Query4.ExecSQL;
        Query3.Next;
     end;
     Query1.Next;
  end;
  SaveModificationTime(nouveau);
  Principale.Individu.Caption:=nouveau;
end;

procedure TPrincipale.MenuItem49Click(Sender: TObject);
begin
  apropos.Showmodal;
end;

procedure TPrincipale.MenuItem50Click(Sender: TObject);
begin
  // Ajouter un individu non-relié
  PutCode('R','0');
  PutCode('A','0');
  if EditNom.Showmodal = mrOK then
     Principale.Individu.Caption:=EditNom.I.Text;
end;

procedure TPrincipale.MenuItem53Click(Sender: TObject);
var
   valide:boolean;
begin
  // Suppression de personne
  valide:=true;
  // Vérifier qu'il n'y a pas d'événements primaire avec d'autre témoins primaires
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W ON E.no=W.E WHERE E.X=1 AND W.X=1 AND W.I='+Principale.Individu.Caption);
  Principale.Query1.Open;
  while not Principale.Query1.EOF do
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT W.I FROM W WHERE W.X=1 AND NOT W.I='+Principale.Individu.Caption+
                               ' AND W.E='+Principale.Query1.Fields[0].AsString);
     Principale.Query2.Open;
     valide:=valide AND Principale.Query2.EOF;
     Principale.Query1.Next;
  end;
  // Vérifier qu'il n'y a pas de parents primaires
  // Vérifier qu'il n'y a pas d'enfants primaires
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT R.no FROM R WHERE R.X=1 AND (R.A='+Principale.Individu.Caption+
                            ' OR R.B='+Principale.Individu.Caption+')');
  Principale.Query1.Open;
  valide:=valide AND Principale.Query1.EOF;
  // Vérifier qu'il n'y a pas de dépot
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT D.no FROM D WHERE D.I='+Principale.Individu.Caption);
  Principale.Query1.Open;
  valide:=valide AND Principale.Query1.EOF;
  // Vérifier qu'il n'y a pas de source
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('SELECT S.no FROM S WHERE S.A='''+Principale.Individu.Caption+'''');
  Principale.Query1.Open;
  valide:=valide AND Principale.Query1.EOF;
  if not valide then
     begin
     Application.MessageBox(pchar(AnsitoUTF8(Principale.Traduction.Items[307])),pchar(AnsitoUTF8(Principale.Traduction.Items[124])),MB_OK)
  end
  else
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+Principale.Individu.Caption);
     Principale.Query1.Open;
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[60])+
           DecodeName(Principale.Query1.Fields[0].AsString,1)+
           AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        // Supprime la personne
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM I WHERE no='+Principale.Individu.Caption);
        Principale.Query1.ExecSQL;
        // Supprime ses noms
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT N.no FROM N WHERE I='+Principale.Individu.Caption);
        Principale.Query1.Open;
        While not Principale.Query1.EOF do
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM C WHERE Y=''N'' AND N='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query1.Next;
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM N WHERE I='+Principale.Individu.Caption);
        Principale.Query1.ExecSQL;
        // supprime ses événements
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT E.no FROM E JOIN W ON W.E=E.no WHERE W.I='+Principale.Individu.Caption);
        Principale.Query1.Open;
        While not Principale.Query1.EOF do
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM C WHERE Y=''E'' AND N='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM X WHERE A=''E'' AND N='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM W WHERE E='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM E WHERE no='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query1.Next;
        end;
        // Supprime ses documents
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM X WHERE X.A=''I'' AND X.N='+Principale.Individu.Caption);
        Principale.Query1.ExecSQL;
        // Supprime ses relations
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT R.no FROM R WHERE (R.A='+Principale.Individu.Caption+
                                  ' OR R.B='+Principale.Individu.Caption+')');
        Principale.Query1.Open;
        While not Principale.Query1.EOF do
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('DELETE FROM C WHERE Y=''R'' AND N='+Principale.Query1.Fields[0].AsString);
           Principale.Query2.ExecSQL;
           Principale.Query1.Next;
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM R WHERE (R.A='+Principale.Individu.Caption+
                                  ' OR R.B='+Principale.Individu.Caption+')');
        Principale.Query1.ExecSQL;
        // Change d'individu vers l'avant dernière personne
        if OldIndividu.Items.Count<=1 then
           GetFirstRecord()
        else
           Principale.Individu.Caption:=Old1.Hint;
     end;
  end;
end;

procedure TPrincipale.MenuItem55Click(Sender: TObject);
begin
  // Copier Événement
  If MenuItem9.Checked Then
     begin
     Query1.SQL.Clear;
     Query1.SQL.Add('SELECT Y, PD, SD, L, M, X FROM E WHERE no='+
                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Query1.Open;
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO E (Y, PD, SD, L, M, X) VALUES ('+
                Query1.Fields[0].AsString+', '''+
                Query1.Fields[1].AsString+''', '''+
                Query1.Fields[2].AsString+''', '+
                AnsiReplaceStr(Query1.Fields[3].AsString,'''','\''')+', '''+
                AnsiReplaceStr(Query1.Fields[4].AsString,'''','\''')+''', '+
                '0'+')');
     Query2.ExecSQL;
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''E''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''E'' AND N='+
                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   AnsiReplaceStr(Query3.Fields[4].AsString,'''','\''')+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT X, T, D, F, Z FROM X WHERE A=''E'' AND N='+
                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO X (X, T, D, F, Z, A, N) VALUES ('+
                   '0'+', '''+
                   Query3.Fields[1].AsString+''', '''+
                   AnsiReplaceStr(Query3.Fields[2].AsString,'''','\''')+''', '''+
                   AnsiReplaceStr(Query3.Fields[3].AsString,'''','\''')+''', '''+
                   Query3.Fields[4].AsString+''', ''E'', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT I, E, X, P, R FROM W WHERE E='+
                FormEvenements.TableauEvenements.Cells[0,FormEvenements.TableauEvenements.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO W (I, E, X, P, R) VALUES ('+
                   Query3.Fields[0].AsString+', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '''+
                   Query3.Fields[3].AsString+''', '''+
                   Query3.Fields[4].AsString+''')');
        Query4.ExecSQL;
        SaveModificationTime(Query3.Fields[0].AsString);
        Query3.Next;
     end;
     PopulateEvenements;
  end;
end;

procedure TPrincipale.MenuItem58Click(Sender: TObject);
var
   ini:TIniFile;
begin
   OpenDialog1.InitialDir := ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
   OpenDialog1.DefaultExt := '*.data';
   OpenDialog1.Filter:= AnsitoUTF8(Traduction.Items[306])+' (*.data)|*.data';
   OpenDialog1.Title := AnsitoUTF8(Traduction.Items[141]);
   if OpenDialog1.execute then
      begin
      Traduction.Items.LoadFromFile(OpenDialog1.FileName);
      Ini := TIniFile.Create('Stemma.ini');
      Ini.WriteString('Parametres','Langue',ExtractFileName(OpenDialog1.FileName));
      Ini.Free;
   end;
end;

procedure TPrincipale.MenuItem57Click(Sender: TObject);
var
   ini:TIniFile;
begin
   Ini := TIniFile.Create('Stemma.ini');
   OpenDialog1.InitialDir := ExcludeTrailingPathDelimiter(ExtractFilePath(ini.ReadString('Parametres','PDF','C:\Program Files (x86)\Adobe\Reader 10.0\Reader\AcroRd32.exe')));
   OpenDialog1.DefaultExt := '*.exe';
   OpenDialog1.Filter:= AnsitoUTF8(Traduction.Items[305])+' (*.exe)|*.exe';
   OpenDialog1.Title := AnsitoUTF8(Traduction.Items[304]);
   if OpenDialog1.execute then
      begin
      Ini.WriteString('Parametres','PDF',OpenDialog1.FileName);
   end;
   Ini.Free;
end;

procedure TPrincipale.MenuItem59Click(Sender: TObject);
begin
  // Copier Parent
  If MenuItem10.Checked Then
     begin
     Query1.SQL.Clear;
     Query1.SQL.Add('SELECT Y, A, B, M, P, X, SD FROM R WHERE no='+
                FormParents.TableauParents.Cells[0,FormParents.TableauParents.Row]);
     Query1.Open;
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO R (Y, A, B, M, P, X, SD) VALUES ('+
                Query1.Fields[0].AsString+', '+
                Query1.Fields[1].AsString+', '+
                Query1.Fields[2].AsString+', '''+
                Query1.Fields[3].AsString+''', '''+
                Query1.Fields[4].AsString+''', '+
                '0'+', '''+
                Query1.Fields[6].AsString+''')');
     Query2.ExecSQL;
     SaveModificationTime(Query1.Fields[2].AsString);
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''R'' AND N='+
                FormParents.TableauParents.Cells[0,FormParents.TableauParents.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   Query3.Fields[4].AsString+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     SaveModificationTime(Principale.Individu.Caption);
     PopulateParents;
  end;
end;

procedure TPrincipale.MenuItem60Click(Sender: TObject);
begin
  // Copier Enfant
  If MenuItem14.Checked Then
     begin
     Query1.SQL.Clear;
     Query1.SQL.Add('SELECT Y, A, B, M, P, X, SD FROM R WHERE no='+
                FormEnfants.TableauEnfants.Cells[0,FormEnfants.TableauEnfants.Row]);
     Query1.Open;
     Query2.SQL.Clear;
     Query2.SQL.Add('INSERT IGNORE INTO R (Y, A, B, M, P, X, SD) VALUES ('+
                Query1.Fields[0].AsString+', '+
                Query1.Fields[1].AsString+', '+
                Query1.Fields[2].AsString+', '''+
                Query1.Fields[3].AsString+''', '''+
                Query1.Fields[4].AsString+''', '+
                '0'+', '''+
                Query1.Fields[6].AsString+''')');
     Query2.ExecSQL;
     SaveModificationTime(Query1.Fields[1].AsString);
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SHOW TABLE STATUS WHERE NAME=''R''');
     Principale.Query2.Open;
     Principale.Query2.First;
     Query3.SQL.Clear;
     Query3.SQL.Add('SELECT Y, N, S, Q, M FROM C WHERE Y=''R'' AND N='+
                FormEnfants.TableauEnfants.Cells[0,FormEnfants.TableauEnfants.Row]);
     Query3.Open;
     while not Query3.EOF do
        begin
        Query4.SQL.Clear;
        Query4.SQL.Add('INSERT IGNORE INTO C (Y, N, S, Q, M) VALUES ('''+
                   Query3.Fields[0].AsString+''', '+
                   InttoStr(Principale.Query2.Fields[10].AsInteger-1)+', '+
                   Query3.Fields[2].AsString+', '+
                   Query3.Fields[3].AsString+', '''+
                   Query3.Fields[4].AsString+''')');
        Query4.ExecSQL;
        Query3.Next;
     end;
     PopulateEnfants;
     SaveModificationTime(Principale.Individu.Caption);
  end;
end;

procedure TPrincipale.MenuItem61Click(Sender: TObject);
begin
  // Fermer projet
  Principale.Database.Connected := false;
  Principale.Caption := 'Stemma';
  // Fermer toutes les fenêtres ouvertes
  If MenuItem13.Checked then FormExplorateur.Close;
  If MenuItem8.Checked then FormNoms.Close;
  If MenuItem9.Checked then FormEvenements.Close;
  If MenuItem10.Checked then FormParents.Close;
  If MenuItem11.Checked then FormExhibits.Close;
  If MenuItem14.Checked then FormEnfants.Close;
  If MenuItem15.Checked then FormFratrie.Close;
  If MenuItem16.Checked then FormAncetres.Close;
  If MenuItem23.Checked then FormDescendants.Close;
  If MenuItem26.Checked then FormImage.Close;
  Principale.Individu.Caption:='0';
end;

procedure TPrincipale.MenuItem63Click(Sender: TObject);  // Création du Site Web
var
   MyCursor:Tcursor;
   max_request,nb_fichier,time_delay, row, totalrow:integer;
   fichier, fichier2: textfile;
   drive,filename,temp,server,db,user,password: String;
   Ini:Tinifile;
   continue:boolean;
begin
  Ini := TIniFile.Create('Stemma.ini');
  time_delay:=1000;
  // Demander ces variables et enregistrer dans IniFiles
  server:=ini.ReadString('Webexport','server','localhost');
  continue:=InputQuery(AnsitoUTF8(Traduction.Items[327]),AnsitoUTF8(Traduction.Items[328]),server);
  if continue then
     begin
     db:=ini.ReadString('Webexport','db','genealo_data');
     continue:=InputQuery(AnsitoUTF8(Traduction.Items[329]),AnsitoUTF8(Traduction.Items[330]),db);
     if continue then
        begin
        user:=ini.ReadString('Webexport','user','root');
        continue:=InputQuery(AnsitoUTF8(Traduction.Items[331]),AnsitoUTF8(Traduction.Items[332]),user);
        if continue then
           begin
           password:=ini.ReadString('Webexport','password','');
           continue:=InputQuery(AnsitoUTF8(Traduction.Items[333]),AnsitoUTF8(Traduction.Items[334]),password);
           if continue then
              begin
              SelectDirectoryDialog1.InitialDir:=ini.ReadString('Webexport','dir','');
              SelectDirectoryDialog1.Title:=AnsitoUTF8(Traduction.Items[326]);
              continue:=SelectDirectoryDialog1.Execute;
           end;
        end;
     end;
  end;
  if continue then
     begin
     drive := SelectDirectoryDialog1.FileName;
     Ini.WriteString('Webexport','dir',drive);
     Ini.WriteString('Webexport','server',server);
     Ini.WriteString('Webexport','db',db);
     Ini.WriteString('Webexport','user',user);
     Ini.WriteString('Webexport','password',password);
     Ini.Free;
     drive:=drive+'\';
     MyCursor := Screen.Cursor;
     Screen.Cursor := crHourGlass;
     ProgressBar.Visible := true;
     ProgressBar.Max:=0;
     StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[323]);
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no FROM I WHERE NOT V=''O'' ');
     Query1.Open;
     Query2.SQL.Clear;
     Query2.SQL.add('SELECT count(I.no) as row FROM I  WHERE NOT V=''O'' ');
     Query2.Open;
     Query2.First;
     row:=Query2.Fields[0].AsInteger+1;
     ProgressBar.Max:=row;
     ProgressBar.Position:=1;
     max_request := 10000;
     filename := drive+'sitemap.xml';
     assignfile(fichier,FileName);
     rewrite(fichier);
     writeln(fichier,'<?xml version="1.0" encoding="UTF-8"?>');
     writeln(fichier,'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">');
     while not Query1.eof do
        begin
        // créer fichiers sitemap
        temp := '<url><loc>https://genealogie.quebec/info/index.php?no='+Query1.Fields[0].AsString+'</loc><changefreq>monthly</changefreq></url>';
        writeln(fichier,temp);
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           writeln(fichier,'</urlset>');
           closefile(fichier);
           filename := 'c:\DATA\HTML\sitemap'+inttostr(trunc(ProgressBar.position / max_request))+'.xml';
           assignfile(fichier,FileName);
           rewrite(fichier);
           writeln(fichier,'<?xml version="1.0" encoding="UTF-8"?>');
           writeln(fichier,'<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">');
        end;
        Query1.Next;
        Application.ProcessMessages;
        ProgressBar.Position:=ProgressBar.Position+1;
     end;
     writeln(fichier,'</urlset>');
     closefile(fichier);
     StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[324]);
     // Exporter projet, créer fichiers index
//     Query1.SQL.Clear;
//     Query1.SQL.add('SELECT N.I, N.N FROM N JOIN I ON N.I=I.no WHERE NOT I.V=''O'' ORDER BY N.I1, N.I2, N.I3, N.I4 LIMIT 3000');
//     Query1.Open;
//     Query2.SQL.Clear;
//     Query2.SQL.add('SELECT count(N.no) as row FROM N JOIN I ON N.I=I.no WHERE NOT I.V=''O'' ');
//     Query2.Open;
//     Query2.First;
//     row:=Query2.Fields[0].AsInteger+1;
//     ProgressBar.Max:=row;
//     ProgressBar.Position:=1;
//     filename := drive+'boutons.html';
//     assignfile(boutons,FileName);
//     rewrite(boutons);
//     settextcodepage(boutons,1252);
//     writeln(boutons,'<HTML>');
//     writeln(boutons,'<HEAD>');
//     writeln(boutons,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=utf-8">');
//     writeln(boutons,'<TITLE>Choix d''Index</TITLE>');
//     writeln(boutons,'<BASE TARGET="texte">');
//     writeln(boutons,'<!--mstheme--><link rel="stylesheet" type="text/css" href="../_themes/genealogy/gene1011.css"><meta name="Microsoft Theme" content="genealogy 1011">');
//     writeln(boutons,'</HEAD>');
//     writeln(boutons,'<BODY>');
//     writeln(boutons,'<HR>');
//     writeln(boutons,'<DL>');
//     nb_fichier:=1;
//     filename := format('%sindex_%d.php',[drive,nb_fichier]);
//     assignfile(indexhandle,FileName);
//     rewrite(indexhandle);
//     writeln(indexhandle,'<HTML>');
//     writeln(indexhandle,'<HEAD>');
//     writeln(indexhandle,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=utf-8">');
//     writeln(indexhandle,Utf8ToAnsi('<TITLE>Index de la base de données</TITLE>'));
//     writeln(indexhandle,'<BASE TARGET="texte">');
//     writeln(indexhandle,'<!--mstheme--><link rel="stylesheet" type="text/css" href="../_themes/genealogy/gene1011.css"><meta name="Microsoft Theme" content="genealogy 1011">');
//     writeln(indexhandle,'</HEAD>');
//     writeln(indexhandle,'<BODY>');
//     writeln(indexhandle,Utf8ToAnsi('<DD><A HREF=testphp/recherche.php>Recherche avancée</A></DD>'));
//     writeln(indexhandle,'<?php');
//     writeln(indexhandle,'if (isset($_POST["recherche"]))  {');
//     writeln(indexhandle,'   $oldrecherche = $_POST["recherche"];');
//     writeln(indexhandle,'} else {');
//     writeln(indexhandle,'   $oldrecherche = '''';');
//     writeln(indexhandle,'}?>');
//     writeln(indexhandle,'  <form method="post" target=index action="<?php echo $_SERVER[''PHP_SELF'']?>">');
//     writeln(indexhandle,'  <input type="Text" name="recherche" value="<?php echo $oldrecherche?>"><br>');
//     writeln(indexhandle,'  <input type="Submit" target=index name="submit" value="Recherche nom">');
//     writeln(indexhandle,'  </form>');
//     writeln(indexhandle,'<?php');
//     writeln(indexhandle,'if (isset($_POST["recherche"]))  {');
//     writeln(indexhandle,'  // process form');
//     writeln(indexhandle,'   require("testphp/fonctions.php");');
//     writeln(indexhandle,'   $serveur = GetMySqlServerAddress();');
//     writeln(indexhandle,'   $db = mysql_connect($serveur, "'+user+'", "'+password+'");');
//     writeln(indexhandle,'   mysql_select_db("genealo_data",$db);');
//     writeln(indexhandle,'   $result = mysql_query("SELECT I, N FROM N WHERE MATCH (N) AGAINST (''$oldrecherche'' IN BOOLEAN MODE) ORDER BY MATCH (N) AGAINST (''$oldrecherche'' IN BOOLEAN MODE) DESC, I1",$db);');
//     writeln(indexhandle,'   while ($myrow = mysql_fetch_row($result)) {');
//     writeln(indexhandle,'      $result2 = mysql_query("SELECT V FROM I WHERE no=$myrow[0]",$db);');
//     writeln(indexhandle,'      while ($myrow2 = mysql_fetch_row($result2)) {');
//     writeln(indexhandle,'          $html = $myrow2[0];');
//     writeln(indexhandle,'      }');
//     writeln(indexhandle,'      if ($html!=''O'') {');
//     writeln(indexhandle,'         if (substr($myrow[1],0,5)==''!TMG|'') {');
//     writeln(indexhandle,'            $myrow[1]= substr($myrow[1],strpos($myrow[1],''|'')+1,strlen($myrow[1]));');
//     writeln(indexhandle,'            $nom     = substr($myrow[1],0,strpos($myrow[1],''|''));');
//     write(indexhandle,'            $suffixe  = substr($myrow[1],(strpos($myrow[1],''|'',strpos($myrow[1],''|'',');
//     writeln(indexhandle,'strpos($myrow[1],''|'')+1)+1)+1),(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)+1)-(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)+1)));');
//     writeln(indexhandle,'            $prenom = substr($myrow[1],(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1),(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)-(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)));');
//     writeln(indexhandle,'            $titre      = substr($myrow[1],strpos($myrow[1],''|'')+1,(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1))-strpos($myrow[1],''|'')-1);');
//     writeln(indexhandle,'         } else {');
//     writeln(indexhandle,'            $titre='''';');
//     writeln(indexhandle,'            $prenom='''';');
//     writeln(indexhandle,'            $nom='''';');
//     writeln(indexhandle,'            $suffixe='''';');
//     writeln(indexhandle,'            if (strpos($myrow[1],''</Titre>'')>0) {');
//     writeln(indexhandle,'               $titre=substr($myrow[1],strpos($myrow[1],''<Titre>'')+7,strpos($myrow[1],''</Titre>'')-strpos($myrow[1],''<Titre>'')-7); }');
//     writeln(indexhandle,Utf8ToAnsi('            if (strpos($myrow[1],''</Prénom>'')>0) {'));
//     writeln(indexhandle,Utf8ToAnsi('               $prenom=substr($myrow[1],strpos($myrow[1],''<Prénom>'')+8,strpos($myrow[1],''</Prénom>'')-strpos($myrow[1],''<Prénom>'')-8); }'));
//     writeln(indexhandle,'            if (strpos($myrow[1],''</Nom>'')>0) {');
//     writeln(indexhandle,'               $nom=substr($myrow[1],strpos($myrow[1],''<Nom>'')+5,strpos($myrow[1],''</Nom>'')-strpos($myrow[1],''<Nom>'')-5); }');
//     writeln(indexhandle,'            if (strpos($myrow[1],''</Suffixe>'')>0) {');
//     writeln(indexhandle,'               $suffixe=substr($myrow[1],strpos($myrow[1],''<Suffixe>'')+9,strpos($myrow[1],''</Suffixe>'')-strpos($myrow[1],''<Suffixe>'')-9); }');
//     writeln(indexhandle,'         }');
//     writeln(indexhandle,'    if (((strlen($suffixe)>0) && (strlen($nom)>0)) && (strlen($prenom)>0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s, %s",$myrow[0],$nom,$suffixe,$prenom);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if (((strlen($suffixe)>0) && (strlen($nom)==0)) && (strlen($prenom)>0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s, %s",$myrow[0],$nom,$suffixe,$prenom);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)>0)) && (strlen($prenom)>0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s, %s",$myrow[0],$nom,$prenom);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if (((strlen($suffixe)>0) || (strlen($nom)>0)) && (strlen($prenom)==0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s",$myrow[0],$nom,$suffixe);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)==0)) && (strlen($prenom)>0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">, %s",$myrow[0],$prenom);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)==0)) && (strlen($prenom)==0)) {');
//     writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">???",$myrow[0]);');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'    if ((strlen($titre)>0)) {');
//     writeln(indexhandle,'        printf(" (%s)</A></DD>",$titre);');
//     writeln(indexhandle,'    } else {');
//     writeln(indexhandle,'        printf("</A></DD>");');
//     writeln(indexhandle,'    }');
//     writeln(indexhandle,'   }');
//     writeln(indexhandle,'   }');
//     writeln(indexhandle,'} ?>');
//     writeln(indexhandle,'<HR>');
//     writeln(indexhandle,'<DL>');
//     first := UTF8toANSI(DecodeName(Query1.Fields[1].AsString,2));
//     last:='';
//     max_request := 3000;
//     while (ProgressBar.position<ProgressBar.Max) do
//        begin
//        If (ProgressBar.position Mod max_request) = 0 Then
//           begin
           // Ferme le fichier index, ouvre en un autre et ajoute une ligne à bouton
//           writeln(indexhandle,'</DL>');
//           writeln(indexhandle,'<HR>');
//           writeln(indexhandle,'</BODY>');
//           writeln(indexhandle,'</HTML>');
//           closefile(indexhandle);
//           write(boutons,'<DD><A TITLE="'+first+' - '+last);
//           write(boutons,format('" TARGET="index" HREF=index_%d.php>',[nb_fichier]));
//           write(boutons,AnsiUpperCase(leftstr(first,3)));
//           write(boutons,' - '+AnsiUpperCase(leftstr(last,3)));
//           writeln(boutons,'</A></DD>');
//           nb_fichier:=nb_fichier+1;
//           filename := format('%sindex_%d.php',[drive,nb_fichier]);
//           assignfile(indexhandle,FileName);
//           rewrite(indexhandle);
//           writeln(indexhandle,'<HTML>');
//           writeln(indexhandle,'<HEAD>');
//           writeln(indexhandle,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=utf-8">');
//           writeln(indexhandle,Utf8ToAnsi('<TITLE>Index de la base de données</TITLE>'));
//           writeln(indexhandle,'<BASE TARGET="texte">');
//           writeln(indexhandle,'<!--mstheme--><link rel="stylesheet" type="text/css" href="../_themes/genealogy/gene1011.css"><meta name="Microsoft Theme" content="genealogy 1011">');
//           writeln(indexhandle,'</HEAD>');
//           writeln(indexhandle,'<BODY>');
//           writeln(indexhandle,Utf8ToAnsi('<DD><A HREF=testphp/recherche.php>Recherche avancée</A></DD>'));
//           writeln(indexhandle,'<?php');
//           writeln(indexhandle,'if (isset($_POST["recherche"]))  {');
//           writeln(indexhandle,'   $oldrecherche = $_POST["recherche"];');
//           writeln(indexhandle,'} else {');
//           writeln(indexhandle,'   $oldrecherche = '''';');
//           writeln(indexhandle,'}?>');
//           writeln(indexhandle,'  <form method="post" target=index action="<?php echo $_SERVER[''PHP_SELF'']?>">');
//           writeln(indexhandle,'  <input type="Text" name="recherche" value="<?php echo $oldrecherche?>"><br>');
//           writeln(indexhandle,'  <input type="Submit" target=index name="submit" value="Recherche nom">');
//           writeln(indexhandle,'  </form>');
//           writeln(indexhandle,'<?php');
//           writeln(indexhandle,'if (isset($_POST["recherche"]))  {');
//           writeln(indexhandle,'  // process form');
//           writeln(indexhandle,'   require("testphp/fonctions.php");');
//           writeln(indexhandle,'   $serveur = GetMySqlServerAddress();');
//           writeln(indexhandle,'   $db = mysql_connect($serveur, "'+user+'", "'+password+'");');
//           writeln(indexhandle,'   mysql_select_db("genealo_data",$db);');
//           writeln(indexhandle,'   $result = mysql_query("SELECT I, N FROM N WHERE MATCH (N) AGAINST (''$oldrecherche'' IN BOOLEAN MODE) ORDER BY MATCH (N) AGAINST (''$oldrecherche'' IN BOOLEAN MODE) DESC",$db);');
//           writeln(indexhandle,'   while ($myrow = mysql_fetch_row($result)) {');
//           writeln(indexhandle,'      $result2 = mysql_query("SELECT V FROM I WHERE no=$myrow[0]",$db);');
//           writeln(indexhandle,'      while ($myrow2 = mysql_fetch_row($result2)) {');
//           writeln(indexhandle,'          $html = $myrow2[0];');
//           writeln(indexhandle,'      }');
//           writeln(indexhandle,'      if ($html!=''O'') {');
//           writeln(indexhandle,'         if (substr($myrow[1],0,5)==''!TMG|'') {');
//           writeln(indexhandle,'            $myrow[1]= substr($myrow[1],strpos($myrow[1],''|'')+1,strlen($myrow[1]));');
//           writeln(indexhandle,'            $nom     = substr($myrow[1],0,strpos($myrow[1],''|''));');
//           writeln(indexhandle,'            $suffixe  = substr($myrow[1],(strpos($myrow[1],''|'',strpos($myrow[1],''|'',');
//           write(indexhandle,'strpos($myrow[1],''|'')+1)+1)+1),(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)+1)-(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)+1)));');
//           writeln(indexhandle,'            $prenom = substr($myrow[1],(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1),(strpos($myrow[1],''|'',strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)-(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1)+1)));');
//           writeln(indexhandle,'            $titre      = substr($myrow[1],strpos($myrow[1],''|'')+1,(strpos($myrow[1],''|'',strpos($myrow[1],''|'')+1))-strpos($myrow[1],''|'')-1);');
//           writeln(indexhandle,'         } else {');
//           writeln(indexhandle,'            $titre='''';');
//           writeln(indexhandle,'            $prenom='''';');
//           writeln(indexhandle,'            $nom='''';');
//           writeln(indexhandle,'            $suffixe='''';');
//           writeln(indexhandle,'            if (strpos($myrow[1],''</Titre>'')>0) {');
//           writeln(indexhandle,'               $titre=substr($myrow[1],strpos($myrow[1],''<Titre>'')+7,strpos($myrow[1],''</Titre>'')-strpos($myrow[1],''<Titre>'')-7); }');
//           writeln(indexhandle,Utf8ToAnsi('            if (strpos($myrow[1],''</Prénom>'')>0) {'));
//           writeln(indexhandle,Utf8ToAnsi('               $prenom=substr($myrow[1],strpos($myrow[1],''<Prénom>'')+8,strpos($myrow[1],''</Prénom>'')-strpos($myrow[1],''<Prénom>'')-8); }'));
//           writeln(indexhandle,'            if (strpos($myrow[1],''</Nom>'')>0) {');
//           writeln(indexhandle,'               $nom=substr($myrow[1],strpos($myrow[1],''<Nom>'')+5,strpos($myrow[1],''</Nom>'')-strpos($myrow[1],''<Nom>'')-5); }');
//           writeln(indexhandle,'            if (strpos($myrow[1],''</Suffixe>'')>0) {');
//           writeln(indexhandle,'               $suffixe=substr($myrow[1],strpos($myrow[1],''<Suffixe>'')+9,strpos($myrow[1],''</Suffixe>'')-strpos($myrow[1],''<Suffixe>'')-9); }');
//           writeln(indexhandle,'         }');
//           writeln(indexhandle,'    if (((strlen($suffixe)>0) && (strlen($nom)>0)) && (strlen($prenom)>0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s, %s",$myrow[0],$nom,$suffixe,$prenom);');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if (((strlen($suffixe)>0) && (strlen($nom)==0)) && (strlen($prenom)>0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s, %s",$myrow[0],$nom,$suffixe,$prenom);');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)>0)) && (strlen($prenom)>0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s, %s",$myrow[0],$nom,$prenom);');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if (((strlen($suffixe)>0) || (strlen($nom)>0)) && (strlen($prenom)==0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">%s %s",$myrow[0],$nom,$suffixe);');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)==0)) && (strlen($prenom)>0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">, %s",$myrow[0],$prenom);');
//          writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if (((strlen($suffixe)==0) && (strlen($nom)==0)) && (strlen($prenom)==0)) {');
//           writeln(indexhandle,'        printf("\n<DD><A HREF=\"testphp/info.php?no=%d\">???",$myrow[0]);');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'    if ((strlen($titre)>0)) {');
//           writeln(indexhandle,'        printf(" (%s)</A></DD>",$titre);');
//           writeln(indexhandle,'    } else {');
//           writeln(indexhandle,'        printf("</A></DD>");');
//           writeln(indexhandle,'    }');
//           writeln(indexhandle,'   }');
//           writeln(indexhandle,'   }');
//           writeln(indexhandle,'} ?>');
//           writeln(indexhandle,'<HR>');
//           writeln(indexhandle,'<DL>');
//           first := UTF8toANSI(DecodeName(Query1.Fields[1].AsString,2));
//           Query1.SQL.Clear;
//           Query1.SQL.add('SELECT N.I, N.N FROM N JOIN I ON N.I=I.no WHERE NOT I.V=''O'' ORDER BY N.I1, N.I2, N.I3, N.I4 LIMIT 3000 OFFSET '+inttostr(ProgressBar.Position));
//           Query1.Open;
//        end;
//        // Inscrit le nom
//        last := UTF8toANSI(DecodeName(Query1.Fields[1].AsString,2));
//        write(indexhandle,'<DD><A HREF="testphp/info.php?no=');
//        write(indexhandle,Query1.Fields[0].AsString);
//        write(indexhandle,'">');
//        write(indexhandle,last);
//        writeln(indexhandle,'</A></DD>');
//        Query1.Next;
//        Application.ProcessMessages;
//        ProgressBar.Position:=ProgressBar.Position+1;
//     end;
     // Fermeture du fichier de boutons
//     writeln(indexhandle,'</DL>');
//     writeln(indexhandle,'<HR>');
//     writeln(indexhandle,'</BODY>');
//     writeln(indexhandle,'</HTML>');
//     closefile(indexhandle);
//     write(boutons,'<DD><A TITLE="'+first+' - '+last);
//     write(boutons,format('" TARGET="index" HREF=index_%d.php>',[nb_fichier]));
//     write(boutons,AnsiUpperCase(leftstr(first,3)));
//     write(boutons,' - '+AnsiUpperCase(leftstr(last,3)));
//     writeln(boutons,'</A></DD>');
//     writeln(boutons,'</DL>');
//     writeln(boutons,'<HR>');
     // Ajout d'une recherche Google de mon site
//     writeln(boutons,'<!-- Search Google -->');
//     writeln(boutons,'<script>');
//     writeln(boutons,'  (function() {');
//     writeln(boutons,'    var cx = ''016932793005275160808:jqbw_5nc7au'';');
//     writeln(boutons,'    var gcse = document.createElement(''script'');');
//     writeln(boutons,'    gcse.type = ''text/javascript'';');
//     writeln(boutons,'    gcse.async = true;');
//     writeln(boutons,'    gcse.src = (document.location.protocol == ''https:'' ? ''https:'' : ''http:'') +');
//     writeln(boutons,'        ''//cse.google.com/cse.js?cx='' + cx;');
//     writeln(boutons,'    var s = document.getElementsByTagName(''script'')[0];');
//     writeln(boutons,'    s.parentNode.insertBefore(gcse, s);');
//     writeln(boutons,'  })();');
//     writeln(boutons,'</script>');
//     writeln(boutons,'<gcse:search></gcse:search>');
//     writeln(boutons,'<!-- Search Google -->');
//     writeln(boutons,'</BODY>');
//     writeln(boutons,'</HTML>');
//     closefile(boutons);
{*     StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[325]);
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM A');
     Query1.Open;
     ProgressBar.Max:=Query2.Fields[0].AsInteger+1;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM C');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM D');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM E');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM I');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM L');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM N');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM R');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM S');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM W');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM X');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM Y');
     Query1.Open;
     ProgressBar.Max:=ProgressBar.Max+Query1.Fields[0].AsInteger;
     ProgressBar.Position:=1;
     max_request := 5000;
     // Exporter projet, créer fichiers php de base de données }
     // Insert file header }
//     filename := Drive+'update.html';
//     assignfile(fichier2,FileName);
//     rewrite(fichier2);
//     writeln(fichier2,'<HTML>');
//     writeln(fichier2,'<BODY>');
//    writeln(fichier2,'<LI><A HREF="beginupdate.php" target="texte">beginupdate.php</A></LI>');
//     nb_fichier:=1;
     // TABLE A
{*     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, S, D, M FROM A');
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_A'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_A'+inttostr(nb_fichier)+'.php" target="texte">writedata_A'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = new mysqli("'+server+'", "'+user+'", "'+password+'", "'+db+'");');
     writeln(fichier,'mysqli_set_charset($db,"utf8");');
     writeln(fichier,'$r = $db->query("DROP TABLE IF EXISTS A");');
     writeln(fichier,'$r = $db->query("CREATE TABLE A (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S SMALLINT(8) UNSIGNED, D SMALLINT(8) UNSIGNED, M TINYTEXT)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO A (no, S, D, M) VALUES";');
     while not Query1.EOF do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_A'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_A'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_A'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_A'+inttostr(nb_fichier)+'.php" target="texte">writedata_A'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = new mysqli("'+server+'", "'+user+'", "'+password+'", "'+db+'");');
           writeln(fichier,'mysqli_set_charset($db,"utf8");');
           writeln(fichier,'$q = "INSERT IGNORE INTO A (no, S, D, M) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = $db->query("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '+Query1.Fields[2].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = $db->query("CREATE INDEX S ON A (S)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = $db->query("CREATE INDEX D ON A (D)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_A'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_C'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE C
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM C');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, Y, N, S, Q, M FROM C LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_C'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_C'+inttostr(nb_fichier)+'.php" target="texte">writedata_C'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS C");');
     writeln(fichier,'$r = m("CREATE TABLE C (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y CHAR(1), N MEDIUMINT(9) UNSIGNED, S SMALLINT(6) UNSIGNED, Q SMALLINT(2) UNSIGNED, M TEXT NULL)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO C (no, Y, N, S, Q, M) VALUES";');
     row:=0;
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_C'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_C'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, Y, N, S, Q, M FROM C LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_C'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_C'+inttostr(nb_fichier)+'.php" target="texte">writedata_C'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO C (no, Y, N, S, Q, M) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+Query1.Fields[1].AsString+''', '+Query1.Fields[2].AsString+', '+Query1.Fields[3].AsString+', '+Query1.Fields[4].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE INDEX N ON C (N)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX S ON C (S)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_C'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_D'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE D
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, T, D, M, I FROM D');
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_D'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_D'+inttostr(nb_fichier)+'.php" target="texte">writedata_D'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS D");');
     writeln(fichier,'$r = m("CREATE TABLE D (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT, M TINYTEXT, I MEDIUMINT(9) UNSIGNED)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO D (no, T, D, M, I) VALUES";');
     while not Query1.EOF do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_D'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_D'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_D'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_D'+inttostr(nb_fichier)+'.php" target="texte">writedata_D'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO D (no, T, D, M, I) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[4].AsString+')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'printf("\ndernier writedata_D'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_E'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE E
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM E');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, Y, PD, SD, L, M, X FROM E LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_E'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_E'+inttostr(nb_fichier)+'.php" target="texte">writedata_E'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS E");');
     writeln(fichier,'$r = m("CREATE TABLE E (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, Y SMALLINT(5) UNSIGNED, PD TINYTEXT, SD TINYTEXT, L MEDIUMINT(8) UNSIGNED, M TEXT, X TINYINT(1) UNSIGNED)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO E (no, Y, PD, SD, L, M, X) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_E'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_E'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, Y, PD, SD, L, M, X FROM E LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_E'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_E'+inttostr(nb_fichier)+'.php" target="texte">writedata_E'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO E (no, Y, PD, SD, L, M, X) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[4].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[6].AsString+')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE FULLTEXT INDEX M ON E (M)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_E'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_I'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE I
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM I');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, S, V, I, date FROM I LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_I'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_I'+inttostr(nb_fichier)+'.php" target="texte">writedata_I'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS I");');
     writeln(fichier,'$r = m("CREATE TABLE I (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, S CHAR(1), V CHAR(1), I TINYINT(2), date CHAR(8))") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO I (no, S, V, I, date) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_I'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_I'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, S, V, I, date FROM I LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_I'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_I'+inttostr(nb_fichier)+'.php" target="texte">writedata_I'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO I (no, S, V, I, date) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+Query1.Fields[1].AsString+''', '''+Query1.Fields[2].AsString+''', '+Query1.Fields[3].AsString+', '''+Query1.Fields[4].AsString+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'printf("\ndernier writedata_I'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,'printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));');
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_L'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE L
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM L');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, L FROM L LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_L'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_L'+inttostr(nb_fichier)+'.php" target="texte">writedata_L'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS L");');
     writeln(fichier,'$r = m("CREATE TABLE L (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, L TINYTEXT)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO L (no, L) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_L'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_L'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, L FROM L LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_L'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_L'+inttostr(nb_fichier)+'.php" target="texte">writedata_L'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO L (no, L) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'printf("\ndernier writedata_L'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,'printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));');
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_N'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE N
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM N');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4 FROM N LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_N'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_N'+inttostr(nb_fichier)+'.php" target="texte">writedata_N'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS N");');
     write(fichier,'$r = m("CREATE TABLE N (no MEDIUMINT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED,');
     writeln(fichier,' Y SMALLINT(5) UNSIGNED, N TEXT, X TINYINT(1) UNSIGNED, M TEXT, P MEDIUMTEXT, PD TINYTEXT, SD TINYTEXT, I1 VARCHAR(35), I2 VARCHAR(35), I3 VARCHAR(35), I4 VARCHAR(35))") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO N (no, I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_N'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_N'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4 FROM N LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_N'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_N'+inttostr(nb_fichier)+'.php" target="texte">writedata_N'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO N (no, I, Y, N, X, M, P, PD, SD, I1, I2, I3, I4) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '+Query1.Fields[2].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[4].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[7].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[8].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[9].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[10].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[11].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[12].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE FULLTEXT INDEX N ON N (N)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I ON N (I)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I1 ON N (I1)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I2 ON N (I2)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I3 ON N (I3)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I4 ON N (I4)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_N'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,'printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));');
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_R'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE R
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM R');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, Y, A, B, M, X, P, SD FROM R LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_R'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_R'+inttostr(nb_fichier)+'.php" target="texte">writedata_R'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS R");');
     write(fichier,'$r = m("CREATE TABLE R (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY,');
     writeln(fichier,' Y SMALLINT(5) UNSIGNED, A MEDIUMINT(8) UNSIGNED, B MEDIUMINT(8) UNSIGNED, M TEXT, X TINYINT(1) UNSIGNED, P MEDIUMTEXT, SD TINYTEXT)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO R (no, Y, A, B, M, X, P, SD) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_R'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_R'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, Y, A, B, M, X, P, SD FROM R LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_R'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_R'+inttostr(nb_fichier)+'.php" target="texte">writedata_R'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO R (no, Y, A, B, M, X, P, SD) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '+Query1.Fields[2].AsString+', '+Query1.Fields[3].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[5].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'$','\$'),'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[7].AsString,'$','\$'),'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE INDEX A ON R (A)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX B ON R (B)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_R'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_S'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE S
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM S');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, T, D, M, A, Q FROM S LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_S'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_S'+inttostr(nb_fichier)+'.php" target="texte">writedata_S'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS S");');
     writeln(fichier,'$r = m("CREATE TABLE S (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), D TINYTEXT, M TINYTEXT, A TINYTEXT, Q SMALLINT(2) UNSIGNED)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO S (no, T, D, M, A, Q) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_S'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_S'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, T, D, M, A, Q FROM S LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_S'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_S'+inttostr(nb_fichier)+'.php" target="texte">writedata_S'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO S (no, T, D, M, A, Q) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[5].AsString+')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'printf("\ndernier writedata_S'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_W'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE W
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM W');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, I, E, X, P, R FROM W LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_W'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_W'+inttostr(nb_fichier)+'.php" target="texte">writedata_W'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS W");');
     writeln(fichier,'$r = m("CREATE TABLE W (no MEDIUMINT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY, I MEDIUMINT(8) UNSIGNED, E MEDIUMINT(8) UNSIGNED, X TINYINT(1) UNSIGNED, P TINYTEXT, R VARCHAR(20))") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO W (no, I, E, X, P, R) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_W'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_W'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, I, E, X, P, R FROM W LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_W'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_W'+inttostr(nb_fichier)+'.php" target="texte">writedata_W'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-12528">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO W (no, I, E, X, P, R) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '+Query1.Fields[2].AsString+', '+Query1.Fields[3].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'$','\$'),'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE INDEX E ON W (E)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'$r = m("CREATE INDEX I ON W (I)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_W'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_X'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE X
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT COUNT(*) as row FROM X');
     Query1.Open;
     totalrow:=Query1.Fields[0].AsInteger;
     row:=0;
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, X, T, D, F, Z, A, N FROM X LIMIT '+inttostr(max_request));
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_X'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_X'+inttostr(nb_fichier)+'.php" target="texte">writedata_X'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS X");');
     writeln(fichier,'$r = m("CREATE TABLE X (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, X TINYINT(1) UNSIGNED, T VARCHAR(35), D TINYTEXT, F TINYTEXT, Z LONGTEXT, A CHAR(1), N MEDIUMINT(9) UNSIGNED)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO X (no, X, T, D, F, Z, A, N) VALUES";');
     while row<totalrow do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_X'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_X'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           Query1.SQL.Clear;
           Query1.SQL.add('SELECT no, X, T, D, F, Z, A, N FROM X LIMIT '+inttostr(max_request)+' OFFSET '+inttostr(row));
           Query1.Open;
           Query1.First;
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_X'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_X'+inttostr(nb_fichier)+'.php" target="texte">writedata_X'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO X (no, X, T, D, F, Z, A, N) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '+Query1.Fields[1].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'\','\\\\'),'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[5].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[6].AsString,'"','\"'),'''','\''')+''', '+Query1.Fields[7].AsString+')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        row:=row+1;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'$r = m("CREATE INDEX N ON X (N)") OR DIE ("Could not successfully run query from DB2: " . n());');
     writeln(fichier,'printf("\ndernier writedata_X'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_Y'+inttostr(nb_fichier)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
     writeln(fichier,'echo ("<noscript>\n");');
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     // TABLE Y
     Query1.SQL.Clear;
     Query1.SQL.add('SELECT no, T, Y, P, R FROM Y');
     Query1.Open;
     Query1.First;
     filename := Drive+'writedata_Y'+inttostr(nb_fichier)+'.php';
     assignfile(fichier,FileName);
     rewrite(fichier);
     settextcodepage(fichier,1252);
     writeln(fichier2,'<LI><A HREF="writedata_Y'+inttostr(nb_fichier)+'.php" target="texte">writedata_Y'+inttostr(nb_fichier)+'.php</A></LI>');
     writeln(fichier,'<HTML>');
     writeln(fichier,'<HEAD>');
     writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
     writeln(fichier,'</HEAD>');
     writeln(fichier,'<BODY>');
     writeln(fichier,'<?PHP');
     writeln(fichier,' Header("Cache-Control: must-revalidate");');
     writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
     writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
     writeln(fichier,' Header($ExpStr);');
     writeln(fichier,'function m($a) {');
     writeln(fichier,'   Return mysql_query($a);');
     writeln(fichier,'}');
     writeln(fichier,'function n() {');
     writeln(fichier,'   Return mysql_error();');
     writeln(fichier,'}');
     writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
     writeln(fichier,'mysql_select_db("'+db+'",$db);');
     writeln(fichier,'$r = m("DROP TABLE IF EXISTS Y");');
     writeln(fichier,'$r = m("CREATE TABLE Y (no SMALLINT(5) UNSIGNED AUTO_INCREMENT PRIMARY KEY, T VARCHAR(35), Y CHAR(1), P MEDIUMTEXT, R MEDIUMTEXT)") OR DIE ("Could not successfully run query from CREATE: " . n());');
     writeln(fichier,'$q = "INSERT IGNORE INTO Y (no, T, Y, P, R) VALUES";');
     while not Query1.EOF do
        begin
        If (ProgressBar.position Mod max_request) = 0 Then
           begin
           // Insert file footer
           writeln(fichier,'printf("\ndernier writedata_Y'+inttostr(nb_fichier)+'.php");');
           writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
           writeln(fichier,'');
           writeln(fichier,'echo ("<script language=\"JavaScript\" type=\"text/javascript\">window.setTimeout(''location.href=\"writedata_Y'+inttostr(nb_fichier+1)+'.php\";'','+inttostr(time_delay)+');</script>\n");');
           writeln(fichier,'echo ("<noscript>\n");');
           writeln(fichier,'');
           writeln(fichier,'?>');
           writeln(fichier,'</BODY>');
           writeln(fichier,'</HTML>');
           closefile(fichier);
           // Insert file header
           nb_fichier:=nb_fichier+1;
           filename := Drive+'writedata_Y'+inttostr(nb_fichier)+'.php';
           assignfile(fichier,FileName);
           rewrite(fichier);
           settextcodepage(fichier,1252);
           writeln(fichier2,'<LI><A HREF="writedata_Y'+inttostr(nb_fichier)+'.php" target="texte">writedata_Y'+inttostr(nb_fichier)+'.php</A></LI>');
           writeln(fichier,'<HTML>');
           writeln(fichier,'<HEAD>');
           writeln(fichier,'<META HTTP-EQUIV="Content-Type" CONTENT="Text/html; charset=windows-1252">');
           writeln(fichier,'</HEAD>');
           writeln(fichier,'<BODY>');
           writeln(fichier,'<?PHP');
           writeln(fichier,' Header("Cache-Control: must-revalidate");');
           writeln(fichier,' $offset = 60 * 60 * 24 * 365 * -1;');
           writeln(fichier,' $ExpStr = "Expires: " . gmdate("D, d M Y H:i:s", time() + $offset) . " GMT";');
           writeln(fichier,' Header($ExpStr);');
           writeln(fichier,'function m($a) {');
           writeln(fichier,'   Return mysql_query($a);');
           writeln(fichier,'}');
           writeln(fichier,'function n() {');
           writeln(fichier,'   Return mysql_error();');
           writeln(fichier,'}');
           writeln(fichier,'$db = mysql_connect("'+server+'", "'+user+'", "'+password+'");');
           writeln(fichier,'mysql_select_db("'+db+'",$db);');
           writeln(fichier,'$q = "INSERT IGNORE INTO Y (no, T, Y, P, R) VALUES";');
        end;
        // Insert record
        writeln(fichier,UTF8toANSI('$r = m("$q ('+Query1.Fields[0].AsString+', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[1].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[3].AsString,'$','\$'),'"','\"'),'''','\''')+''', '''+AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[4].AsString,'"','\"'),'''','\''')+''')") OR DIE ("Err:' + inttostr(ProgressBar.Position) + '". n());'));
        Query1.Next;
        ProgressBar.position:=ProgressBar.position+1;
        Application.ProcessMessages
     end;
     // Insert file footer
     writeln(fichier,'printf("\ndernier writedata_Y'+inttostr(nb_fichier)+'.php");');
     writeln(fichier,UTF8toANSI('printf(" terminé de traiter à %s\n",date("F j, Y, g:i:s a"));'));
     writeln(fichier,'');
     nb_fichier:=1;
     writeln(fichier,'');
     writeln(fichier,'?>');
     writeln(fichier,'</BODY>');
     writeln(fichier,'</HTML>');
     closefile(fichier);
     writeln(fichier2,'<LI><A HREF="endupdate.php" target="texte">endupdate.php</A></LI>');
     writeln(fichier2,'</BODY>');
     writeln(fichier2,'</HTML>');
     closefile(fichier2);
*}   ProgressBar.Visible := false;
     StatusBar.Panels[1].Text:='';
     Screen.Cursor := MyCursor;
  end;
end;

procedure TPrincipale.MenuItem65Click(Sender: TObject);
var
   MyCursor:Tcursor;
begin  // Compression de base de données
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ProgressBar.Visible := true;
  ProgressBar.Max:=12;
  ProgressBar.Position:=0;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE A');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE C');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE D');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE E');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE I');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE L');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE N');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE R');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE S');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE W');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE X');
  Principale.Query1.ExecSQL;
  ProgressBar.Position:=ProgressBar.Position+1;
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('REPAIR TABLE Y');
  Principale.Query1.ExecSQL;
  ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
end;

procedure TPrincipale.MenuItem66Click(Sender: TObject);
var
   MyCursor:Tcursor;
   row:integer;
   i3,i4:string;
begin  // Repair Birth-Death
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ProgressBar.Visible := true;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('SELECT no, I, I3, I4 FROM N');
  Principale.Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(N.no) as row FROM N');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     i3:=getI3(Query1.Fields[1].AsString);
     i4:=getI4(Query1.Fields[1].AsString);
     Principale.Query4.SQL.Clear;
     Principale.Query4.SQL.Add('UPDATE N SET I3='''+
                               AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i3,'\','\\'),'"','\"'),'''','\''')+
                               ''', I4='''+
                               AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i4,'\','\\'),'"','\"'),'''','\''')+
                               ''' WHERE no='+Query1.Fields[0].AsSTring);
     Principale.Query4.ExecSQL;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  ProgressBar.Visible:=False;
  if Principale.MenuItem13.Checked then
     begin
     PopulateIndex(StrToInt(FormExplorateur.O.Text));
     TrouveIndividu;
  end;
  Screen.Cursor := MyCursor;
end;

procedure TPrincipale.MenuItem67Click(Sender: TObject);
var
   MyCursor:Tcursor;
   row:integer;
begin
  // Nettoyage des records orphelins
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ProgressBar.Visible := true;
  // A - recherche de liens sans sources
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[344]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT A.no, A.S, A.D FROM A WHERE NOT EXISTS (SELECT S.no FROM S WHERE A.S = S.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT COUNT(a.no) AS row FROM a WHERE NOT EXISTS (SELECT s.no FROM s WHERE a.S = s.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[346])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[345])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM A WHERE A.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // A - recherche de liens sans depots }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[347]);
  Query1.SQL.Clear;
  // This query does not work, yet it works in MyPHPadmin
  Query1.SQL.ADD('SELECT a.no, a.S, a.D FROM a WHERE NOT EXISTS (SELECT d.no FROM d WHERE a.D=d.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(a.no) as row FROM a WHERE NOT EXISTS (SELECT d.no FROM d WHERE a.D=d.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[348])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[345])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM A WHERE A.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // C - recherche de citations sans type valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[349]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT C.no, C.Y, C.N, C.S FROM C WHERE NOT (C.Y=''E'' OR C.Y=''R'' OR C.Y=''N'')');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(C.no) as row FROM C WHERE NOT (C.Y=''E'' OR C.Y=''R'' OR C.Y=''N'')');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[351])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[350])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM C WHERE C.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // C - recherche de citations sans sources valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[352]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT C.no, C.Y, C.N, C.S FROM C WHERE NOT EXISTS (SELECT S.no FROM S WHERE C.S = S.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(C.no) as row FROM C WHERE NOT EXISTS (SELECT S.no FROM S WHERE C.S = S.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[353])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[350])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM C WHERE C.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // C - recherche de citations sans lien vers l'événement }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[354]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT C.no, C.Y, C.N, C.S FROM C WHERE C.Y=''E'' AND NOT EXISTS (SELECT E.no FROM E WHERE C.N = E.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(C.no) as row FROM C WHERE C.Y=''E'' AND NOT EXISTS (SELECT E.no FROM E WHERE C.N = E.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[355])+Query1.Fields[2].AsString),
        pchar(AnsitoUTF8(Traduction.Items[350])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM C WHERE C.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // C - recherche de citations sans lien vers la relation }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[356]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT C.no, C.Y, C.N, C.S FROM C WHERE C.Y=''R'' AND NOT EXISTS (SELECT R.no FROM R WHERE C.N = R.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(C.no) as row FROM C WHERE C.Y=''R'' AND NOT EXISTS (SELECT R.no FROM R WHERE C.N = R.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[357])+Query1.Fields[2].AsString),
        pchar(AnsitoUTF8(Traduction.Items[350])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM C WHERE C.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // C - recherche de citations sans lien vers le nom
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[358]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT C.no, C.Y, C.N, C.S FROM C WHERE C.Y=''N'' AND NOT EXISTS (SELECT N.no FROM N WHERE C.N = N.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(C.no) as row FROM C WHERE C.Y=''N'' AND NOT EXISTS (SELECT N.no FROM N WHERE C.N = N.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[359])+Query1.Fields[2].AsString),
        pchar(AnsitoUTF8(Traduction.Items[350])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM C WHERE C.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // D - recherche de depot sans individu valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[360]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT D.no, D.I, D.T FROM D WHERE NOT (D.I=0 OR EXISTS (SELECT I.no FROM I WHERE D.I = I.no))');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(D.no) as row FROM D WHERE NOT (D.I=0 OR EXISTS (SELECT I.no FROM I WHERE D.I = I.no))');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Query1.Fields[1].AsInteger<>0 then;
        if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[362])+Query1.Fields[2].AsString),
           pchar(AnsitoUTF8(Traduction.Items[361])),MB_YESNO)=IDYES then
           begin
           Query2.SQL.Clear;
           Query2.SQL.ADD('UPDATE D SET D.I=''0'' WHERE D.no='+Query1.Fields[0].AsString);
           Query2.ExecSQL;
        end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // E - recherche de d'événement sans type valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[363]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT E.no, E.Y, E.L FROM E WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE E.Y = Y.no AND NOT (Y.Y=''N'' OR Y.Y=''R''))');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(E.no) as row FROM E WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE E.Y = Y.no AND NOT (Y.Y=''N'' OR Y.Y=''R''))');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[365])+Query1.Fields[0].AsString),
        pchar(AnsitoUTF8(Traduction.Items[364])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM E WHERE E.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // E - recherche de d'événement sans lieu valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[366]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT E.no, E.Y, E.L FROM E WHERE NOT EXISTS (SELECT L.no FROM L WHERE E.L = L.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(E.no) as row FROM E WHERE NOT EXISTS (SELECT L.no FROM L WHERE E.L = L.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[367])+Query1.Fields[0].AsString),
        pchar(AnsitoUTF8(Traduction.Items[364])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('UPDATE E SET E.L=''0'' WHERE L.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // N - recherche de noms sans type valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[368]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT N.no, N.Y, N.N, N.I FROM N WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE N.Y = Y.no AND Y.Y=''N'')');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(N.no) as row FROM N WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE N.Y = Y.no AND Y.Y=''N'')');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[342])+'"'+
        DecodeName(Query1.Fields[2].AsString,1)+'"'+' ('+Query1.Fields[3].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[341])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM N WHERE N.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // N - recherche de noms sans individus
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[343]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT N.no, N.I, N.N FROM N WHERE NOT EXISTS (SELECT I.no FROM I WHERE N.I = I.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(N.no) as row FROM N WHERE NOT EXISTS (SELECT I.no FROM I WHERE N.I = I.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[342])+'"'+
        DecodeName(Query1.Fields[2].AsString,1)+'"'+' ('+Query1.Fields[1].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[341])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM N WHERE N.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // R - recherche de relations sans type valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[369]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT R.no, R.Y, R.A, R.B FROM R WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE R.Y = Y.no AND Y.Y=''R'')');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(R.no) as row FROM R WHERE NOT EXISTS (SELECT Y.no FROM Y WHERE R.Y = Y.no AND Y.Y=''R'')');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[371])+'"'+
        getName(Query1.Fields[2].AsString)+'"'+' ('+Query1.Fields[2].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[370])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM R WHERE R.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // R - recherche de relations sans parent valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[372]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT R.no, R.Y, R.A, R.B FROM R WHERE NOT EXISTS (SELECT I.no FROM I WHERE R.A = I.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(R.no) as row FROM R WHERE NOT EXISTS (SELECT I.no FROM I WHERE R.A = I.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[373])+'"'+
        getName(Query1.Fields[3].AsString)+'"'+' ('+Query1.Fields[3].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[370])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM R WHERE R.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // R - recherche de relations sans enfant valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[374]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT R.no, R.Y, R.A, R.B FROM R WHERE NOT EXISTS (SELECT I.no FROM I WHERE R.B = I.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(R.no) as row FROM R WHERE NOT EXISTS (SELECT I.no FROM I WHERE R.B = I.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[375])+'"'+
        getName(Query1.Fields[2].AsString)+'"'+' ('+Query1.Fields[2].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[370])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM R WHERE R.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  { TODO : S - recherche de sources sans auteur valide - COMPLEXE }
  // W - recherche de témoins sans individu valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[376]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT W.no, W.I, W.E, W.R FROM W WHERE NOT EXISTS (SELECT I.no FROM I WHERE W.I = I.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(W.no) as row FROM W WHERE NOT EXISTS (SELECT I.no FROM I WHERE W.I = I.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[378])+'"'+
        getName(Query1.Fields[1].AsString)+'"'+' ('+Query1.Fields[1].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[377])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM W WHERE W.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // W - recherche de témoins sans événement valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[379]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT W.no, W.I, W.E, W.R FROM W WHERE NOT EXISTS (SELECT E.no FROM E WHERE W.E = E.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(W.no) as row FROM W WHERE NOT EXISTS (SELECT E.no FROM E WHERE W.E = E.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[380])+'"'+
        getName(Query1.Fields[1].AsString)+'"'+' ('+Query1.Fields[1].AsString+')'),
        pchar(AnsitoUTF8(Traduction.Items[377])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM W WHERE W.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  { TODO : W - recherche de témoins sans rôle valide - COMPLEXE }
  { TODO : X - recherche de documents sans type valide }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[381]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT X.no, X.T, X.A, X.N FROM X WHERE NOT (X.A=''I'' OR X.A=''E'' OR X.A=''S'')');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(X.no) as row FROM X WHERE NOT (X.A=''I'' OR X.A=''E'' OR X.A=''S'')');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[383])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[382])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM X WHERE X.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // X - recherche de documents sans lien valide (Individu) }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[384]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT X.no, X.T, X.A, X.N FROM X WHERE X.A=''I'' AND NOT EXISTS (SELECT I.no FROM I WHERE X.N = I.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(X.no) as row FROM X WHERE X.A=''I'' AND NOT EXISTS (SELECT I.no FROM I WHERE X.N = I.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[385])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[382])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM X WHERE X.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  // X - recherche de documents sans lien valide (Source) }
  Application.ProcessMessages;
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[386]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT X.no, X.T, X.A, X.N FROM X WHERE X.A=''S'' AND NOT EXISTS (SELECT S.no FROM S WHERE X.N = S.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(X.no) as row FROM X WHERE X.A=''S'' AND NOT EXISTS (SELECT S.no FROM S WHERE X.N = S.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[387])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[382])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM X WHERE X.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  Application.ProcessMessages;
  // X - recherche de documents sans lien valide (Événement) }
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[388]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT X.no, X.T, X.A, X.N FROM X WHERE X.A=''E'' AND NOT EXISTS (SELECT E.no FROM E WHERE X.N = E.no)');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(X.no) as row FROM X WHERE X.A=''E'' AND NOT EXISTS (SELECT E.no FROM E WHERE X.N = E.no)');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[389])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[382])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM X WHERE X.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  Application.ProcessMessages;
  // Y - recherche de types sans type valide }
  StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[390]);
  Query1.SQL.Clear;
  Query1.SQL.ADD('SELECT Y.no, Y.T, Y.Y, Y.R, Y.P FROM Y WHERE NOT (Y.Y=''B'' OR Y.Y=''D'' OR Y.Y=''M'' OR Y.Y=''N'' OR Y.Y=''R'' OR Y.Y=''X'' OR Y.Y=''Z'')');
  Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(Y.no) as row FROM Y WHERE NOT (Y.Y=''B'' OR Y.Y=''D'' OR Y.Y=''M'' OR Y.Y=''N'' OR Y.Y=''R'' OR Y.Y=''X'' OR Y.Y=''Z'')');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[392])+Query1.Fields[1].AsString),
        pchar(AnsitoUTF8(Traduction.Items[391])),MB_YESNO)=IDYES then
        begin
        Query2.SQL.Clear;
        Query2.SQL.ADD('DELETE FROM Y WHERE Y.no='+Query1.Fields[0].AsString);
        Query2.ExecSQL;
     end;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
  StatusBar.Panels[1].Text:='';
end;

procedure TPrincipale.MenuItem68Click(Sender: TObject);
var
   MyCursor:Tcursor;
   i1,i2:string;
   row,pos1,pos2:integer;
begin
  // Réparation nom pour tri (I1, I2 + Remove UTF8)
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ProgressBar.Visible := true;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('SELECT no, I, N FROM N');
  Principale.Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(N.no) as row FROM N');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     i1:='';
     i2:='';
     if Copy(Query1.Fields[2].AsString,1,4)='!TMG' then
        begin
        i1:=RemoveUTF8(ExtractDelimited(2,Query1.Fields[2].AsString,['|']));
        i2:=RemoveUTF8(ExtractDelimited(4,Query1.Fields[2].AsString,['|']));
     end
     else
        begin
        Pos1:=AnsiPos('<Nom>',Query1.Fields[2].AsString)+5;
        Pos2:=AnsiPos('</Nom>',Query1.Fields[2].AsString);
        if (Pos1+Pos2)>5 then
           i1:=RemoveUTF8(Copy(Query1.Fields[2].AsString,Pos1,Pos2-Pos1));
        Pos1:=AnsiPos('<Prénom>',Query1.Fields[2].AsString)+9;     // 9 car le 'é' prends 2 position en ANSI
        Pos2:=AnsiPos('</Prénom>',Query1.Fields[2].AsString);
        if (Pos1+Pos2)>9 then
           i2:=RemoveUTF8(Copy(Query1.Fields[2].AsString,Pos1,Pos2-Pos1));
     end;
     i1:=copy(i1,1,50);
     i2:=copy(i2,1,50);
     Principale.Query4.SQL.Clear;
     Principale.Query4.SQL.Add('UPDATE N SET I1='''+
                               (AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i1,'\','\\'),'"','\"'),'''','\'''))+
                               ''', I2='''+
                               (AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(i2,'\','\\'),'"','\"'),'''','\'''))+
                               ''' WHERE no='+Query1.Fields[0].AsSTring);
     Principale.Query4.ExecSQL;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  ProgressBar.Visible:=False;
  if Principale.MenuItem13.Checked then
     begin
     PopulateIndex(StrToInt(FormExplorateur.O.Text));
     TrouveIndividu;
  end;
  Screen.Cursor := MyCursor;
end;

procedure TPrincipale.MenuItem69Click(Sender: TObject);
var
   MyCursor:Tcursor;
   row:integer;
begin
  // RÉPARE LES DATES DE TRI DE RELATIONS
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ProgressBar.Visible := true;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.ADD('SELECT no, I, I3 FROM N WHERE X=1');
  Principale.Query1.Open;
  ProgressBar.Position:=0;
  Query2.SQL.Clear;
  Query2.SQL.add('SELECT count(N.no) as row FROM N WHERE X=1');
  Query2.Open;
  Query2.First;
  row:=Query2.Fields[0].AsInteger+1;
  ProgressBar.Max:=row;
  While not Query1.EOF do
     begin
     Principale.Query4.SQL.Clear;
{     Principale.Query4.SQL.Add('UPDATE R SET SD='''+
                               (AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\'''))+
                               ''' WHERE A='+Query1.Fields[1].AsSTring+' AND (SD=''100000000030000000000'' OR SD='''')');
}     Principale.Query4.SQL.Add('UPDATE R SET SD='''+
                               (AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Query1.Fields[2].AsString,'\','\\'),'"','\"'),'''','\'''))+
                               ''' WHERE A='+Query1.Fields[1].AsSTring);
     Principale.Query4.ExecSQL;
     Query1.Next;
     ProgressBar.Position:=ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
end;


procedure TPrincipale.MenuItem71Click(Sender: TObject);
var
   MyCursor:Tcursor;
   maxint,nowint,generation : string;
begin
  // Populer le champs d'intérêt
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
  Principale.Query1.Open;
  if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[398])),pchar(AnsitoUTF8(Traduction.Items[1])),MB_YESNO)=IDYES then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('UPDATE I SET I=0');
     Principale.Query2.ExecSQL;
  end;
  if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[394])+DecodeName(Principale.Query1.Fields[0].AsString,1)+
                            ' ['+Principale.Individu.Caption+']'),pchar(AnsitoUTF8(Traduction.Items[1])),MB_YESNO)=IDYES then
     begin
     if inputquery(pchar(AnsitoUTF8(Traduction.Items[393]+' '+DecodeName(Principale.Query1.Fields[0].AsString,1)+
                            ' ['+Principale.Individu.Caption+']')),pchar(AnsitoUTF8(Traduction.Items[395])),maxint) then
        begin
        if inputquery(pchar(AnsitoUTF8(Traduction.Items[393]+' '+DecodeName(Principale.Query1.Fields[0].AsString,1)+
                               ' ['+Principale.Individu.Caption+']')),pchar(AnsitoUTF8(Traduction.Items[396])),generation) then
           begin
           MyCursor := Screen.Cursor;
           Screen.Cursor := crHourGlass;
           StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[397]+' 1 '+Traduction.Items[109]+' '+maxint);
           Principale.ProgressBar.Position:=0;
           Principale.ProgressBar.Visible := true;
           if strtoint(generation)<31 then
              Principale.ProgressBar.Max := round(power(2, strtoint(generation)))
           else
              Principale.ProgressBar.Max := 0;
           Ecrit_Interet(Principale.Individu.Caption,strtoint(maxint),strtoint(generation));
           nowint:=maxint;
           while (strtoint(nowint)>1) do
              begin
              Query1.SQL.Clear;
              Query1.SQL.add('SELECT no FROM I WHERE I='+inttostr(9-strtoint(maxint)+strtoint(nowint)));
              Query1.Open;
              Query1.First;
              Query2.SQL.Clear;
              Query2.SQL.add('SELECT count(no) as row FROM I WHERE I='+inttostr(9-strtoint(maxint)+strtoint(nowint)));
              Query2.Open;
              Query2.First;
              ProgressBar.Max:=Query2.Fields[0].AsInteger+1;
              ProgressBar.Position:=0;
              nowint:=inttostr(strtoint(nowint)-1);
              StatusBar.Panels[1].Text:=AnsitoUTF8(Traduction.Items[397]+' '+inttostr(strtoint(maxint)+1-strtoint(nowint))+' '+Traduction.Items[109]+' '+maxint);
              Application.ProcessMessages;
              while not Query1.EOF do
                 begin
                 // pour chaque personnes, mets ses conjoints, enfants et parents à 9-maxint+nowint si <
                 // enfants
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.add('UPDATE i join R on R.A=i.no set I.i='+inttostr(9-strtoint(maxint)+strtoint(nowint))+' WHERE I.i<'+inttostr(9-strtoint(maxint)+strtoint(nowint))+' and R.B='+Query1.Fields[0].AsString);
                 Principale.Query2.ExecSQL;
                 // parents
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.add('UPDATE i join R on R.B=i.no set I.i='+inttostr(9-strtoint(maxint)+strtoint(nowint))+' WHERE I.i<'+inttostr(9-strtoint(maxint)+strtoint(nowint))+' and R.A='+Query1.Fields[0].AsString);
                 Principale.Query2.ExecSQL;
                 // conjoints
                 Principale.Query2.SQL.Clear;
                 Principale.Query2.SQL.add('SELECT w.e from w join e on w.e=e.no join y on e.y=y.no where y.y=''M'' and w.X=1 and w.i='+Query1.Fields[0].AsString);
                 Principale.Query2.Open;
                 while not Query2.EOF do
                    begin
                    Principale.Query3.SQL.Clear;
                    Principale.Query3.SQL.add('UPDATE i join w on w.i=i.no set I.i='+inttostr(9-strtoint(maxint)+strtoint(nowint))+' WHERE I.i<'+inttostr(9-strtoint(maxint)+strtoint(nowint))+' and w.e='+Query2.Fields[0].AsString);
                    Principale.Query3.ExecSQL;
                    Principale.Query2.Next;
                 end;
                 Principale.Query1.Next;
                 ProgressBar.Position:=ProgressBar.Position+1;
              end;
           end;
           Principale.ProgressBar.Visible:= False;
           StatusBar.Panels[1].Text:='';
           Screen.Cursor := MyCursor;
        end;
     end;
  end;
end;

procedure TPrincipale.MenuItem72Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormToDoList.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormToDoList.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.MenuItem73Click(Sender: TObject);
var
  FormTampon1: TFormTampon;
begin
  FormTampon1:= TFormTampon.Create(Application);
  FormTampon1.Show;
end;

procedure TPrincipale.MenuItem76Click(Sender: TObject);
var
   generation, sujet : string;
   gen, oldgen, temp : integer;
   MyCursor : Tcursor;
   rapport : textfile;
begin
  // Exécuter le rapport Sosa-Stradonitz sous forme de liste
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
  Principale.Query1.Open;
  sujet:=DecodeName(Principale.Query1.Fields[0].AsString,1);
  if Application.MessageBox(pchar(AnsitoUTF8(Traduction.Items[394])+sujet+' ['+Principale.Individu.Caption+']'),pchar(AnsitoUTF8(Traduction.Items[1])),MB_YESNO)=IDYES then
     begin
     if inputquery(pchar(AnsitoUTF8(Traduction.Items[405]+' ('+Traduction.Items[406]+') '+DecodeName(Principale.Query1.Fields[0].AsString,1)+
                            ' ['+Principale.Individu.Caption+']')),pchar(AnsitoUTF8(Traduction.Items[396])),generation) then
        begin
        // Initialise curseur et progressbar
        MyCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        Principale.ProgressBar.Position:=0;
        Principale.ProgressBar.Visible := true;
        gen:=min(62, strtoint(generation)-1);
        if gen<31 then
           Principale.ProgressBar.Max := round(power(2, gen))
        else
           Principale.ProgressBar.Max := 0;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('CREATE TABLE t1 ( no MEDIUMINT NOT NULL AUTO_INCREMENT, i MEDIUMINT, s BIGINT, t TEXT, PRIMARY KEY (no)) ENGINE = MyISAM');
        try
           Principale.Query1.ExecSQL;
        except
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.add('TRUNCATE t1');
           Principale.Query1.ExecSQL;
        end;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('CREATE TABLE t2 ( no MEDIUMINT NOT NULL AUTO_INCREMENT, i MEDIUMINT, s BIGINT, t TEXT, PRIMARY KEY (no)) ENGINE = MyISAM');
        try
           Principale.Query1.ExecSQL;
        except
          Principale.Query1.SQL.Clear;
          Principale.Query1.SQL.add('TRUNCATE t2');
          Principale.Query1.ExecSQL;
        end;
        // Créer la liste
        SosaStradonitz(Principale.Individu.Caption,1,1,gen);
        // Remets curseur et progressbar normal
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('DROP TABLE t1');
        Principale.Query1.ExecSQL;
        // Transfère T2 au rapport
        assignfile(rapport,'rapport.html');
        rewrite(rapport);
        writeln(rapport,'<head>');
	writeln(rapport,'<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
        writeln(rapport,'</head>');
        writeln(rapport,'<body>');
        writeln(rapport,'<H1>Ancêtres de '+sujet+'</H1>');
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('SELECT i, s, t FROM t2 ORDER BY s');
        Principale.Query1.Open;
        oldgen:=-1;
        while not Principale.Query1.EOF do
           begin
           temp:=trunc(log2(Principale.Query1.Fields[1].AsFloat+0.1));
           if ((oldgen)<trunc(log2(Principale.Query1.Fields[1].AsFloat+0.1))) then
              begin
              oldgen:=round(log2(Principale.Query1.Fields[1].AsFloat));
              writeln(rapport,'<H2>Génération '+inttostr(oldgen+1)+'</H2>');
           end;
           writeln(rapport,Principale.Query1.Fields[2].AsString);
           Principale.Query1.Next;
        end;
        writeln(rapport,'</body>');
        Closefile(rapport);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('DROP TABLE t2');
        Principale.Query1.ExecSQL;
        Principale.ProgressBar.Visible:= False;
        StatusBar.Panels[1].Text:='';
        Screen.Cursor := MyCursor;
     end;
  end;
end;

procedure TPrincipale.MenuItem77Click(Sender: TObject);
var
  FormExplo2: TFormExplorateur2;
begin
  FormExplo2:= TFormExplorateur2.Create(Application);
  FormExplo2.Show;
end;

procedure TPrincipale.MenuItem78Click(Sender: TObject);
var
   MyCursor : Tcursor;
begin
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Principale.ProgressBar.Max:=7;
  Principale.ProgressBar.Position:=0;
  Principale.ProgressBar.Visible := true;
  StatusBar.Panels[1].Text:='Vide la table de couples';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('TRUNCATE couples_vivants');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  StatusBar.Panels[1].Text:='Ajoute un index pour éviter les doublons';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('ALTER TABLE couples_vivants ADD UNIQUE (CMnn, CFnn)');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  StatusBar.Panels[1].Text:='Ajoute les couples légitimes';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('INSERT IGNORE INTO couples_vivants SELECT ');
  Principale.Query1.SQL.add('sub.X, sub.II, sub.no, sub.NN, n.I, n.no, n.R, sub.PD, sub.I1I1, sub.I2I2, I1, I2, l.L, '''', '''', '''', '''' ');
  Principale.Query1.SQL.add('FROM ( SELECT e.no as nono, e.PD, e.M, e.L, n.R as NN, n.I as II, n.I1 as I1I1, n.I2 as I2I2, e.X, n.no ');
  Principale.Query1.SQL.add('FROM e JOIN w ON e.no=w.E JOIN n on n.I=w.I JOIN i on i.no=n.I JOIN y on e.Y=y.no ');
  Principale.Query1.SQL.add('WHERE i.S=''M'' AND e.X=1 AND w.X=1 AND y.Y=''M'') sub ');
  Principale.Query1.SQL.add('JOIN w on w.e=sub.nono JOIN n on n.I=w.I JOIN i on i.no=n.I JOIN l on sub.L=l.no ');
  Principale.Query1.SQL.add('WHERE w.X=1 AND w.I<>sub.II');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  StatusBar.Panels[1].Text:='Ajoute les couples non-légitimes et parrains/marraines';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('INSERT IGNORE INTO couples_vivants SELECT sub.X, sub.II, sub.no, sub.NN, n.I, n.no, n.R, sub.PD, sub.I1I1, sub.I2I2, I1, I2, '''', '''', '''', '''', '''' ');
  Principale.Query1.SQL.add('FROM ( SELECT r.no as nono, n.R as NN, n.I as II, n.I1 as I1I1, n.I2 as I2I2, r.X, r.SD as PD, r.A, r.B, n.no ');
  Principale.Query1.SQL.add('FROM r JOIN n on n.I=r.B JOIN i on i.no=n.I WHERE i.S=''M'' AND r.X=0) sub ');
  Principale.Query1.SQL.add('JOIN r on r.A=sub.A JOIN n on n.I=r.B JOIN i on i.no=n.I WHERE r.X=0 AND r.B<>sub.B');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
//  StatusBar.Panels[1].Text:='Nettoie le champs CM';
//  Application.ProcessMessages;
//  Principale.Query1.SQL.Clear;
//  Principale.Query1.SQL.add('UPDATE couples_vivants SET CM = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CM,''<Titre>'','' ');
//  Principale.Query1.SQL.add('''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ');
//  Principale.Query1.SQL.add('''),''<Suffixe>'','' ''),''</Suffixe>'','' '')');
//  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
//  StatusBar.Panels[1].Text:='Nettoie le champs CF';
//  Application.ProcessMessages;
//  Principale.Query1.SQL.Clear;
//  Principale.Query1.SQL.add('UPDATE couples_vivants SET CF = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CF,''<Titre>'','' ');
//  Principale.Query1.SQL.add('''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ');
//  Principale.Query1.SQL.add('''),''<Suffixe>'','' ''),''</Suffixe>'','' '')');
//  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  StatusBar.Panels[1].Text:='Nettoie le champs L';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('UPDATE couples_vivants SET L = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(L,''<Article>'','' ');
  Principale.Query1.SQL.add('''),''</Article>'','' ''),''<Détail>'','' ''),''</Détail>'','' ''),''<Ville>'','' ''),''</Ville>'','' ');
  Principale.Query1.SQL.add('''),''<Région>'','' ''),''</Région>'','' ''),''<Province>'','' ''),''</Province>'','' ''),''<Pays>'','' ''),''</Pays>'','' '')');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  StatusBar.Panels[1].Text:='Enlève l''index pour permettre les doublons';
  Application.ProcessMessages;
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('ALTER TABLE couples_vivants DROP INDEX CMnn');
  Principale.Query1.ExecSQL;
  Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
  Principale.ProgressBar.Visible:= False;
  StatusBar.Panels[1].Text:='';
  Screen.Cursor := MyCursor;
end;

procedure TPrincipale.MenuItem79Click(Sender: TObject); // ajouter un acte de baptême
begin
  AjouteBapt.Show;
end;

procedure TPrincipale.MenuItem81Click(Sender: TObject);   // ajouter un acte de mariage
begin
   AjouteMar.Show;
end;

procedure TPrincipale.MenuItem82Click(Sender: TObject);  // ajouter un acte de sépulture
begin
  AjouterSep.Show;
end;

procedure TPrincipale.MenuItem9Click(Sender: TObject);
begin
  If not (Sender as TMenuItem).Checked then
  begin
     FormEvenements.Show;
     (Sender as TMenuItem).checked := true;
  end
  else
  begin
     FormEvenements.Close;
     (Sender as TMenuItem).checked := false;
  end;
end;

procedure TPrincipale.OldClick(Sender: TObject);
begin
   if strtoint((Sender as TMenuItem).Hint)>0 then
      Individu.Caption:=(Sender as TMenuItem).Hint;
end;

procedure TPrincipale.Supprimer_projetClick(Sender: TObject);
var
  db:string;
begin
  db:='';
  if InputQuery(AnsitoUTF8(Traduction.Items[3]),AnsitoUTF8(Traduction.Items[24]),db) then
     begin
     if (Principale.Database.Connected and (AnsiCompareStr(db,Principale.Database.Database)=0)) then
        begin
        Principale.Database.Connected := false;
        Principale.Caption := 'Stemma';
        // Fermer toutes les fenêtres ouvertes
        If MenuItem13.Checked then FormExplorateur.Close;
        If MenuItem8.Checked then FormNoms.Close;
        If MenuItem9.Checked then FormEvenements.Close;
        If MenuItem10.Checked then FormParents.Close;
        If MenuItem11.Checked then FormExhibits.Close;
        If MenuItem14.Checked then FormEnfants.Close;
        If MenuItem15.Checked then FormFratrie.Close;
        If MenuItem16.Checked then FormAncetres.Close;
        If MenuItem23.Checked then FormDescendants.Close;
        If MenuItem26.Checked then FormImage.Close;
        Principale.Individu.Caption:='0';
     end;
     try
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('DROP DATABASE '+db);
        Principale.Query1.ExecSQL;
     except
     end;
  end;
end;

procedure TPrincipale.MenuItem8Click(Sender: TObject);
begin
   If not (Sender as TMenuItem).Checked then
   begin
      FormNoms.Show;
      (Sender as TMenuItem).checked := true;
   end
   else
   begin
      FormNoms.Close;
      (Sender as TMenuItem).checked := false;
   end;
end;

procedure TPrincipale.Ouvrir_projetClick(Sender: TObject);
var
   ini:TIniFile;
   db:string;
   rapport: textfile;
begin
  Ini := TIniFile.Create('Stemma.ini');
  Principale.Database.Connected:=false;
  db:=ini.ReadString('DB','DB','Stemma_data');
  if InputQuery(AnsitoUTF8(Traduction.Items[3]),AnsitoUTF8(Traduction.Items[25]),db) then
     begin
     try
        // Avant d'ouvrir le projet, fermer le project actif
        Principale.Caption := 'Stemma';
        // Fermer toutes les fenêtres ouvertes
        If MenuItem13.Checked then FormExplorateur.Close;
        If MenuItem8.Checked then FormNoms.Close;
        If MenuItem9.Checked then FormEvenements.Close;
        If MenuItem10.Checked then FormParents.Close;
        If MenuItem11.Checked then FormExhibits.Close;
        If MenuItem14.Checked then FormEnfants.Close;
        If MenuItem15.Checked then FormFratrie.Close;
        If MenuItem16.Checked then FormAncetres.Close;
        If MenuItem23.Checked then FormDescendants.Close;
        If MenuItem26.Checked then FormImage.Close;
        Principale.Individu.Caption:='0';
        Principale.Database.Database := db;
        Principale.Database.Connected:= true;
        ini.WriteString('DB','DB',Principale.Database.Database);
{ TODO 12 : Doit vérifier si c'est le bon format... - fonction car utilisée à plus d'un endroi }
        Principale.Caption := 'Stemma - '+Principale.Database.Database;
        Principale.MenuItem7.Enabled:=true;
        Principale.MenuItem17.Enabled:=true;
        Principale.MenuItem27.Enabled:=true;
        Principale.MenuItem32.Enabled:=true;
        Principale.MenuItem61.Enabled:=true;
        Principale.MenuItem62.Enabled:=true;
        if ini.ReadString('DB','DB','Stemma_data')=Principale.Database.Database then
           Individu.Caption:=ini.ReadString('DB','Individu','1')
        else
           GetFirstRecord();
        If Ini.ReadInteger('Fenetre','Explorateur',1)=1 then
           begin
           MenuItem24.Enabled:=true;
           MenuItem25.Enabled:=true;
           MenuItem13Click(Principale.MenuItem13);
        end;
        If Ini.ReadInteger('Fenetre','Noms',1)=1 then MenuItem8Click(Principale.MenuItem8);
        If Ini.ReadInteger('Fenetre','Événements',1)=1 then MenuItem9Click(Principale.MenuItem9);
        If Ini.ReadInteger('Fenetre','Parents',1)=1 then MenuItem10Click(Principale.MenuItem10);
        If Ini.ReadInteger('Fenetre','Exhibits',1)=1 then MenuItem11Click(Principale.MenuItem11);
        If Ini.ReadInteger('Fenetre','Enfants',1)=1 then MenuItem14Click(Principale.MenuItem14);
        If Ini.ReadInteger('Fenetre','Fratrie',1)=1 then MenuItem15Click(Principale.MenuItem15);
        If Ini.ReadInteger('Fenetre','Ancêtres',0)=1 then MenuItem16Click(Principale.MenuItem16);
        If Ini.ReadInteger('Fenetre','Descendants',0)=1 then MenuItem23Click(Principale.MenuItem23);
        If Ini.ReadInteger('Fenetre','Image',0)=1 then MenuItem26Click(Principale.MenuItem26);
     except
        on e:Exception do
        begin
             Showmessage(AnsitoUTF8(Traduction.Items[26]));
             Showmessage(e.Message);
        end;
     end;
  end;
end;


end.

