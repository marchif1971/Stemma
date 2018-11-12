unit ConnectDb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, INIFiles;

type

  { TConnexionDb }

  TConnexionDb = class(TForm)
    HostName: TEdit;
    usager: TEdit;
    Password: TEdit;
    Ok: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure OkClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  ConnexionDb: TConnexionDb;

implementation

uses
  unit1;

{$R *.lfm}

{ TConnexionDb }

procedure TConnexionDb.FormShow(Sender: TObject);
var
   ini:TIniFile;
begin
     Caption:=AnsitoUTF8(Principale.Traduction.Items[147]);
     Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[149]);
     Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[150]);
     Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[151]);
     Ok.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
     Ini := TIniFile.Create('Stemma.ini');
     HostName.Caption := ini.ReadString('DB','Serveur','localhost');
     Usager.Caption := ini.ReadString('DB','Nom','root');
     Password.Caption := ini.ReadString('DB','Mot de passe','');
     Ini.Free;
end;

procedure TConnexionDb.OkClick(Sender: TObject);
var
   ini:TIniFile;
begin
     Ini := TIniFile.Create('Stemma.ini');
     ini.WriteString('DB','Serveur',HostName.Caption);
     ini.WriteString('DB','Nom',Usager.Caption);
     if (password.caption = '') then
        ini.DeleteKey('DB','Mot de passe')
     else
        ini.WriteString('DB','Mot de passe',Password.Caption);
     Ini.Free;
end;


end.

