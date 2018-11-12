unit SelectPersonne;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Menus, FMUtils;

type

  { TFormSelectPersonne }

  TFormSelectPersonne = class(TForm)
    Button2: TButton;
    Button1: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    No: TEdit;
    Nom: TEdit;
    Liste: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure ListeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure MenuItem1Click(Sender: TObject);
    procedure NoEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormSelectPersonne: TFormSelectPersonne;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormSelectPersonne }

procedure TFormSelectPersonne.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[316]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[115]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  No.Text:='0';
  Nom.Text:=AnsitoUTF8(Principale.Traduction.Items[317]);
end;

procedure TFormSelectPersonne.ListeSelection(Sender: TObject; aCol,
  aRow: Integer);
begin
  No.Text:=Liste.Cells[0,aRow];
  Nom.Text:=Liste.Cells[1,aRow];
end;

procedure TFormSelectPersonne.MenuItem1Click(Sender: TObject);
begin
  modalresult:=mrok;
end;

procedure TFormSelectPersonne.NoEditingDone(Sender: TObject);
begin
  Nom.Text:=GetName(No.Text);
end;

end.

