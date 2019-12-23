unit Noms;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, ExtCtrls, Spin, Menus, FMUtils, Edit_Nom, LCLType;

type

  { TFormNoms }

  TFormNoms = class(TForm)
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Modifie: TLabel;
    PopupMenuEnfant: TPopupMenu;
    Sexe: TImage;
    Interet: TSpinEdit;
    Vivant: TImage;
    TableauNoms: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InteretChange(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure SexeDblClick(Sender: TObject);
    procedure TableauNomsDblClick(Sender: TObject);
    procedure TableauNomsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure TableauNomsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VivantDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure PopulateNom;

var
  FormNoms: TFormNoms;

implementation

uses
  unit1, explorateur;

{$R *.lfm}

{ TFormNoms }

procedure TFormNoms.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     SaveFormPosition(Sender as TForm);
     SaveGridPosition(TableauNoms as TStringGrid,5);
end;

procedure TFormNoms.FormResize(Sender: TObject);
begin
  TableauNoms.Width := (Sender as Tform).Width-17;
  TableauNoms.Height := (Sender as Tform).Height-41;
  TableauNoms.Columns[3].Width := (Sender as Tform).Width-207;
  Sexe.Top := (Sender as Tform).Height-32;
  Vivant.Top := (Sender as Tform).Height-32;
  Interet.Top := (Sender as Tform).Height-29;
  Label1.Top := (Sender as Tform).Height-25;
  Modifie.Top := (Sender as Tform).Height-25;
end;

procedure PopulateNom;
var
  row:integer;
  filename:string;
  temp:string;
begin
  Principale.Query1.SQL.Clear;
//  Principale.Query1.SQL.add('SELECT no, X, Y, PD, SD, N FROM N WHERE I='+Principale.Individu.Caption+' ORDER BY X DESC, SD, I1, I2');
//  Principale.Query1.SQL.add('SELECT no, X, Y, PD, SD, N FROM N WHERE I='+Principale.Individu.Caption+' ORDER BY X DESC, I1, I2');
  Principale.Query1.SQL.add('SELECT no, X, Y, PD, SD, N FROM N WHERE I='+Principale.Individu.Caption+' ORDER BY I1, I2');
  Principale.Query1.Open;
  Principale.Query1.First;
  row:=1;
  FormNoms.TableauNoms.RowCount:=Principale.Query1.RecordCount+1;
  While not Principale.Query1.EOF do
  begin
     FormNoms.TableauNoms.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     if Principale.Query1.Fields[1].AsBoolean then
        begin
        FormNoms.TableauNoms.Cells[1,row]:='*';
        Principale.Caption := 'Stemma - '+Principale.Database.Database+' - '+
                              (DecodeName(Principale.Query1.Fields[5].AsString,1))+
                              ' ['+Principale.Individu.Caption+']';
     end
     else
        FormNoms.TableauNoms.Cells[1,row]:='';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT T FROM Y WHERE no='+Principale.Query1.Fields[2].AsString);
     Principale.Query2.Open;
     FormNoms.TableauNoms.Cells[2,row]:=Principale.Query2.Fields[0].AsString;
     // Convertit la Modifie
     FormNoms.TableauNoms.Cells[3,row]:=ConvertDate(Principale.Query1.Fields[3].AsString,1);
     FormNoms.TableauNoms.Cells[4,row]:=DecodeName(Principale.Query1.Fields[5].AsString,1);
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT Q FROM C WHERE Y=''N'' AND N='+FormNoms.TableauNoms.Cells[0,row]+' ORDER BY Q DESC');
     Principale.Query2.Open;
     FormNoms.TableauNoms.Cells[5,row]:=Principale.Query2.Fields[0].AsString;
     Principale.Query1.Next;
     row:=row+1;
  end;
  Principale.Query2.SQL.Clear;
  Principale.Query2.SQL.add('SELECT S, V, I, date, no FROM I WHERE no='+Principale.Individu.Caption);
  Principale.Query2.Open;
  temp:=Principale.Query2.Fields[0].AsString;
  FormNoms.Sexe.Hint:=Principale.Query2.Fields[0].AsString;
  If Principale.Query2.Fields[0].AsString='M' then
     filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico'
  else
     If Principale.Query2.Fields[0].AsString='F' then
        filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico'
     else
        filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
  FormNoms.sexe.Picture.Icon.LoadFromFile(filename);
  temp:=Principale.Query2.Fields[1].AsString;
  FormNoms.Vivant.Hint:=Principale.Query2.Fields[1].AsString;
  If Principale.Query2.Fields[1].AsString='O' then
     filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\vivant.ico';
  If Principale.Query2.Fields[1].AsString='N' then
     filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\mort.ico';
  If Principale.Query2.Fields[1].AsString='?' then
     filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
  FormNoms.Vivant.Picture.Icon.LoadFromFile(filename);
  FormNoms.Interet.Value := Principale.Query2.Fields[2].AsInteger;
  FormNoms.Modifie.Caption:=ConvertDate('1'+Principale.Query2.Fields[3].AsString+'030000000000',1);
  FormNoms.Caption:=AnsitoUTF8(Principale.Traduction.Items[126])+' ('+IntToStr(FormNoms.TableauNoms.RowCount-1)+
     AnsitoUTF8(Principale.Traduction.Items[127]);
end;

procedure TFormNoms.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[214]);
  TableauNoms.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauNoms.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[136]);
  TableauNoms.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[176]);
  TableauNoms.Cells[5,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  Label1.Caption:=AnsitoUTF8(Principale.Traduction.Items[215]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(TableauNoms as TStringGrid,5);
  PopulateNom;
end;

procedure TFormNoms.InteretChange(Sender: TObject);
begin
  // Enregistrer la modification
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('UPDATE I SET I='+InttoStr(Interet.Value)+' WHERE no='+
                            Principale.Individu.Caption);
  Principale.Query1.ExecSQL;
  SaveModificationTime(Principale.Individu.Caption);
end;

procedure TFormNoms.MenuItem1Click(Sender: TObject);
var
  n,j:integer;
  temp:string;
begin
     If TableauNoms.Cells[1,TableauNoms.row]='*' then
        ShowMessage(AnsitoUTF8(Principale.Traduction.Items[128]))
     else
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT no FROM N WHERE N.X=1 AND N.I='+
                                  Principale.Individu.Caption);
        Principale.Query1.Open;
        temp:=Principale.Query1.Fields[0].AsString;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE N SET X=0 WHERE N.no='+temp);
        Principale.Query1.ExecSQL;
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('UPDATE N SET X=1 WHERE N.no='+
                                  TableauNoms.Cells[0,TableauNoms.row]);
        Principale.Query1.ExecSQL;
        // Modifie la date de modification
        // Modifie l'explorateur si affiché
{        if Principale.MenuItem13.Checked then
           begin
           n:=0;
           for j:=1 to FormExplorateur.Index.RowCount do
              begin
              if FormExplorateur.Index.Cells[0,j]=TableauNoms.Cells[0,TableauNoms.row] then
                 begin
                 FormExplorateur.Index.Cells[5,j]:='*';
                 n:=n+1;
              end;
              if FormExplorateur.Index.Cells[0,j]=temp then
                 begin
                 FormExplorateur.Index.Cells[5,j]:='';
                 n:=n+1;
              end;
              if n=2 then break;
           end;
        end;}
        //FormExplorateur.Index.Repaint;
        SaveModificationTime(Principale.Individu.Caption);
//        TrouveIndividu;
     end;
end;

procedure TFormNoms.MenuItem3Click(Sender: TObject);  // Ajouter
begin
     PutCode('A','0');
     if EditNom.Showmodal = mrOK then
        begin
        PopulateNom;
     end;
end;

procedure TFormNoms.MenuItem5Click(Sender: TObject);  // Supprimer
var
  j:integer;
begin
  if TableauNoms.Row>0 then
     if TableauNoms.Cells[1,TableauNoms.Row]='' then
        if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[129])+
           TableauNoms.Cells[4,TableauNoms.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
           begin
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM C WHERE Y=''N'' AND N='+TableauNoms.Cells[0,TableauNoms.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM N WHERE no='+TableauNoms.Cells[0,TableauNoms.Row]);
           Principale.Query1.ExecSQL;
{           if Principale.MenuItem13.Checked then
              for j:=1 to FormExplorateur.Index.RowCount-1 do
                  begin
                  if FormExplorateur.Index.Cells[0,j]=TableauNoms.Cells[0,TableauNoms.Row] then
                     begin
                     FormExplorateur.Index.DeleteRow(j);
                     break;
                  end;
                  Application.ProcessMessages;
              end;}
           TableauNoms.DeleteRow(TableauNoms.Row);
           SaveModificationTime(Principale.Individu.Text);
        end;
