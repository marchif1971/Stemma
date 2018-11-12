unit a_propos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, LCLIntf;

type

  { Tapropos }

  Tapropos = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    v: TLabel;
    d: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  apropos: Tapropos;

implementation

uses
  unit1;

{$R *.lfm}

{ Tapropos }

procedure Tapropos.Button1Click(Sender: TObject);
begin
  apropos.close;
end;

procedure Tapropos.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[142]);
  Label2.Caption:=AnsitoUTF8(Principale.Traduction.Items[143]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[144]);
  Label4.Caption:=AnsitoUTF8(Principale.Traduction.Items[145]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[148]);
  v.caption:='0.9.6';
  d.caption:='2012/3/01';
end;

procedure Tapropos.Label5Click(Sender: TObject);
begin
  OpenURL('http://http://sourceforge.net/p/stemma/wiki/Home/');
end;

end.

