unit ToDoList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FMUtils;

type

  { TFormToDoList }

  TFormToDoList = class(TForm)
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormToDoList: TFormToDoList;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormToDoList }

procedure TFormToDoList.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
  Memo1.Lines.SaveToFile('ToDoList.data');
end;

procedure TFormToDoList.FormDeactivate(Sender: TObject);
begin
  Memo1.Lines.SaveToFile('ToDoList.data');
end;

procedure TFormToDoList.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[400]);
  GetFormPosition(Sender as TForm,100,100,70,70);
  // Load ToDoList.data file into Memo1
  Memo1.Lines.LoadFromFile('ToDoList.data');
end;


end.

