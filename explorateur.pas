unit Explorateur;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, DBGrids, ZDataset, FMUtils;

type

  { TFormExplorateur }

  TFormExplorateur = class(TForm)
    O: TEdit;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PopupMenu1: TPopupMenu;
    Query1: TZQuery;
    Query2: TZQuery;
    Recherche: TEdit;
    Index: TStringGrid;
    RechercheF: TEdit;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IndexDblClick(Sender: TObject);
    procedure IndexDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure IndexMouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TrouveIndividu;
procedure PopulateIndex(ordre:integer);

var
  FormExplorateur: TFormExplorateur;

implementation

uses
  unit1;

{$R *.lfm}

{ TFormExplorateur }

procedure PopulateIndex(ordre:integer);
var
  row:integer;
  MyCursor: TCursor;
begin
     MyCursor := Screen.Cursor;
     Screen.Cursor := crHourGlass;
     Principale.ProgressBar.Position:=0;
     Principale.ProgressBar.Visible:=True;
     Application.Processmessages;
     FormExplorateur.Query1.SQL.Clear;
     FormExplorateur.Query2.SQL.Clear;
     FormExplorateur.O.text:=inttostr(ordre);
     case ordre of
       1: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I2, I1, I3, I4 LIMIT 25000');
       2: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I1, I2, I3, I4 LIMIT 25000');
       3: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I3, I4, I1, I2 LIMIT 25000');
       4: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I4, I3, I1, I2 LIMIT 25000');
     end;
     FormExplorateur.Query2.SQL.add('SELECT count(no) as row FROM N');
     FormExplorateur.Query2.Open;
     FormExplorateur.Query2.First;
     row:=FormExplorateur.Query2.Fields[0].AsInteger+1;
     FormExplorateur.Index.RowCount:=row;
     Principale.ProgressBar.Max:=row;
     row:=1;
     while (row < (Principale.ProgressBar.Max-1)) do
     begin
        FormExplorateur.Query1.Open;
        FormExplorateur.Query1.First;
        While not FormExplorateur.Query1.EOF do
        begin
          FormExplorateur.Index.Cells[0,row]:=FormExplorateur.Query1.Fields[0].AsString;
          FormExplorateur.Index.Cells[1,row]:=FormExplorateur.Query1.Fields[1].AsString;
          // Change col 2 selon ordre
          case ordre of
            1: FormExplorateur.Index.Cells[2,row]:=(DecodeName(FormExplorateur.Query1.Fields[2].AsString,1));
            2: FormExplorateur.Index.Cells[2,row]:=(DecodeName(FormExplorateur.Query1.Fields[2].AsString,2));
            3: FormExplorateur.Index.Cells[2,row]:=(DecodeName(FormExplorateur.Query1.Fields[2].AsString,2));
            4: FormExplorateur.Index.Cells[2,row]:=(DecodeName(FormExplorateur.Query1.Fields[2].AsString,2));
          end;
          FormExplorateur.Index.Cells[3,row]:=ConvertDate(FormExplorateur.Query1.Fields[5].AsString,1);
          FormExplorateur.Index.Cells[4,row]:=ConvertDate(FormExplorateur.Query1.Fields[6].AsString,1);
          if FormExplorateur.Query1.Fields[7].AsBoolean then
             FormExplorateur.Index.Cells[5,row]:='*'
          else
             FormExplorateur.Index.Cells[5,row]:='';
          // Change col 6 selon ordre
          case ordre of
             1: FormExplorateur.Index.Cells[6,row]:=RemoveUTF8(FormExplorateur.Query1.Fields[4].AsString)+
                ' '+RemoveUTF8(FormExplorateur.Query1.Fields[3].AsString);
             2: FormExplorateur.Index.Cells[6,row]:=RemoveUTF8(FormExplorateur.Query1.Fields[3].AsString)+
                ', '+RemoveUTF8(FormExplorateur.Query1.Fields[4].AsString);
             3: FormExplorateur.Index.Cells[6,row]:=ConvertDate(FormExplorateur.Query1.Fields[5].AsString,1);
             4: FormExplorateur.Index.Cells[6,row]:=ConvertDate(FormExplorateur.Query1.Fields[6].AsString,1);
          end;
          row:=row+1;
          FormExplorateur.Query1.Next;
          if ((row mod 100) = 0) then
          begin
             Principale.ProgressBar.Position:=Principale.ProgressBar.Position+100;
             Application.ProcessMessages;
          end;
        end;
        FormExplorateur.Query1.SQL.Clear;
        case ordre of
          1: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I2, I1, I3, I4 LIMIT 25000 OFFSET '+inttostr(row));
          2: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I1, I2, I3, I4 LIMIT 25000 OFFSET '+inttostr(row));
          3: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I3, I4, I1, I2 LIMIT 25000 OFFSET '+inttostr(row));
          4: FormExplorateur.Query1.SQL.add('SELECT no, I, N, I1, I2, I3, I4, X FROM N ORDER BY I4, I3, I1, I2 LIMIT 25000 OFFEST '+inttostr(row));
        end;
     end;
     Principale.ProgressBar.Visible:=False;
     Screen.Cursor := MyCursor;
