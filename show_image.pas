unit Show_Image;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus;

type

  { TShowImage }

  TShowImage = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image: TImage;
    MainMenu1: TMainMenu;
    Memo: TMemo;
    MenuItem1: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  ShowImage: TShowImage;

implementation

uses
  unit1;

{$R *.lfm}

{ TShowImage }

procedure TShowImage.FormResize(Sender: TObject);
begin
  Image.Width:=ShowImage.Width;
  Image.Height:=ShowImage.Height;
  Memo.Width:=ShowImage.Width-16;
  Memo.Height:=ShowImage.Height-76;
  Button1.Top:=ShowImage.Height-54;
  Button1.Left:=ShowImage.Width-160;
  Button2.Top:=ShowImage.Height-54;
  Button2.Left:=ShowImage.Width-83;
end;

procedure TShowImage.FormShow(Sender: TObject);
begin
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[256]);
  Caption:=AnsitoUTF8(Principale.Traduction.Items[217]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
end;

procedure TShowImage.MenuItem1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;


end.