end;

procedure TFormNoms.SexeDblClick(Sender: TObject);
var
  filename:string;
begin
  Case Sexe.Hint[1] of
     'M':begin
         Sexe.Hint:='F';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\feminin.ico';
         end;
     'F':begin
         Sexe.Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     '?':begin
         Sexe.Hint:='M';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\masculin.ico';
         end;
  end;
  FormNoms.sexe.Picture.Icon.LoadFromFile(filename);
  // Enregistrer la modification
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('UPDATE I SET S='''+Sexe.Hint+''' WHERE no='+
                            Principale.Individu.Caption);
  Principale.Query1.ExecSQL;
  SaveModificationTime(Principale.Individu.Caption);
end;

procedure TFormNoms.TableauNomsDblClick(Sender: TObject);
begin
  If TableauNoms.Row>0 then
     If EditNom.Showmodal=mrOK then
        PopulateNom;
end;

procedure TFormNoms.TableauNomsDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if aCol=0 then
     begin
     (Sender as TStringGrid).Canvas.Font.Color := (Sender as TStringGrid).Canvas.Brush.Color;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left,aRect.Top,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
  if (((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol>0)) then
     begin
//     if (Sender as TStringGrid).Row=aRow then
//        (Sender as TStringGrid).Canvas.Brush.Color := clBlue
//     else
//        (Sender as TStringGrid).Canvas.Brush.Color := clYellow;
//     (Sender as TStringGrid).Canvas.FillRect(aRect);
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormNoms.TableauNomsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   startCol, StartRow : Longint;
begin
  if Button=mbLeft then
     begin
     TableauNoms.MouseToCell(x,y,startCol,StartRow);
     if StartRow>0 then
        begin
        TableauNoms.Row:=StartRow;
        Principale.DragList.Caption:='';
        Principale.DragName.Caption:=TableauNoms.Cells[0,StartRow];
     end;
  end;
end;

procedure TFormNoms.VivantDblClick(Sender: TObject);
var
  filename:string;
begin
  Case Vivant.Hint[1] of
     'O':begin
         Vivant.Hint:='N';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\mort.ico';
         end;
     'N':begin
         Vivant.Hint:='?';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\inconnu.ico';
         end;
     '?':begin
         Vivant.Hint:='O';
         filename:=ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'\icons\vivant.ico';
         end;
  end;
  FormNoms.Vivant.Picture.Icon.LoadFromFile(filename);
  // Enregistrer la modification
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.Add('UPDATE I SET V='''+Vivant.Hint+''' WHERE no='+
                            Principale.Individu.Caption);
  Principale.Query1.ExecSQL;
  SaveModificationTime(Principale.Individu.Caption);
end;

end.