end;

procedure TFormExplorateur.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
     SaveFormPosition(Sender as TForm);
     SaveGridPosition(Index as TStringGrid,4);
end;

procedure TFormExplorateur.FormResize(Sender: TObject);
begin
     Index.Height:=FormExplorateur.Height-69;
     Index.Width:=FormExplorateur.Width-16;
     Recherche.Width:=FormExplorateur.Width-16;
     Recherche.Top:=FormExplorateur.Height-54;
     RechercheF.Width:=FormExplorateur.Width-16;
     RechercheF.Top:=FormExplorateur.Height-27;
     Index.Columns[1].Width := FormExplorateur.Width-156;
end;

procedure TFormExplorateur.FormShow(Sender: TObject);
begin
     Caption:=AnsitoUTF8(Principale.Traduction.Items[202]);
     Index.Cells[1,0]:='#';
     Index.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[176]);
     Index.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[203]);
     Index.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[204]);
     MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[235]);
     MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[236]);
     MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[237]);
     MenuItem6.Caption:=AnsitoUTF8(Principale.Traduction.Items[238]);
     GetFormPosition(Sender as TForm,0,0,70,1000);
     GetGridPosition(Index as TStringGrid,4);
//     PopulateIndex(2);
//     TrouveIndividu;
     FormExplorateur.Index.RowCount:=1;
end;

procedure TFormExplorateur.IndexDblClick(Sender: TObject);
begin
  If Index.Row>0 then
     Principale.Individu.Caption:=Index.Cells[1,Index.Row];
end;

