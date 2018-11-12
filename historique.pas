unit Historique;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, FMUtils;

type

  { TFormHistorique }

  TFormHistorique = class(TForm)
    ListeHistorique: TListBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormHistorique: TFormHistorique;

implementation

uses
  Unit1;

{$R *.lfm}

{ TFormHistorique }

procedure TFormHistorique.FormResize(Sender: TObject);
begin
  ListeHistorique.Width:=FormHistorique.Width;
  ListeHistorique.Height:=FormHistorique.Height;
end;

procedure TFormHistorique.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TFormHistorique.FormDblClick(Sender: TObject);
var
  no:string;
begin
  no:=ListeHistorique.Items[ListeHistorique.ItemIndex];
  no:=Copy(no,1,AnsiPos(')',no)-1);
  Principale.Individu.Caption:=Copy(no,AnsiPos('(',no)+1,Length(no));
  FormHistorique.Close;
  FormHistorique.ModalResult:=mrOk;
end;

procedure TFormHistorique.FormKeyPress(Sender: TObject; var Key: char);
begin
   If (Key=chr(27)) then
      begin
      FormHistorique.Close;
      FormHistorique.ModalResult:=mrAbort;
   end;
end;

procedure TFormHistorique.FormShow(Sender: TObject);
var
  i:integer;
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[206]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  ListeHistorique.Items:=Principale.OldIndividu.Items;
  for i:=0 to ListeHistorique.Count-1 do
    begin
    Principale.Query1.SQL.Clear;
    Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+ListeHistorique.Items[i]);
    Principale.Query1.Open;
    ListeHistorique.Items[i] := (DecodeName(Principale.Query1.Fields[0].AsString,1))+
                                ' ('+ListeHistorique.Items[i]+')';
  end;
end;

end.

