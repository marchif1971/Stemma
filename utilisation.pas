unit Utilisation;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, FMUtils;

type

  { TFormUtilisation }

  TFormUtilisation = class(TForm)
    Button1: TButton;
    TableauUtilisation: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TableauUtilisationDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormUtilisation: TFormUtilisation;

implementation

uses Lieux, Sources, unit1, depots, edit_source, unitTypes;

{ TFormUtilisation }

procedure TFormUtilisation.FormResize(Sender: TObject);
begin
  TableauUtilisation.Width := (Sender as Tform).Width-16;
  TableauUtilisation.Height := (Sender as Tform).Height-51;
  Button1.Top:= (Sender as Tform).Height-35;
  Button1.Left:= (Sender as Tform).Width-80;
end;

procedure TFormUtilisation.FormShow(Sender: TObject);
var
  i:integer;
  temp, code, nocode:string;
  auteur:boolean;
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[158]);
  TableauUtilisation.Columns[0].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[134]);
  TableauUtilisation.Columns[1].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[135]);
  TableauUtilisation.Columns[2].Title.Caption:='#';
  TableauUtilisation.Columns[3].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[136]);
  TableauUtilisation.ColWidths[1]:=75;
  TableauUtilisation.ColWidths[2]:=183;
  TableauUtilisation.ColWidths[3]:=64;
  TableauUtilisation.ColWidths[4]:=75;
  GetCode(code,nocode);
  if code='L' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT E.no, Y.T, N.N, W.I, E.PD FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no JOIN N on W.I=N.I WHERE N.X=1 AND E.L='+
        FormLieux.TableauLieux.Cells[0,FormLieux.TableauLieux.Row]);
     Principale.Query1.Open;
     i:=1;
     TableauUtilisation.RowCount:=Principale.Query1.RecordCount+1;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
  end;
  if code='D' then
     begin
     TableauUtilisation.Columns[0].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[137]);
     TableauUtilisation.Columns[1].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[138]);
     TableauUtilisation.Columns[2].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[139]);
     TableauUtilisation.Columns[3].Title.Caption:=AnsitoUTF8(Principale.Traduction.Items[140]);
     TableauUtilisation.ColWidths[1]:=64;
     TableauUtilisation.ColWidths[2]:=134;
     TableauUtilisation.ColWidths[3]:=64;
     TableauUtilisation.ColWidths[4]:=135;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT A.S, S.T, S.M, S.A FROM A JOIN S on A.S=S.no WHERE A.D='+nocode);
     Principale.Query1.Open;
     i:=1;
     TableauUtilisation.RowCount:=Principale.Query1.RecordCount+1;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[2,i]:=Principale.Query1.Fields[1].AsString;
        temp:=Principale.Query1.Fields[3].AsString;
        auteur:=false;
        if (length(temp)>0) then
           if (temp[1] in ['0'..'9']) then
              auteur:=(StrtoInt(temp)>0);
        if auteur then
           begin
           TableauUtilisation.Cells[3,i]:=temp;
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+temp);
           Principale.Query2.Open;
           TableauUtilisation.Cells[4,i]:=DecodeName(Principale.Query2.Fields[0].AsString,1);
        end
        else
           begin
           TableauUtilisation.Cells[3,i]:='';
           TableauUtilisation.Cells[4,i]:=temp;
        end;
        i:=i+1;
        Principale.Query1.Next;
     end;
  end;
  if code='S' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT E.no, Y.T, N.N, W.I, E.PD FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no JOIN N on W.I=N.I JOIN C on C.N=E.no WHERE C.Y=''E'' AND N.X=1 AND C.S='+
        FormSources.TableauSources.Cells[1,FormSources.TableauSources.Row]);
     Principale.Query1.Open;
     i:=1;
     TableauUtilisation.RowCount:=Principale.Query1.RecordCount+1;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT R.no, Y.T, N.N, R.A, R.SD FROM R JOIN Y on R.Y=Y.no JOIN N on R.A=N.I JOIN C on C.N=R.no WHERE C.Y=''R'' AND N.X=1 AND C.S='+
        FormSources.TableauSources.Cells[1,FormSources.TableauSources.Row]);
     Principale.Query1.Open;
     TableauUtilisation.RowCount:=TableauUtilisation.RowCount+Principale.Query1.RecordCount;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT N.no, Y.T, N.N, N.I, N.PD FROM N JOIN Y on N.Y=Y.no JOIN C on C.N=N.no WHERE C.Y=''N'' AND N.X=1 AND C.S='+
        FormSources.TableauSources.Cells[1,FormSources.TableauSources.Row]);
     Principale.Query1.Open;
     TableauUtilisation.RowCount:=TableauUtilisation.RowCount+Principale.Query1.RecordCount;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
  end;
  if code='T' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT E.no, Y.T, N.N, W.I, E.PD FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no JOIN N on W.I=N.I WHERE N.X=1 AND E.Y='+
        FormTypes.TableauTypes.Cells[1,FormTypes.TableauTypes.Row]);
     Principale.Query1.Open;
     i:=1;
     TableauUtilisation.RowCount:=Principale.Query1.RecordCount+1;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT R.no, Y.T, N.N, R.A, R.SD FROM R JOIN Y on R.Y=Y.no JOIN N on R.A=N.I JOIN C on C.N=R.no WHERE C.Y=''R'' AND N.X=1 AND R.Y='+
        FormTypes.TableauTypes.Cells[1,FormTypes.TableauTypes.Row]);
     Principale.Query1.Open;
     TableauUtilisation.RowCount:=TableauUtilisation.RowCount+Principale.Query1.RecordCount;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT N.no, Y.T, N.N, N.I, N.PD FROM N JOIN Y on N.Y=Y.no JOIN C on C.N=N.no WHERE C.Y=''N'' AND N.X=1 AND N.Y='+
        FormTypes.TableauTypes.Cells[1,FormTypes.TableauTypes.Row]);
     Principale.Query1.Open;
     TableauUtilisation.RowCount:=TableauUtilisation.RowCount+Principale.Query1.RecordCount;
     while not Principale.Query1.EOF do
        begin
        TableauUtilisation.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        TableauUtilisation.Cells[1,i]:=Principale.Query1.Fields[1].AsString;
        TableauUtilisation.Cells[2,i]:=DecodeName(Principale.Query1.Fields[2].AsString,1);
        TableauUtilisation.Cells[3,i]:=Principale.Query1.Fields[3].AsString;
        TableauUtilisation.Cells[4,i]:=ConvertDate(Principale.Query1.Fields[4].AsString,1);
        i:=i+1;
        Principale.Query1.Next;
     end;
  end;
end;

procedure TFormUtilisation.TableauUtilisationDblClick(Sender: TObject);
var
  code,nocode:string;
begin
  if tableauUtilisation.Row>0 then
     begin
     GetCode(Code,nocode);
     if code='D' then
        EditSource.showmodal
     else
        Principale.Individu.Text:=TableauUtilisation.Cells[3,TableauUtilisation.Row];
  end;
end;

{$R *.lfm}

end.