procedure TFormExplorateur.IndexDrawCell(Sender: TObject; aCol, aRow: Integer;
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

procedure TFormExplorateur.IndexMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  startCol, startRow    : LongInt;
begin
   if Button=mbLeft then
      begin
      Index.MouseToCell(x,y,startCol,StartRow);
      if StartRow>0 then
         begin
         Index.Row:=StartRow;
         Principale.DragValue.Caption:=Index.Cells[1,StartRow];
         Principale.DragName.Caption:=Index.Cells[0,StartRow];
      end;
   end;
end;

procedure TFormExplorateur.MenuItem3Click(Sender: TObject);
var
  Key : char;
begin
   Key:=chr(13);
   O.text:='1';           // Tri par prénom
   recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur.MenuItem4Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(2);     Tri par nom
    Key:=chr(13);
    O.text:='2';
    recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur.MenuItem5Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(3);     Tri par naissance
    O.text:='3';
    Key:=chr(13);
    recherchekeypress(Sender,Key);
end;

procedure TFormExplorateur.MenuItem6Click(Sender: TObject);
var
  Key : char;
begin
//  PopulateIndex(4);     Tri par décès
    O.text:='4';
    Key:=chr(13);
    recherchekeypress(Sender,Key);
end;






procedure TFormExplorateur.RechercheChange(Sender: TObject);
var
  i:integer;
  temp:string;
begin
   temp:=RemoveUTF8(recherche.text);
   if length(recherche.text)>0 then
      begin
      i:=Index.Row;
      If AnsiCompareText((copy(Index.Cells[6,i],1,length(temp))),temp)>0 then
         begin
         while (AnsiCompareText((copy(Index.Cells[6,i],1,length(temp))),temp)>0) and (i>1) do
            begin
//            Application.ProcessMessages;
            i:=i-1;
         end;
      end
      else
         begin
         while (AnsiCompareText((copy(Index.Cells[6,i],1,length(temp))),temp)<0) and (i<index.rowcount-1) do
            begin
//            Application.ProcessMessages;
            i:=i+1;
         end;
      end;
      Index.Row:=i;
   end;
end;

procedure TFormExplorateur.RechercheDblClick(Sender: TObject);
begin
  Recherche.Text:='';
  RechercheF.Text:='';
end;




procedure TrouveIndividu;
var
  i:integer;
begin
    if (FormExplorateur.Index.Cells[1,FormExplorateur.Index.Row]<>Principale.Individu.Caption) then
       // or (FormExplorateur.Index.Cells[5,FormExplorateur.Index.Row]<>'*') then
       begin
       i:=0;
       // Rechercher le nom  principal
       while ((FormExplorateur.Index.Cells[1,i]<>Principale.Individu.Caption) or
              (FormExplorateur.Index.Cells[5,i]='')) and
             (i<FormExplorateur.index.rowcount-1) do
          i:=i+1;
       if (FormExplorateur.Index.Cells[1,i]=Principale.Individu.Caption) then
          FormExplorateur.Index.Row:=i
       else
          FormExplorateur.Index.Row:=1;
    end;
    if FormExplorateur.CanFocus then FormExplorateur.Index.SetFocus;
end;

procedure TFormExplorateur.RechercheKeyPress(Sender: TObject; var Key: char);
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
//          searchtextF:=searchtextF+'''%'+copy(rechercheF.text,last,i-last)+'%'' AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(N,''<Titre>'','' ''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ''),''<Suffixe>'','' ''),''</Suffixe>'','' '') LIKE ';
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
       Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I,1 FROM N JOIN I on N.I=I.no WHERE ');
       Query1.SQL.add('R');
//       Query1.SQL.add('REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(N,''<Titre>'','' ''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ''),''<Suffixe>'','' ''),''</Suffixe>'','' '')');
       Query1.SQL.add(' LIKE '+searchtextF+' AND (I.S=''F'' OR I.S=''?'')');
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
//          searchtext:=searchtext+'''%'+copy(recherche.text,last,i-last)+'%'' AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(N,''<Titre>'','' ''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ''),''<Suffixe>'','' ''),''</Suffixe>'','' '') LIKE ';
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
       Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, X, I.I,1 FROM N JOIN I on N.I=I.no WHERE ');
//       Query1.SQL.add('REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(N,''<Titre>'','' ''),''</Titre>'','' ''),''<Prénom>'','' ''),''</Prénom>'','' ''),''<Nom>'','' ''),''</Nom>'','' ''),''<Suffixe>'','' ''),''</Suffixe>'','' '')');
       Query1.SQL.add('R');
       Query1.SQL.add(' LIKE '+searchtext+' AND (I.S=''M'' OR I.S=''?'')');
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
    Index.RowCount:=Query1.RecordCount+1;
    Principale.ProgressBar.Max:=Index.RowCount;
    Principale.ProgressBar.Position:=0;
    Principale.ProgressBar.Visible:=True;
    While not Query1.EOF do
       begin
       Index.Cells[0,row]:=Query1.Fields[0].AsString;
       Index.Cells[1,row]:=Query1.Fields[1].AsString;
       Index.Cells[2,row]:=DecodeName(Query1.Fields[2].AsString,2);
       Index.Cells[3,row]:=ConvertDate(Query1.Fields[5].AsString,1);
       Index.Cells[4,row]:=ConvertDate(Query1.Fields[6].AsString,1);
       if Query1.Fields[7].AsBoolean then
          begin
          if (Query1.Fields[8].AsString='9') then
             begin
             if (Query1.Fields[9].AsString='0') then
                Index.Cells[5,row]:='9*!'
             else
                Index.Cells[5,row]:='9*';
          end
          else
             begin
             if (Query1.Fields[9].AsString='0') then
                Index.Cells[5,row]:='*!'
             else
                Index.Cells[5,row]:='*';
          end
       end
       else
          begin
          if (Query1.Fields[8].AsString='9') then
             begin
             if (Query1.Fields[9].AsString='0') then
                Index.Cells[5,row]:='9!'
             else
                Index.Cells[5,row]:='9';
          end
          else
             begin
             if (Query1.Fields[9].AsString='0') then
                Index.Cells[5,row]:='!'
             else
                Index.Cells[5,row]:='';
          end
       end;
       Index.Cells[6,row]:=RemoveUTF8(Query1.Fields[3].AsString)+', '+RemoveUTF8(Query1.Fields[4].AsString);
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
       row:=Index.RowCount;
       Index.RowCount:=Index.RowCount+Query1.RecordCount;
       Principale.ProgressBar.Max:=Index.RowCount;
       Principale.ProgressBar.Position:=0;
       Principale.ProgressBar.Visible:=True;
       While not Query1.EOF do
          begin
          Index.Cells[0,row]:=Query1.Fields[0].AsString;
          Index.Cells[1,row]:=Query1.Fields[1].AsString;
          Index.Cells[2,row]:=DecodeName(Query1.Fields[2].AsString,2);
          Index.Cells[3,row]:=ConvertDate(Query1.Fields[5].AsString,1);
          Index.Cells[4,row]:=ConvertDate(Query1.Fields[6].AsString,1);
          if Query1.Fields[7].AsBoolean then
             begin
             if (Query1.Fields[8].AsString='9') then
                begin
                if (Query1.Fields[9].AsString='0') then
                   Index.Cells[5,row]:='9*!'
                else
                   Index.Cells[5,row]:='9*';
             end
             else
                begin
                if (Query1.Fields[9].AsString='0') then
                   Index.Cells[5,row]:='*!'
                else
                   Index.Cells[5,row]:='*';
             end
          end
          else
             begin
             if (Query1.Fields[8].AsString='9') then
                begin
                if (Query1.Fields[9].AsString='0') then
                   Index.Cells[5,row]:='9!'
                else
                   Index.Cells[5,row]:='9';
             end
             else
                begin
                if (Query1.Fields[9].AsString='0') then
                   Index.Cells[5,row]:='!'
                else
                   Index.Cells[5,row]:='';
             end
          end;
          Index.Cells[6,row]:=RemoveUTF8(Query1.Fields[3].AsString)+', '+RemoveUTF8(Query1.Fields[4].AsString);
          row:=row+1;
          Query1.Next;
          Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
       end;
    end;
    Principale.ProgressBar.Visible:=False;
    RechercheChange(Sender);
    Screen.Cursor := MyCursor;
    TrouveIndividu;
end;
end;


end.

