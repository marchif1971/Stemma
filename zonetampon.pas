unit ZoneTampon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  StdCtrls, FMutils, Types;

type

  { TFormTampon }

  TFormTampon = class(TForm)
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Tampon: TStringGrid;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure TamponAfterSelection(Sender: TObject; aCol, aRow: Integer);
    procedure TamponDblClick(Sender: TObject);
    procedure TamponDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TamponDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TamponDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private

  public

  end;

var
  FormTampon: TFormTampon;

implementation

uses
  unit1;


{$R *.lfm}

{ TFormTampon }

procedure TFormTampon.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(Tampon as TStringGrid,4);
//  Tampon.SaveToCSVFile('Tampon.data','|',false,false);
//  Tampon.SaveToFile('Tampon.data');
  CloseAction:= caFree;
end;


procedure TFormTampon.FormResize(Sender: TObject);
begin
  Tampon.Height:=Height-16;
  Tampon.Width:=Width-16;
  Tampon.Columns[1].Width := Width-156;
end;

procedure TFormTampon.FormShow(Sender: TObject);
begin
//  FormTampon.Tampon.RowCount:=1;
  Tampon.SaveOptions:=[soPosition,soAttributes,soContent];
  Caption:=AnsitoUTF8(Principale.Traduction.Items[402]);
  Tampon.Cells[1,0]:='#';
  Tampon.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[176]);
  Tampon.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[203]);
  Tampon.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[204]);
  GetFormPosition(Sender as TForm,100,100,70,70);
  GetGridPosition(Tampon as TStringGrid,4);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[403]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[412]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[413]);
  MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[414]);
end;

procedure TFormTampon.MenuItem3Click(Sender: TObject);
var
  temp:string;
  fichiertampon : textfile;
begin
  // Load from file
  OpenDialog.FileName:='';
  OpenDialog.InitialDir:='';
  OpenDialog.Options:=[ofFileMustExist,ofEnableSizing,ofViewDetail];
  if OpenDialog.Execute then
     MenuItem5.Enabled:=true;
     Caption:=AnsitoUTF8(Principale.Traduction.Items[402])+' - '+extractfilename(OpenDialog.FileName);
     begin
     //need to save all name ID one by line, LOADFROMFILE and LOADFROMCSVFILE does not work
        assignfile(fichiertampon,OpenDialog.Filename);
     reset(fichiertampon);
     while not eof(fichiertampon) do
     begin
        Tampon.Rowcount:=Tampon.Rowcount+1;
        Readln(fichiertampon,temp);
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+temp);
        Principale.Query1.Open;
        Principale.Query1.First;
        Tampon.Cells[0,Tampon.Rowcount-1]:=Principale.Query1.Fields[0].AsString;
        Tampon.Cells[1,Tampon.Rowcount-1]:=Principale.Query1.Fields[1].AsString;
        Tampon.Cells[2,Tampon.Rowcount-1]:=DecodeName(Principale.Query1.Fields[2].AsString,2);
        Tampon.Cells[3,Tampon.Rowcount-1]:=ConvertDate(Principale.Query1.Fields[5].AsString,1);
        Tampon.Cells[4,Tampon.Rowcount-1]:=ConvertDate(Principale.Query1.Fields[6].AsString,1);
        if Principale.Query1.Fields[7].AsBoolean then
           begin
           if (Principale.Query1.Fields[8].AsString='9') then
              Tampon.Cells[5,Tampon.Rowcount-1]:='9*'
           else
              Tampon.Cells[5,Tampon.Rowcount-1]:='*'
           end
        else
           begin
              if (Principale.Query1.Fields[8].AsString='9') then
                 Tampon.Cells[5,Tampon.Rowcount-1]:='9'
              else
                 Tampon.Cells[5,Tampon.Rowcount-1]:='';
        end;
        Tampon.Cells[6,Tampon.Rowcount-1]:=RemoveUTF8(Principale.Query1.Fields[3].AsString)+', '+RemoveUTF8(Principale.Query1.Fields[4].AsString);
     end;
     Closefile(fichiertampon);
  end;
end;

procedure TFormTampon.MenuItem5Click(Sender: TObject);
var
  i : integer;
  fichiertampon : textfile;
begin
  // Save
  //need to save all name ID one by line, LOADFROMFILE and LOADFROMCSVFILE does not work
  assignfile(fichiertampon,Opendialog.Filename);
  rewrite(fichiertampon);
  for i := 2 to Tampon.RowCount do
      begin
      writeln(fichiertampon,Tampon.Cells[0,i-1]);
  end;
  Closefile(fichiertampon);
end;

procedure TFormTampon.MenuItem6Click(Sender: TObject);
var
  i:integer;
  fichiertampon : textfile;
