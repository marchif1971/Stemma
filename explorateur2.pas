unit Explorateur2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, DBGrids, ZDataset, FMUtils;

type

  { TFormExplorateur2 }

  TFormExplorateur2 = class(TForm)
    O: TEdit;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    Query1: TZQuery;
    Query2: TZQuery;
    Recherche: TEdit;
    IndexGrid: TStringGrid;
    RechercheF: TEdit;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IndexGridDblClick(Sender: TObject);
    procedure IndexGridDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure IndexGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure RechercheChange(Sender: TObject);
    procedure RechercheDblClick(Sender: TObject);
    procedure RechercheKeyPress(Sender: TObject; var Key: char);
  private
   { private declarations }
  public
    { public declarations }
  end; 


var
  FormExplorateur2: TFormExplorateur2;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormExplorateur2 }

procedure TFormExplorateur2.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
     SaveFormPosition(Sender as TForm);
     SaveGridPosition(IndexGrid as TStringGrid,4);
end;

procedure TFormExplorateur2.FormResize(Sender: TObject);
begin
     IndexGrid.Height:=Height-69;
     IndexGrid.Width:=Width-16;
     Recherche.Width:=Width-16;
     Recherche.Top:=Height-54;
     RechercheF.Width:=Width-16;
     RechercheF.Top:=Height-27;
     IndexGrid.Columns[1].Width := Width-156;
end;

procedure TFormExplorateur2.FormShow(Sender: TObject);
begin
     Caption:=AnsitoUTF8(Principale.Traduction.Items[408]);
     IndexGrid.Cells[1,0]:='#';
     IndexGrid.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[176]);
     IndexGrid.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[203]);
     IndexGrid.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[204]);
     MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[235]);
     MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[236]);
     MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[237]);
     MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[238]);
     GetFormPosition(Sender as TForm,60,70,200,200);
     GetGridPosition(IndexGrid as TStringGrid,4);
//     PopulateIndex2;
//     TrouveIndividu2;
     IndexGrid.RowCount:=1;
end;

procedure TFormExplorateur2.IndexGridDblClick(Sender: TObject);
begin
  If IndexGrid.Row>0 then
     Principale.Individu.Caption:=IndexGrid.Cells[1,IndexGrid.Row];
end;

