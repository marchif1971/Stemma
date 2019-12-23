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
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PopupMenuEvenements: TPopupMenu;
    TableauEvenements: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      AState: TOwnerDrawState);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
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

procedure TFormEvenements.MenuItem24Click(Sender: TObject);
begin
  PutCode('A','RP');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem25Click(Sender: TObject);
begin
  PutCode('A','RA');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem26Click(Sender: TObject);
begin
  PutCode('A','RB');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem27Click(Sender: TObject);
begin
  PutCode('A','RM');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem28Click(Sender: TObject);
begin
  PutCode('A','RR');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem31Click(Sender: TObject);
begin
  PutCode('A','OJ');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem32Click(Sender: TObject);
var
  temp : string;
begin
  temp:='OJ'+TMenuItem(Sender).caption;
  PutCode('A',temp);
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem32Click(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
begin

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

procedure TFormEvenements.MenuItem8Click(Sender: TObject);
begin

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
  temp, witness:string;
begin
  // Fin de drag, identifier l'événement, ajouter le "draggé" comme témoin
  TableauEvenements.MouseToCell(X, Y, DestCol, DestRow);
//  Principale.Query1.Open;
//  Principale.Query1.First;
  // Ajoute le témoin qui a été ajouté par défaut dans le tableau
  if length(Principale.DragList.Caption)>0 then
     while length(Principale.DragList.Caption)>0 do
     begin
       temp:=Principale.DragList.Caption;
       if (AnsiPos(',',Principale.DragList.Caption)>0) then
          witness:=copy(Principale.DragList.Caption,1,AnsiPos(',',Principale.DragList.Caption)-1)
       else
           witness:=Principale.DragList.Caption;
       Principale.DragList.Caption:=Copy(Principale.DragList.Caption,AnsiPos(',',Principale.DragList.Caption)+1,length(Principale.DragList.Caption));
       Principale.Query1.SQL.Clear;
       temp:='INSERT INTO W (R, I, P, E, X) VALUES (''TEMOIN'', '+witness+', '''', '+TableauEvenements.Cells[0,DestRow]+', 0)';
       // doit vérifier si cet événement accepte les "TÉMOIN"
       //  if (Application.MessageBox(pchar(AnsitoUTF8(temp)),pchar(temp),MB_YESNO)=IDYES) then
       //     begin
       Principale.Query1.SQL.Add(temp);
       Principale.Query1.ExecSQL;
     end
  else
     begin
     witness:=Principale.DragValue.Caption;
     Principale.Query1.SQL.Clear;
     temp:='INSERT INTO W (R, I, P, E, X) VALUES (''TEMOIN'', '+witness+', '''', '+TableauEvenements.Cells[0,DestRow]+', 0)';
     // doit vérifier si cet événement accepte les "TÉMOIN"
     //  if (Application.MessageBox(pchar(AnsitoUTF8(temp)),pchar(temp),MB_YESNO)=IDYES) then
     //     begin
     Principale.Query1.SQL.Add(temp);
     Principale.Query1.ExecSQL;
  end;
end;

procedure TFormEvenements.TableauEvenementsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := (StrToInt(Principale.DragValue.Caption)>0) OR (length(Principale.DragList.Caption)>0);
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
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[426]);
  MenuItem30.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[234]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[416]);
  MenuItem9.Caption:=AnsitoUTF8(Principale.Traduction.Items[417]);
  MenuItem10.Caption:=AnsitoUTF8(Principale.Traduction.Items[418]);
  MenuItem11.Caption:=AnsitoUTF8(Principale.Traduction.Items[419]);
  MenuItem24.Caption:=AnsitoUTF8(Principale.Traduction.Items[420]);
  MenuItem25.Caption:=AnsitoUTF8(Principale.Traduction.Items[421]);
  MenuItem26.Caption:=AnsitoUTF8(Principale.Traduction.Items[422]);
  MenuItem27.Caption:=AnsitoUTF8(Principale.Traduction.Items[423]);
  MenuItem28.Caption:=AnsitoUTF8(Principale.Traduction.Items[424]);
  MenuItem29.Caption:=AnsitoUTF8(Principale.Traduction.Items[425]);
  MenuItem31.Caption:=AnsitoUTF8(Principale.Traduction.Items[427]);
  MenuItem12.Caption:=AnsitoUTF8(Principale.Traduction.Items[428]);
  MenuItem13.Caption:=AnsitoUTF8(Principale.Traduction.Items[429]);
  MenuItem14.Caption:=AnsitoUTF8(Principale.Traduction.Items[430]);
  MenuItem15.Caption:=AnsitoUTF8(Principale.Traduction.Items[431]);
  MenuItem16.Caption:=AnsitoUTF8(Principale.Traduction.Items[432]);
  MenuItem17.Caption:=AnsitoUTF8(Principale.Traduction.Items[433]);
  MenuItem18.Caption:=AnsitoUTF8(Principale.Traduction.Items[428]);
  MenuItem19.Caption:=AnsitoUTF8(Principale.Traduction.Items[429]);
  MenuItem20.Caption:=AnsitoUTF8(Principale.Traduction.Items[430]);
  MenuItem21.Caption:=AnsitoUTF8(Principale.Traduction.Items[431]);
  MenuItem22.Caption:=AnsitoUTF8(Principale.Traduction.Items[432]);
  MenuItem23.Caption:=AnsitoUTF8(Principale.Traduction.Items[433]);
  MenuItem32.Caption:=AnsitoUTF8(Principale.Traduction.Items[428]);
  MenuItem33.Caption:=AnsitoUTF8(Principale.Traduction.Items[429]);
  MenuItem34.Caption:=AnsitoUTF8(Principale.Traduction.Items[430]);
  MenuItem35.Caption:=AnsitoUTF8(Principale.Traduction.Items[431]);
  MenuItem36.Caption:=AnsitoUTF8(Principale.Traduction.Items[432]);
  MenuItem37.Caption:=AnsitoUTF8(Principale.Traduction.Items[433]);
  GetFormPosition(Sender as TForm,0,0,70,1000);
  GetGridPosition(FormEvenements.TableauEvenements as TStringGrid,7);
  PopulateEvenements;
end;

procedure TFormEvenements.MenuItem10Click(Sender: TObject);
begin
  PutCode('A','OE');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem11Click(Sender: TObject);
begin
  PutCode('A','OC');
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem12Click(Sender: TObject);
var
  temp : string;
begin
  temp:='OE'+TMenuItem(Sender).caption;
  PutCode('A',temp);
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

procedure TFormEvenements.MenuItem18Click(Sender: TObject);
var
  temp : string;
begin
  temp:='OC'+TMenuItem(Sender).caption;
  PutCode('A',temp);
  if EditEvenement.Showmodal = mrOK then
     begin
     PopulateEvenements;
     // Devrait modifier la fenêtre des exhibits aussi si elle est affichée (modifier et supprimer aussi)
     if Principale.MenuItem11.Checked then
        PopulateExhibits(FormExhibits.TableauExhibits,'I',Principale.Individu.Caption);
  end;
end;

{$R *.lfm}

end.

