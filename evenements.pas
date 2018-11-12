unit Evenements;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  FMUtils, LCLType;

type

  { TFormEvenements }

  TFormEvenements = class(TForm)
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    PopupMenuEvenements: TPopupMenu;
    TableauEvenements: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure TableauEvenementsDblClick(Sender: TObject);
    procedure TableauEvenementsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TableauEvenementsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TableauEvenementsDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
  private
    { private declarations }
  public
    { public declarations }
  end; 

Procedure PopulateEvenements;

var
  FormEvenements: TFormEvenements;

implementation

uses
  unit1,edit_evenements, explorateur, exhibits;

{ TFormEvenements }

Procedure PopulateEvenements;
var
  age, row:integer;
  lieu, memo, temoin:string;
begin
  Principale.Query1.SQL.Clear;
  Principale.Query1.SQL.add('SELECT E.no, E.X, E.Y, E.PD, E.L, E.SD, W.X, E.M FROM E JOIN W on W.E=E.no WHERE W.I='+Principale.Individu.Caption+' ORDER BY E.SD');
  Principale.Query1.Open;
  Principale.Query1.First;
  row:=1;
  FormEvenements.TableauEvenements.RowCount:=Principale.Query1.RecordCount+1;
  While not Principale.Query1.EOF do
  begin
     FormEvenements.TableauEvenements.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
     if Principale.Query1.Fields[1].AsBoolean and Principale.Query1.Fields[6].AsBoolean then
        FormEvenements.TableauEvenements.Cells[1,row]:='*'
     else
        FormEvenements.TableauEvenements.Cells[1,row]:='';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT T FROM Y WHERE no='+Principale.Query1.Fields[2].AsString);
     Principale.Query2.Open;
     FormEvenements.TableauEvenements.Cells[2,row]:=Principale.Query2.Fields[0].AsString;
     FormEvenements.TableauEvenements.Cells[3,row]:=ConvertDate(Principale.Query1.Fields[3].AsString,1);
     // Trouver # d'un autre principal témoin de l'événement
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT I FROM W WHERE X=1 AND E='+Principale.Query1.Fields[0].AsString);
     Principale.Query2.Open;
     FormEvenements.TableauEvenements.Cells[7,row]:='0';
     temoin:='';
     While not Principale.Query2.EOF do
         begin
         // Trouver les témoins principaux de l'événement
         If not (Principale.Query2.Fields[0].AsString=Principale.Individu.Caption) then
            begin
            if StrToInt(FormEvenements.TableauEvenements.Cells[7,row])=0 then
               FormEvenements.TableauEvenements.Cells[7,row]:=Principale.Query2.Fields[0].AsString;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.add('SELECT N FROM N WHERE X=1 AND I='+Principale.Query2.Fields[0].AsString);
            Principale.Query3.Open;
            if length(temoin)>0 then
               temoin:=temoin+' & '+DecodeName(Principale.Query3.Fields[0].AsString,1)+' ['+Principale.Query2.Fields[0].AsString+']'
            else
               temoin:=DecodeName(Principale.Query3.Fields[0].AsString,1)+' ['+Principale.Query2.Fields[0].AsString+']';
         end;
         Principale.Query2.Next;
     end;
     // Implanter la description
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT L FROM L WHERE no='+Principale.Query1.Fields[4].AsString);
     Principale.Query2.Open;
     Lieu:=DecodeLieu(Principale.Query2.Fields[0].AsString);
     Memo:=Principale.Query1.Fields[7].AsString;
     If length(Lieu)>0 then
        if length(Memo)>0 then
           if length(temoin)>0 then
              FormEvenements.TableauEvenements.Cells[4,row]:=Temoin+'; '+Lieu+'; '+Memo
           else
              FormEvenements.TableauEvenements.Cells[4,row]:=Lieu+'; '+Memo
        else
           if length(temoin)>0 then
              FormEvenements.TableauEvenements.Cells[4,row]:=Temoin+'; '+Lieu
           else
              FormEvenements.TableauEvenements.Cells[4,row]:=Lieu
     else
           if length(Memo)>0 then
              if length(temoin)>0 then
                 FormEvenements.TableauEvenements.Cells[4,row]:=Temoin+'; '+Memo
              else
                 FormEvenements.TableauEvenements.Cells[4,row]:=Memo
           else
              if length(temoin)>0 then
                 FormEvenements.TableauEvenements.Cells[4,row]:=Temoin
              else
                 FormEvenements.TableauEvenements.Cells[4,row]:='';
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT Q FROM C WHERE Y=''E'' AND N='+FormEvenements.TableauEvenements.Cells[0,row]+' ORDER BY Q DESC');
     Principale.Query2.Open;
     FormEvenements.TableauEvenements.Cells[5,row]:=Principale.Query2.Fields[0].AsString;
     // Calculer l'âge
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT I3 FROM N WHERE X=1 AND I='+Principale.Individu.Caption);
     Principale.Query2.Open;
     if ((Copy(Principale.Query2.Fields[0].AsString,1,1)='1') AND
         (Copy(Principale.Query1.Fields[5].AsString,1,1)='1')) then
         age:=StrToInt(Copy(Principale.Query1.Fields[5].AsString,2,4))
               -StrtoInt(Copy(Principale.Query2.Fields[0].AsString,2,4))
     else
        age:=-1;
     if (age>=0) AND (age<200) then
         FormEvenements.TableauEvenements.Cells[6,row]:=InttoStr(age)
     else
        FormEvenements.TableauEvenements.Cells[6,row]:='';
     if Principale.Query1.Fields[6].AsBoolean then
        FormEvenements.TableauEvenements.Cells[8,row]:='*'
     else
        FormEvenements.TableauEvenements.Cells[8,row]:='';
     Principale.Query1.Next;
     row:=row+1;
  end;
  FormEvenements.Caption:=AnsitoUTF8(Principale.Traduction.Items[59])+' ('+IntToStr(FormEvenements.TableauEvenements.RowCount-1)+')';