begin
  SaveDialog.FileName:='';
  SaveDialog.InitialDir:='';
  SaveDialog.Options:=[ofEnableSizing,ofViewDetail];
  if SaveDialog.Execute then
     //need to save all name ID one by line, LOADFROMFILE and LOADFROMCSVFILE does not work
     begin
     OpenDialog.FileName:=SaveDialog.FileName;
     Caption:=AnsitoUTF8(Principale.Traduction.Items[402])+' - '+extractfilename(OpenDialog.FileName);
     MenuItem5.Enabled:=true;
     assignfile(fichiertampon,SaveDialog.Filename);
     rewrite(fichiertampon);
     for i := 2 to Tampon.RowCount do
         begin
         writeln(fichiertampon,Tampon.Cells[0,i-1]);
     end;
     Closefile(fichiertampon);
  end;
end;

procedure TFormTampon.TamponAfterSelection(Sender: TObject; aCol, aRow: Integer
  );
var
  i : integer;
begin
   principale.DragValue.Caption:='0';
   principale.DragList.Caption:='';
   if (Tampon.Selection.Top = Tampon.Selection.Bottom) then
      begin
      if Tampon.Row>0 then
         begin
         Principale.DragValue.Caption:=Tampon.Cells[1,Tampon.Row];
         Principale.DragName.Caption:=Tampon.Cells[0,Tampon.Row];
      end;
   end
   else
      for i:=Tampon.Selection.Top to Tampon.Selection.Bottom do
          if i>0 then
             Principale.DragList.Caption:=Principale.DragList.Caption+Tampon.Cells[1,i]+',';
end;

procedure TFormTampon.TamponDblClick(Sender: TObject);
begin
  If Tampon.Row>0 then
     Principale.Individu.Caption:=Tampon.Cells[1,Tampon.Row];
end;

procedure TFormTampon.TamponDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  startCol, startRow    : LongInt;
  row:integer;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I FROM N join I on N.I=I.no WHERE N.no='+Principale.DragName.Caption);
  Principale.Query1.Open;
  Principale.Query1.First;
  // insère au bon endroit (en bas du relâche du drag)
  Tampon.MouseToCell(x,y,startCol,StartRow);
  Tampon.RowCount:=Tampon.RowCount+1;
  for row:=Tampon.RowCount-1 downto StartRow+1 do
      begin
      Tampon.Cells[0,row]:=Tampon.Cells[0,row-1];
      Tampon.Cells[1,row]:=Tampon.Cells[1,row-1];
      Tampon.Cells[2,row]:=Tampon.Cells[2,row-1];
      Tampon.Cells[3,row]:=Tampon.Cells[3,row-1];
      Tampon.Cells[4,row]:=Tampon.Cells[4,row-1];
      Tampon.Cells[5,row]:=Tampon.Cells[5,row-1];
      Tampon.Cells[6,row]:=Tampon.Cells[6,row-1];
  end;
  Tampon.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
  Tampon.Cells[1,row]:=Principale.Query1.Fields[1].AsString;
  Tampon.Cells[2,row]:=DecodeName(Principale.Query1.Fields[2].AsString,2);
  Tampon.Cells[3,row]:=ConvertDate(Principale.Query1.Fields[5].AsString,1);
  Tampon.Cells[4,row]:=ConvertDate(Principale.Query1.Fields[6].AsString,1);
  if Principale.Query1.Fields[7].AsBoolean then
     begin
     if (Principale.Query1.Fields[8].AsString='9') then
        Tampon.Cells[5,row]:='9*'
     else
        Tampon.Cells[5,row]:='*'
     end
  else
     begin
        if (Principale.Query1.Fields[8].AsString='9') then
           Tampon.Cells[5,row]:='9'
        else
           Tampon.Cells[5,row]:='';
  end;
  Tampon.Cells[6,row]:=RemoveUTF8(Principale.Query1.Fields[3].AsString)+', '+RemoveUTF8(Principale.Query1.Fields[4].AsString);
  Principale.DragValue.Caption:='0';
  Principale.DragName.Caption:='0';
end;

procedure TFormTampon.TamponDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragName.Caption)>0);
end;

procedure TFormTampon.TamponDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if ((Sender as TStringGrid).Cells[5,aRow]='*') and (aCol=2) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
  if ((Sender as TStringGrid).Cells[5,aRow]='9') and (aCol=2) then
     begin
     (Sender as TStringGrid).Canvas.Font.Color := clMaroon;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
  if ((Sender as TStringGrid).Cells[5,aRow]='9*') and (aCol=2) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.Font.Color := clMaroon;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormTampon.MenuItem1Click(Sender: TObject);
var
  j,k : integer;
begin
  // Retirer la sélection du tableau
  for j:=Tampon.Row to Tampon.RowCount-2 do
      for k:=0 to 6 do
          Tampon.Cells[k,j]:=Tampon.Cells[k,j+1];
  Tampon.RowCount:=Tampon.Rowcount-1;
end;

procedure TFormTampon.MenuItem2Click(Sender: TObject);
begin
  Tampon.Row:=0;
  Tampon.RowCount:=1;
end;


end.

