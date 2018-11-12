unit Image;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  FMUtils;

type

  { TFormImage }

  TFormImage = class(TForm)
    Im: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateImage(no:integer);

var
  FormImage: TFormImage;

implementation

uses
  unit1, exhibits;

{$R *.lfm}

{ TFormImage }

procedure PopulateImage(no:integer);
begin
  Principale.Query2.SQL.Clear;
  if no=0 then
    Principale.Query2.SQL.add('SELECT X.F FROM X WHERE X.A=''I'' AND X.X=1 AND X.N='+
                               Principale.Individu.Caption)
  else
    Principale.Query2.SQL.add('SELECT X.F FROM X WHERE X.no='+inttostr(no));
  Principale.Query2.Open;
  Principale.Query2.First;
  if not Principale.Query2.EOF then
     begin
     if (length(Principale.Query2.Fields[0].AsString)>0) and
        not (AnsiPos('.PDF',Principale.Query2.Fields[0].AsString)>0) then
       begin
       FormImage.Im.Picture.LoadFromFile(Principale.Query2.Fields[0].AsString);
       if no=0 then
          FormImage.Caption:=AnsitoUTF8(Principale.Traduction.Items[117])
       else
         FormImage.Caption:=AnsitoUTF8(Principale.Traduction.Items[118]);
     end;
  end
  else
     FormImage.Im.Picture.Clear;
end;

procedure TFormImage.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
end;

procedure TFormImage.FormResize(Sender: TObject);
begin
  Im.Width:=FormImage.Width;
  Im.Height:=FormImage.Height;
end;

procedure TFormImage.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[117]);
  GetFormPosition(Sender as TForm,100,100,200,200);
  if Principale.MenuItem11.Checked then
    if FormExhibits.TableauExhibits.Cells[1,FormExhibits.TableauExhibits.Row]='*' then
       PopulateImage(0)
    else
       if FormExhibits.TableauExhibits.RowCount>1 then
          PopulateImage(StrToInt(FormExhibits.TableauExhibits.Cells[0,FormExhibits.TableauExhibits.Row]))
       else
          PopulateImage(0)
  else
     PopulateImage(0);
end;

end.