end;

procedure TFormEvenements.MenuItem1Click(Sender: TObject);
begin
  if TableauEvenements.Row>0 then
     If StrToInt(TableauEvenements.Cells[7,TableauEvenements.Row])>0 then
        Principale.Individu.Caption:=TableauEvenements.Cells[7,TableauEvenements.Row];
end;

procedure TFormEvenements.MenuItem3Click(Sender: TObject);
begin
  PutCode('A','0');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem5Click(Sender: TObject);
begin
  // Supprimer un événement
  if TableauEvenements.Row>0 then
     if TableauEvenements.Cells[1,TableauEvenements.Row]='' then
        if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[60])+
           TableauEvenements.Cells[2,TableauEvenements.Row]+'-'+TableauEvenements.Cells[4,TableauEvenements.Row]+
           AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
           begin
           // Modifie la date de dernière modification pour tous les témoins
           Principale.Query3.SQL.Clear;
           Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+TableauEvenements.Cells[0,TableauEvenements.Row]);
           Principale.Query3.Open;
           Principale.Query3.First;
           While not Principale.Query3.EOF do
              begin
              SaveModificationTime(Principale.Query3.Fields[0].AsString);
              Principale.Query3.Next;
           end;
           // Supprimer tous les exhibits de cet événement
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM X WHERE A=''E'' AND N='+TableauEvenements.Cells[0,TableauEvenements.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM C WHERE Y=''E'' AND N='+TableauEvenements.Cells[0,TableauEvenements.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM W WHERE E='+TableauEvenements.Cells[0,TableauEvenements.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM E WHERE no='+TableauEvenements.Cells[0,TableauEvenements.Row]);
           Principale.Query1.ExecSQL;
           TableauEvenements.DeleteRow(TableauEvenements.Row);
           // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
           if Principale.MenuItem11.Checked then
              PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
        end;
end;

procedure TFormEvenements.MenuItem7Click(Sender: TObject);
var
  temoins1, temoins2:string;
  redraw, resort:boolean;
  j:integer;