procedure TFormExplorateur2.IndexGridDrawCell(Sender: TObject; aCol, aRow: Integer;
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
     if ((Sender as TStringGrid).Cells[5,aRow]='!') and (aCol=2) then
        begin
        (Sender as TStringGrid).Canvas.Font.Italic := true;
        (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
     end;
     if ((Sender as TStringGrid).Cells[5,aRow]='*!') and (aCol=2) then
        begin
        (Sender as TStringGrid).Canvas.Font.Italic := true;
        (Sender as TStringGrid).Canvas.Font.Bold := true;
        (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
     end;
     if ((Sender as TStringGrid).Cells[5,aRow]='9!') and (aCol=2) then
        begin
        (Sender as TStringGrid).Canvas.Font.Italic := true;
        (Sender as TStringGrid).Canvas.Font.Color := clMaroon;
        (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
     end;
     if ((Sender as TStringGrid).Cells[5,aRow]='9*!') and (aCol=2) then
        begin
        (Sender as TStringGrid).Canvas.Font.Italic := true;
        (Sender as TStringGrid).Canvas.Font.Bold := true;
        (Sender as TStringGrid).Canvas.Font.Color := clMaroon;
        (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
     end;
end;

procedure TFormExplorateur2.IndexGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  startCol, startRow    : LongInt;
begin
   if Button=mbLeft then
      begin
      IndexGrid.MouseToCell(x,y,startCol,StartRow);
      if StartRow>0 then
         begin
         IndexGrid.Row:=StartRow;
         Principale.DragValue.Caption:=IndexGrid.Cells[1,StartRow];
         Principale.DragName.Caption:=IndexGrid.Cells[0,StartRow];
      end;
   end;
end;

procedure TFormExplorateur2.MenuItem3Click(Sender: TObject);
var
  Key : char;
begin
   Key:=chr(13);
   O.text:='1';           // Tri par prénom
   recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur2.MenuItem4Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(2);     Tri par nom
    Key:=chr(13);
    O.text:='2';
    recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur2.MenuItem5Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(3);     Tri par naissance
    O.text:='3';
    Key:=chr(13);
    recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur2.MenuItem6Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(4);     Tri par décès
    O.text:='4';
    Key:=chr(13);
    recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur2.RechercheChange(Sender: TObject);
var
  i:integer;
  temp:string;
begin
   temp:=RemoveUTF8(recherche.text);
   if length(recherche.text)>0 then
      begin
      i:=IndexGrid.Row;
      If AnsiCompareText((copy(IndexGrid.Cells[6,i],1,length(temp))),temp)>0 then
         begin
         while (AnsiCompareText((copy(IndexGrid.Cells[6,i],1,length(temp))),temp)>0) and (i>1) do
            begin
//            Application.ProcessMessages;
            i:=i-1;
         end;
      end
      else
         begin
         while (AnsiCompareText((copy(IndexGrid.Cells[6,i],1,length(temp))),temp)<0) and (i<IndexGrid.rowcount-1) do
            begin
//            Application.ProcessMessages;
            i:=i+1;
         end;
      end;
      IndexGrid.Row:=i;
   end;
end;

procedure TFormExplorateur2.RechercheDblClick(Sender: TObject);
begin
  Recherche.Text:='';
  RechercheF.Text:='';
end;

{procedure TrouveIndividu2;
var
  i:integer;
begin
    if (IndexGrid.Cells[1,IndexGrid.Row]<>Principale.Individu.Caption) then
       // or (FormExplorateur2.Index.Cells[5,FormExplorateur2.Index.Row]<>'*') then
       begin
       i:=0;
       // Rechercher le nom  principal
       while ((IndexGrid.Cells[1,i]<>Principale.Individu.Caption) or
              (IndexGrid.Cells[5,i]='')) and
             (i<IndexGrid.rowcount-1) do
          i:=i+1;
       if (IndexGrid.Cells[1,i]=Principale.Individu.Caption) then
          IndexGrid.Row:=i
       else
          IndexGrid.Row:=1;
    end;
    if CanFocus then IndexGrid.SetFocus;
end;}

procedure TFormExplorateur2.RechercheKeyPress(Sender: TObject; var Key: char);
var
  row, i, last:integer;
  MyCursor: TCursor;
  searchtext: string;
  searchtextF: string;
  searchtext2: string;
  searchtextF2: string;
  searchtext3: string;
  searchtextF3: string;
begin
if (Key=chr(13)) then
    begin
    MyCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    if (length(rechercheF.text)>=3) then
       begin
       searchtextF:='';
       searchtextF2:='';
       searchtextF3:='';
       last:=1;
       for i:=1 to length(rechercheF.text) do begin
          if (copy(rechercheF.text,i,1)=' ') then
          begin
             searchtextF:=searchtextF+'''%'+copy(rechercheF.text,last,i-last)+'%'' AND R LIKE ';
             searchtextF2:=searchtextF2+'''%'+copy(rechercheF.text,last,i-last)+'%'' AND cm.CF LIKE ';
             searchtextF3:=searchtextF3+'''%'+copy(rechercheF.text,last,i-last)+'%'' AND cf.CF LIKE ';
             last:=i+1;
          end;
       end;
       searchtextF:=searchtextF+'''%'+copy(rechercheF.text,last,i-last+1)+'%''';
       searchtextF2:=searchtextF2+'''%'+copy(rechercheF.text,last,i-last+1)+'%''';
       searchtextF3:=searchtextF3+'''%'+copy(rechercheF.text,last,i-last+1)+'%''';
       Query1.SQL.Clear;
       Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I,1 FROM N JOIN I on N.I=I.no WHERE R LIKE '+searchtextF+' AND (I.S=''F'' OR I.S=''?'')');
    end;
    if (length(recherche.text)>=3) then
       begin
       searchtext:='';
       searchtext2:='';
       searchtext3:='';
       last:=1;
       for i:=1 to length(recherche.text) do begin
          if (copy(recherche.text,i,1)=' ') then
          begin
             searchtext:=searchtext+'''%'+copy(recherche.text,last,i-last)+'%'' AND R LIKE ';
             searchtext2:=searchtext2+'''%'+copy(recherche.text,last,i-last)+'%'' AND cm.CM LIKE ';
             searchtext3:=searchtext3+'''%'+copy(recherche.text,last,i-last)+'%'' AND cf.CM LIKE ';
             last:=i+1;
          end;
       end;
       searchtext:=searchtext+'''%'+copy(recherche.text,last,i-last+1)+'%''';
       searchtext2:=searchtext2+'''%'+copy(recherche.text,last,i-last+1)+'%''';
       searchtext3:=searchtext3+'''%'+copy(recherche.text,last,i-last+1)+'%''';
       Query1.SQL.Clear;
       Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I,1 FROM N JOIN I on N.I=I.no WHERE R LIKE '+searchtext+' AND (I.S=''M'' OR I.S=''?'')');
    end;
    if (length(rechercheF.text)>=3) and (length(recherche.text)>=3) then
       begin // Recherche l'homme du couple
       Query1.SQL.Clear;
       Query1.SQL.add('SELECT n.no, n.I, n.N, n.I1, n.I2, n.I3, n.I4, n.X, I.I, cm.X FROM N ');
       Query1.SQL.add('JOIN I ON I.no=N.I JOIN couples_vivants cm ON N.no = cm.CMnn ');
       Query1.SQL.add('WHERE (cm.CM LIKE '+searchtext2+' AND cm.CF LIKE '+searchtextF2+')');
//       Query1.SQL.add('SELECT n.no, n.I, n.N, n.I1, n.I2, n.I3, n.I4, n.X, I.I FROM ');
//       Query1.SQL.add('( SELECT e.no as nono, n.I as II FROM e JOIN w ON e.no=w.E JOIN n on n.I=w.I JOIN i on i.no=n.I JOIN y on e.Y=y.no WHERE ');
//       Query1.SQL.add('((n.N LIKE '+searchtext+' AND i.S=''M'') or (n.N LIKE '+searchtextF+' AND i.S=''F'')) AND e.X=1 AND w.X=1 AND y.Y=''M'') ');
//       Query1.SQL.add('sub JOIN w on w.e=sub.nono JOIN n on n.I=w.I JOIN i on i.no=n.I WHERE w.X=1 AND w.I<>sub.II AND ');
//       Query1.SQL.add('((n.N LIKE '+searchtext+' AND i.S=''M'') or (n.N LIKE '+searchtextF+' AND i.S=''F''))')
       case O.text of
           '1': Query1.SQL.add(' GROUP BY no ORDER BY cm.X DESC, n.I2, n.I1, n.I3, n.I4');
           '2': Query1.SQL.add(' GROUP BY no ORDER BY cm.X DESC, n.I1, n.I2, n.I3, n.I4');
           '3': Query1.SQL.add(' GROUP BY no ORDER BY cm.X DESC, n.I3, n.I4, n.I1, n.I2');
           '4': Query1.SQL.add(' GROUP BY no ORDER BY cm.X DESC, n.I4, n.I3, n.I1, n.I2');
         end;
       end
    else
       case O.text of
             '1': Query1.SQL.add(' GROUP BY no ORDER BY n.I2, n.I1, n.I3, n.I4');
             '2': Query1.SQL.add(' GROUP BY no ORDER BY n.I1, n.I2, n.I3, n.I4');
             '3': Query1.SQL.add(' GROUP BY no ORDER BY n.I3, n.I4, n.I1, n.I2');
             '4': Query1.SQL.add(' GROUP BY no ORDER BY n.I4, n.I3, n.I1, n.I2');
       end;
    Query1.Open;
    Query1.First;
    row:=1;
    IndexGrid.RowCount:=Query1.RecordCount+1;
    Principale.ProgressBar.Max:=IndexGrid.RowCount;
    Principale.ProgressBar.Position:=0;
    Principale.ProgressBar.Visible:=True;
    While not Query1.EOF do
       begin
       IndexGrid.Cells[0,row]:=Query1.Fields[0].AsString;
       IndexGrid.Cells[1,row]:=Query1.Fields[1].AsString;
       IndexGrid.Cells[2,row]:=DecodeName(Query1.Fields[2].AsString,2);
       IndexGrid.Cells[3,row]:=ConvertDate(Query1.Fields[5].AsString,1);
       IndexGrid.Cells[4,row]:=ConvertDate(Query1.Fields[6].AsString,1);
       if Query1.Fields[7].AsBoolean then
          begin
          if (Query1.Fields[8].AsString='9') then
             begin
             if (Query1.Fields[9].AsString='0') then
                IndexGrid.Cells[5,row]:='9*!'
             else
                IndexGrid.Cells[5,row]:='9*';
          end
          else
             begin
             if (Query1.Fields[9].AsString='0') then
                IndexGrid.Cells[5,row]:='*!'
             else
                IndexGrid.Cells[5,row]:='*';
          end
       end
       else
          begin
          if (Query1.Fields[8].AsString='9') then
             begin
             if (Query1.Fields[9].AsString='0') then
                IndexGrid.Cells[5,row]:='9!'
             else
                IndexGrid.Cells[5,row]:='9';
          end
          else
             begin
             if (Query1.Fields[9].AsString='0') then
                IndexGrid.Cells[5,row]:='!'
             else
                IndexGrid.Cells[5,row]:='';
          end
       end;
       IndexGrid.Cells[6,row]:=RemoveUTF8(Query1.Fields[3].AsString)+', '+RemoveUTF8(Query1.Fields[4].AsString);
       row:=row+1;
       Query1.Next;
       Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
    end;
    if (length(rechercheF.text)>=3) and (length(recherche.text)>=3) then
       begin // Recherche la femme du couple
       Query1.SQL.Clear;
       Query1.SQL.add('SELECT n.no, n.I, n.N, n.I1, n.I2, n.I3, n.I4, n.X, I.I, cf.X FROM N ');
       Query1.SQL.add('JOIN I ON I.no=N.I JOIN couples_vivants cf ON N.no = cf.CFnn ');
       Query1.SQL.add('WHERE (cf.CM LIKE '+searchtext3+' AND cf.CF LIKE '+searchtextF3+')');
//       Query1.SQL.add('SELECT n.no, n.I, n.N, n.I1, n.I2, n.I3, n.I4, n.X, I.I FROM ');
//       Query1.SQL.add('( SELECT e.no as nono, n.I as II FROM e JOIN w ON e.no=w.E JOIN n on n.I=w.I JOIN i on i.no=n.I JOIN y on e.Y=y.no WHERE ');
//       Query1.SQL.add('((n.N LIKE '+searchtext+' AND i.S=''M'') or (n.N LIKE '+searchtextF+' AND i.S=''F'')) AND e.X=1 AND w.X=1 AND y.Y=''M'') ');
//       Query1.SQL.add('sub JOIN w on w.e=sub.nono JOIN n on n.I=w.I JOIN i on i.no=n.I WHERE w.X=1 AND w.I<>sub.II AND ');
//       Query1.SQL.add('((n.N LIKE '+searchtext+' AND i.S=''M'') or (n.N LIKE '+searchtextF+' AND i.S=''F''))')
       case O.text of
          '1': Query1.SQL.add(' GROUP BY no ORDER BY cf.X DESC, n.I2, n.I1, n.I3, n.I4');
          '2': Query1.SQL.add(' GROUP BY no ORDER BY cf.X DESC, n.I1, n.I2, n.I3, n.I4');
          '3': Query1.SQL.add(' GROUP BY no ORDER BY cf.X DESC, n.I3, n.I4, n.I1, n.I2');
          '4': Query1.SQL.add(' GROUP BY no ORDER BY cf.X DESC, n.I4, n.I3, n.I1, n.I2');
       end;
       Query1.Open;
       Query1.First;
       row:=IndexGrid.RowCount;
       IndexGrid.RowCount:=IndexGrid.RowCount+Query1.RecordCount;
       Principale.ProgressBar.Max:=IndexGrid.RowCount;
       Principale.ProgressBar.Position:=0;
       Principale.ProgressBar.Visible:=True;
       While not Query1.EOF do
          begin
          IndexGrid.Cells[0,row]:=Query1.Fields[0].AsString;
          IndexGrid.Cells[1,row]:=Query1.Fields[1].AsString;
          IndexGrid.Cells[2,row]:=DecodeName(Query1.Fields[2].AsString,2);
          IndexGrid.Cells[3,row]:=ConvertDate(Query1.Fields[5].AsString,1);
          IndexGrid.Cells[4,row]:=ConvertDate(Query1.Fields[6].AsString,1);
          if Query1.Fields[7].AsBoolean then
             begin
             if (Query1.Fields[8].AsString='9') then
                begin
                if (Query1.Fields[9].AsString='0') then
                   IndexGrid.Cells[5,row]:='9*!'
                else
                   IndexGrid.Cells[5,row]:='9*';
             end
             else
                begin
                if (Query1.Fields[9].AsString='0') then
                   IndexGrid.Cells[5,row]:='*!'
                else
                   IndexGrid.Cells[5,row]:='*';
             end
          end
          else
             begin
             if (Query1.Fields[8].AsString='9') then
                begin
                if (Query1.Fields[9].AsString='0') then
                   IndexGrid.Cells[5,row]:='9!'
                else
                   IndexGrid.Cells[5,row]:='9';
             end
             else
                begin
                if (Query1.Fields[9].AsString='0') then
                   IndexGrid.Cells[5,row]:='!'
                else
                   IndexGrid.Cells[5,row]:='';
             end
          end;
          IndexGrid.Cells[6,row]:=RemoveUTF8(Query1.Fields[3].AsString)+', '+RemoveUTF8(Query1.Fields[4].AsString);
          row:=row+1;
          Query1.Next;
          Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
       end;
    end;
    Principale.ProgressBar.Visible:=False;
    RechercheChange(Sender);
    Screen.Cursor := MyCursor;
{ Procedure TrouveIndividu2;}
    if (IndexGrid.Cells[1,IndexGrid.Row]<>Principale.Individu.Caption) then
       // or (FormExplorateur2.Index.Cells[5,FormExplorateur2.Index.Row]<>'*') then
       begin
       i:=0;
       // Rechercher le nom  principal
       while ((IndexGrid.Cells[1,i]<>Principale.Individu.Caption) or
              (IndexGrid.Cells[5,i]='')) and
             (i<IndexGrid.rowcount-1) do
          i:=i+1;
       if (IndexGrid.Cells[1,i]=Principale.Individu.Caption) then
          IndexGrid.Row:=i
       else
          IndexGrid.Row:=1;
    end;
    if CanFocus then IndexGrid.SetFocus;
end;
end;


end.

