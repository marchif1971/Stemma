unit Ancetres;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Menus, FMUtils, LCLType;

type

  { TFormAncetres }

  TFormAncetres = class(TForm)
    Arbre: TTreeView;
    MenuItem1: TMenuItem;
    PopupMenuParent: TPopupMenu;
    procedure ArbreDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateAncetres;

var
  FormAncetres: TFormAncetres;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormAncetres }

procedure TFormAncetres.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TFormAncetres.ArbreDblClick(Sender: TObject);
var
  no,naissance,deces:string;
begin
  if not Arbre.Selected.HasChildren then
  begin
    no:=Copy(Arbre.Selected.Text,AnsiPos('[',Arbre.Selected.Text)+1,AnsiPos(']',Arbre.Selected.Text)-AnsiPos('[',Arbre.Selected.Text)-1);
    Principale.Query1.SQL.Clear;
    Principale.Query1.SQL.add('SELECT R.B, N.N, N.I3, N.I4 FROM R JOIN N on R.B=N.I WHERE R.X=1 AND N.X=1 AND R.A='
                              +no);
    Principale.Query1.Open;
    Principale.Query1.First;
    while not Principale.Query1.EOF do
       begin
       if Copy(Principale.Query1.Fields[2].AsString,1,1)='1' then
          naissance:=Copy(Principale.Query1.Fields[2].AsString,2,4)
       else
          naissance:='';
       if Copy(Principale.Query1.Fields[3].AsString,1,1)='1' then
          deces:=Copy(Principale.Query1.Fields[3].AsString,2,4)
       else
          deces:='';
       Arbre.Items.AddChild(Arbre.Selected,DecodeName(Principale.Query1.Fields[1].AsString,1)+
                                                   ' ['+Principale.Query1.Fields[0].AsString+'] ('+
                                                   naissance+'-'+deces+')');
       Principale.Query1.Next;
    end;
  end;
  Arbre.Selected.Expand(true);
end;

procedure TFormAncetres.FormResize(Sender: TObject);
begin
  Arbre.Width:=FormAncetres.Width;
  Arbre.Height:=FormAncetres.Height;
end;

procedure TFormAncetres.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[146]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[222]);
  GetFormPosition(Sender as TForm,0,0,200,200);
  PopulateAncetres;
end;

procedure TFormAncetres.MenuItem1Click(Sender: TObject);
begin
  Principale.Individu.Caption:=Copy(Arbre.Selected.Text,AnsiPos('[',Arbre.Selected.Text)+1,
                                    AnsiPos(']',Arbre.Selected.Text)-AnsiPos('[',Arbre.Selected.Text)-1);
end;

procedure PopulateAncetres;
begin
  Principale.Query1.SQL.clear;
  Principale.Query1.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
  Principale.Query1.open;
  FormAncetres.Arbre.Items.Clear;
  FormAncetres.Arbre.Items.AddFirst(nil,DecodeName(Principale.Query1.Fields[0].AsString,1)+
                                    ' ['+Principale.Individu.Caption+']');
  Principale.Query1.SQL.Clear;
  FormAncetres.Arbre.Selected:=FormAncetres.Arbre.Items[0];
  FormAncetres.ArbreDblClick(nil);
end;

end.