begin
   redraw:=false;
   if TableauEvenements.Row>0 then
      begin
      // si c'est un témoin primaire de l'événement sélectionné
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.add('SELECT E.no, E.X, W.I, E.Y, Y.Y FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE W.X=1 AND W.I='+Principale.Individu.Caption+
                                ' AND E.no='+TableauEvenements.Cells[0,TableauEvenements.Row]);
      Principale.Query1.Open;
      Principale.Query1.First;
      if not Principale.Query1.eof then
         begin
         // si primaire, enlève le primaire de la base de données et du tableau.
         if Principale.Query1.Fields[1].AsBoolean then
            begin
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('UPDATE E SET X=0 WHERE no='+TableauEvenements.Cells[0,TableauEvenements.Row]);
            Principale.Query2.ExecSQL;
            TableauEvenements.Cells[1,TableauEvenements.Row]:='';
            redraw:=true;
            If Principale.Query1.Fields[4].AsString='B' then
               begin
               Principale.Query2.SQL.Clear;
               Principale.Query2.SQL.Add('UPDATE N SET I3='''' WHERE N.I='+Principale.Query1.Fields[2].AsString);
               Principale.Query2.ExecSQL;
               resort:=false;
               if Principale.MenuItem13.Checked then
                  for j:=1 to FormExplorateur.Index.RowCount-1 do
                        if FormExplorateur.Index.Cells[1,j]=Principale.Query1.Fields[2].AsString then
                           begin
                           FormExplorateur.Index.Cells[3,j]:='';
                           if FormExplorateur.O.text='3' then
                              begin
                              FormExplorateur.Index.Cells[6,j]:='';
                              resort:=true;
                           end;
                        end;
            end;
            If Principale.Query1.Fields[4].AsString='D' then
               begin
               Principale.Query2.SQL.Clear;
               Principale.Query2.SQL.Add('UPDATE N SET I4='''' WHERE N.I='+Principale.Query1.Fields[2].AsString);
               Principale.Query2.ExecSQL;
               resort:=false;
               if Principale.MenuItem13.Checked then
                  for j:=1 to FormExplorateur.Index.RowCount-1 do
                        if FormExplorateur.Index.Cells[1,j]=Principale.Query1.Fields[2].AsString then
                           begin
                           FormExplorateur.Index.Cells[4,j]:='';
                           if FormExplorateur.O.text='4' then
                              begin
                              FormExplorateur.Index.Cells[6,j]:='';
                              resort:=true;
                           end;
                        end;
            end;
         end
         // sinon
         else
            begin
            // trouve si autre événement du même types avec même témoins primaires qui est primaire
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.add('SELECT W.I FROM W WHERE W.X=1 AND W.E='
                                      +TableauEvenements.Cells[0,TableauEvenements.Row]+' ORDER BY W.I');
            Principale.Query2.Open;
            Principale.Query2.First;
            temoins1:='';
            While not Principale.Query2.Eof do
               begin
               temoins1:=temoins1+'|'+Principale.Query2.Fields[0].AsString;
               Principale.Query2.Next;
            end;
            Principale.Query2.SQL.Clear;
            if Principale.Query1.Fields[4].AsString='X' then
               Principale.Query2.SQL.add('SELECT E.no, W.I FROM E JOIN W on W.E=E.no WHERE W.X=1 AND E.X=1 AND E.Y='
                                         +Principale.Query1.Fields[3].AsString+' AND W.I='+Principale.Individu.Caption)
            else
               Principale.Query2.SQL.add('SELECT E.no, W.I FROM E JOIN W on W.E=E.no JOIN Y on E.Y=Y.no WHERE W.X=1 AND E.X=1 AND Y.Y='''
                                         +Principale.Query1.Fields[4].AsString+''' AND W.I='+Principale.Individu.Caption);
            Principale.Query2.Open;
            Principale.Query2.First;
            While not Principale.Query2.Eof do
               begin
               Principale.Query3.SQL.Clear;
               Principale.Query3.SQL.add('SELECT W.I FROM W WHERE W.X=1 AND W.E='
                                         +Principale.Query2.Fields[0].AsString+' ORDER BY W.I');
               Principale.Query3.Open;
               Principale.Query3.First;
               temoins2:='';
               While not Principale.Query3.Eof do
                  begin
                  temoins2:=temoins2+'|'+Principale.Query3.Fields[0].AsString;
                  Principale.Query3.Next;
               end;
               // Enlève son tag primaire
               if temoins1=temoins2 then
                  begin
                  Principale.Query3.SQL.Clear;
                  Principale.Query3.SQL.Add('UPDATE E SET X=0 WHERE no='+Principale.Query2.Fields[0].AsString);
                  Principale.Query3.ExecSQL;
                  redraw:=true;
               end;
               Principale.Query2.next;
            end;
            // mets le tag primaire à l'événement sélectionné dans la base de données et dans le tableau
            Principale.Query2.SQL.Clear;
            Principale.Query2.SQL.Add('UPDATE E SET X=1 WHERE no='+TableauEvenements.Cells[0,TableauEvenements.Row]);
            Principale.Query2.ExecSQL;
            TableauEvenements.Cells[1,TableauEvenements.Row]:='*';
            If Principale.Query1.Fields[4].AsString='B' then
               begin
               Principale.Query2.SQL.Clear;
               Principale.Query2.SQL.Add('UPDATE N SET I3='''+GetI3(Principale.Query1.Fields[2].AsString)+
                  ''' WHERE N.I='+Principale.Query1.Fields[2].AsString);
               Principale.Query2.ExecSQL;
               resort:=false;
               if Principale.MenuItem13.Checked then
                  for j:=1 to FormExplorateur.Index.RowCount-1 do
                        if FormExplorateur.Index.Cells[1,j]=Principale.Query1.Fields[2].AsString then
                           begin
                           FormExplorateur.Index.Cells[3,j]:=ConvertDate(GetI3(Principale.Query1.Fields[2].AsString),1);
                           if FormExplorateur.O.text='3' then
                              begin
                              FormExplorateur.Index.Cells[6,j]:=FormExplorateur.Index.Cells[3,j];
                              resort:=true;
                           end;
                        end;
            end;
            If Principale.Query1.Fields[4].AsString='D' then
               begin
               Principale.Query2.SQL.Clear;
               Principale.Query2.SQL.Add('UPDATE N SET I4='''+GetI4(Principale.Query1.Fields[2].AsString)+
                  ''' WHERE N.I='+Principale.Query1.Fields[2].AsString);
               Principale.Query2.ExecSQL;
               resort:=false;
               if Principale.MenuItem13.Checked then
                  for j:=1 to FormExplorateur.Index.RowCount-1 do
                        if FormExplorateur.Index.Cells[1,j]=Principale.Query1.Fields[2].AsString then
                           begin
                           FormExplorateur.Index.Cells[4,j]:=ConvertDate(GetI4(Principale.Query1.Fields[2].AsString),1);
                           if FormExplorateur.O.text='4' then
                              begin
                              FormExplorateur.Index.Cells[6,j]:=FormExplorateur.Index.Cells[4,j];
                              resort:=true;
                           end;
                        end;
            end;
         end;
      end;
      // Sauvegarder les modifications pour tout les témoins de l'événements
      Principale.Query3.SQL.Clear;
      Principale.Query3.SQL.Add('SELECT W.I, W.X FROM W WHERE W.E='+TableauEvenements.Cells[0,TableauEvenements.Row]);
      Principale.Query3.Open;
      Principale.Query3.First;
      While not Principale.Query3.EOF do
         begin
         SaveModificationTime(Principale.Query3.Fields[0].AsString);
         Principale.Query3.Next;
      end;
   end;
   if redraw then PopulateEvenements;
   if resort then
      begin
      FormExplorateur.Index.SortColRow(true,6);
      TrouveIndividu;
   end;
end;

procedure TFormEvenements.TableauEvenementsDblClick(Sender: TObject);
begin
  If TableauEvenements.Row>0 then
     If EditEvenement.Showmodal=mrOK then
        begin
        PopulateEvenements;
        // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
        if Principale.MenuItem11.Checked then
           PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
     end;
end;

procedure TFormEvenements.TableauEvenementsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DestCol,DestRow:integer;
  temp:string;
begin
  // Fin de drag, identifier l'événement, ajouter le "draggé" comme témoin
  TableauEvenements.MouseToCell(X, Y, DestCol, DestRow);
//  Principale.Query1.Open;
//  Principale.Query1.First;
  // Ajoute le témoin qui a été ajouté par défaut dans le tableau
  Principale.Query1.SQL.Clear;
  temp:='INSERT INTO W (R, I, P, E, X) VALUES (''TEMOIN'', '+Principale.DragValue.Caption+', '''', '+TableauEvenements.Cells[0,DestRow]+', 0)';
  // doit vérifier si cet événement accepte les "TÉMOIN"
//  if (Application.MessageBox(pchar(AnsitoUTF8(temp)),pchar(temp),MB_YESNO)=IDYES) then
//     begin
  Principale.Query1.SQL.Add(temp);
  Principale.Query1.ExecSQL;
//   end;
end;

procedure TFormEvenements.TableauEvenementsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragValue.Caption)>0);
end;

procedure TFormEvenements.TableauEvenementsDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if ((Sender as TStringGrid).Cells[1,aRow]='*') and (aCol=4) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := true;
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
  if (not ((Sender as TStringGrid).Cells[8,aRow]='*') and (aRow>0)) then
     begin
     (Sender as TStringGrid).Canvas.Font.Bold := false;
     if not (aRow = (Sender as TStringGrid).Row) then
        (Sender as TStringGrid).Canvas.Brush.Color := TColor($E0E0E0);
     (Sender as TStringGrid).Canvas.FillRect(aRect);
     (Sender as TStringGrid).Canvas.TextOut(aRect.Left+2,aRect.Top+2,(Sender as TStringGrid).Cells[aCol,aRow]);
  end;
end;

procedure TFormEvenements.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauEvenements as TStringGrid,7);
end;

procedure TFormEvenements.FormResize(Sender: TObject);
begin
  TableauEvenements.Width := (Sender as Tform).Width;
  TableauEvenements.Height := (Sender as Tform).Height;
  TableauEvenements.Columns[3].Width := (Sender as Tform).Width-233;
end;

procedure TFormEvenements.FormShow(Sender: TObject);
begin
  Caption:=AnsitoUTF8(Principale.Traduction.Items[59]);
  TableauEvenements.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[185]);
  TableauEvenements.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[136]);
  TableauEvenements.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauEvenements.Cells[5,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[222]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(FormEvenements.TableauEvenements as TStringGrid,7);
  PopulateEvenements;
end;

{$R *.lfm}

end.

