unit Sources;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, FMUtils, StrUtils, LCLType;

type

  { TFormSources }

  TFormSources = class(TForm)
    Button1: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PopupMenu1: TPopupMenu;
    TableauSources: TStringGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure TableauSourcesDblClick(Sender: TObject);
    procedure TableauSourcesEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FormSources: TFormSources;

implementation

{ TODO 20 : F10 pour sortir de la fenêtre }
// Si j'ajoute un menu on le voit, faut trouver un moyen de mettre le
// shortcut pour sortir sans menu

uses
  unit1, utilisation, edit_source;

{$R *.lfm}

{ TFormSources }

procedure TFormSources.FormResize(Sender: TObject);
begin
  TableauSources.Width := (Sender as Tform).Width-16;
  TableauSources.Height := (Sender as Tform).Height-51;
  Button1.Top:= (Sender as Tform).Height-35;
  Button1.Left:= (Sender as Tform).Width-80;
end;

procedure TFormSources.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPosition(Sender as TForm);
  SaveGridPosition(TableauSources as TStringGrid,6);
end;

procedure TFormSources.FormShow(Sender: TObject);
var
  i:integer;
  MyCursor: TCursor;
  temp:string;
begin
  GetFormPosition(FormSources,0,0,70,1000);
  GetGridPosition(FormSources.TableauSources as TStringGrid,6);
  Caption:=AnsitoUTF8(Principale.Traduction.Items[218]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  TableauSources.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauSources.Cells[3,0]:=AnsitoUTF8(Principale.Traduction.Items[155]);
  TableauSources.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[156]);
  TableauSources.Cells[5,0]:=AnsitoUTF8(Principale.Traduction.Items[219]);
  TableauSources.Cells[6,0]:=AnsitoUTF8(Principale.Traduction.Items[177]);
  TableauSources.Cells[7,0]:=AnsitoUTF8(Principale.Traduction.Items[158]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem5.Caption:=AnsitoUTF8(Principale.Traduction.Items[239]);
  MenuItem7.Caption:=AnsitoUTF8(Principale.Traduction.Items[246]);
  MenuItem8.Caption:=AnsitoUTF8(Principale.Traduction.Items[223]);
  MenuItem9.Caption:=AnsitoUTF8(Principale.Traduction.Items[247]);
  MyCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Principale.ProgressBar.Position:=0;
  Principale.ProgressBar.Visible:=True;
  Application.Processmessages;
  Principale.Query1.SQL.Clear;
//  Principale.Query1.SQL.add('SELECT S.no, S.T, S.D, S.M, S.A, S.Q, COUNT(C.S) FROM S LEFT JOIN C on C.S=S.no GROUP by S.no');
  Principale.Query1.SQL.add('SELECT S.no, S.T, S.D, S.M, S.A, S.Q FROM S ORDER BY S.no');
  Principale.Query1.Open;
  Principale.Query1.First;
  TableauSources.RowCount:=Principale.Query1.RecordCount+1;
  Principale.ProgressBar.Max:=TableauSources.RowCount;
  i:=0;
  While not Principale.Query1.Eof do
     begin
     i:=i+1;
     TableauSources.Cells[0,i]:='0';
     TableauSources.Cells[1,i]:=Principale.Query1.Fields[0].AsString;
     TableauSources.Cells[2,i]:=Principale.Query1.Fields[1].AsString;
     TableauSources.Cells[3,i]:=Principale.Query1.Fields[2].AsString;
     TableauSources.Cells[4,i]:=Principale.Query1.Fields[3].AsString;
     TableauSources.Cells[5,i]:=Principale.Query1.Fields[4].AsString;
     TableauSources.Cells[6,i]:=Principale.Query1.Fields[5].AsString;
//     TableauSources.Cells[7,i]:=Principale.Query1.Fields[6].AsString;
     TableauSources.Cells[7,i]:='?';
     temp:=TableauSources.Cells[5,i];
     if (length(temp)>0) then
        if (temp[1] in ['0'..'9']) then
           if StrtoInt(temp)>0 then
              begin
              Principale.Query2.SQL.Clear;
              Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+temp);
              Principale.Query2.Open;
              TableauSources.Cells[5,i]:=DecodeName(Principale.Query2.Fields[1].AsString,1)+
                                         ' ('+temp+')';
              TableauSources.Cells[0,i]:=temp;
           end;
     Principale.Query1.Next;
     Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
     Application.ProcessMessages;
  end;
  Principale.ProgressBar.Visible:=False;
  Screen.Cursor := MyCursor;
End;

procedure TFormSources.MenuItem2Click(Sender: TObject);
begin
  // Ajouter une source
  PutCode('S','0');
  PutCode('A','0');
  if EditSource.Showmodal = mrOK then
     Formshow(Sender);
end;

procedure TFormSources.MenuItem4Click(Sender: TObject);
begin
  // Supprimer une source
  if TableauSources.Row>0 then
     if TableauSources.Cells[7,TableauSources.Row]='0' then
        if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[132])+
              TableauSources.Cells[2,TableauSources.Row]+
              AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
           begin
           // Supprimer tous les exhibits et association dépots de cette source
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM X WHERE A=''S'' AND N='+TableauSources.Cells[1,TableauSources.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM A WHERE S='+TableauSources.Cells[1,TableauSources.Row]);
           Principale.Query1.ExecSQL;
           Principale.Query1.SQL.Clear;
           Principale.Query1.SQL.Add('DELETE FROM S WHERE no='+TableauSources.Cells[1,TableauSources.Row]);
           Principale.Query1.ExecSQL;
           TableauSources.DeleteRow(TableauSources.Row);
        end;
end;

procedure TFormSources.MenuItem7Click(Sender: TObject);
begin
  TableauSources.SortColRow(true,1);
end;

procedure TFormSources.MenuItem8Click(Sender: TObject);
begin
  if TableauSources.Cells[7,TableauSources.Row]='?' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.add('SELECT COUNT(C.S) FROM S LEFT JOIN C on C.S=S.no WHERE S.no='+
               TableauSources.Cells[1,TableauSources.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     TableauSources.Cells[7,TableauSources.Row]:=Principale.Query1.Fields[0].AsString;
  end
  else
     begin
     PutCode('S',TableauSources.Cells[2,TableauSources.Row]);
     FormUtilisation.ShowModal;
  end;
end;

procedure TFormSources.MenuItem9Click(Sender: TObject);
begin
  TableauSources.SortColRow(true,2);
end;

procedure TFormSources.TableauSourcesDblClick(Sender: TObject);
var
  temp:string;
  auteur:boolean;
begin
  PutCode('S','0');
  if TableauSources.Row>0 then
     begin
     If EditSource.Showmodal=mrOK then
        // Ne pas repopuler toute la table, seulement la source modifiée.
        // FormShow(Sender);
       begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.add('SELECT S.no, S.T, S.D, S.M, S.A, S.Q, COUNT(C.S) FROM S JOIN C on C.S=S.no WHERE S.no='+
                                  TableauSources.Cells[1,TableauSources.Row]);
        Principale.Query1.Open;
        Principale.Query1.First;
        TableauSources.Cells[1,TableauSources.Row]:=Principale.Query1.Fields[0].AsString;
        TableauSources.Cells[2,TableauSources.Row]:=Principale.Query1.Fields[1].AsString;
        TableauSources.Cells[3,TableauSources.Row]:=Principale.Query1.Fields[2].AsString;
        TableauSources.Cells[4,TableauSources.Row]:=Principale.Query1.Fields[3].AsString;
        TableauSources.Cells[5,TableauSources.Row]:=Principale.Query1.Fields[4].AsString;
        TableauSources.Cells[6,TableauSources.Row]:=Principale.Query1.Fields[5].AsString;
        TableauSources.Cells[7,TableauSources.Row]:=Principale.Query1.Fields[6].AsString;
        temp:=TableauSources.Cells[5,TableauSources.Row];
        auteur:=false;
        if (length(temp)>0) then
           if (temp[1] in ['0'..'9']) then
              auteur:=(StrtoInt(temp)>0);
        if auteur then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+temp);
           Principale.Query2.Open;
           TableauSources.Cells[5,TableauSources.Row]:=DecodeName(Principale.Query2.Fields[1].AsString,1)+
                                                       ' ('+temp+')';
           TableauSources.Cells[0,TableauSources.Row]:=temp;
        end;
     end;
  end;
  //  if StrToInt(TableauSources.Cells[0,TableauSources.Row])>0 then
  //     Principale.Individu.Text:=TableauSources.Cells[0,TableauSources.Row];
end;

procedure TFormSources.TableauSourcesEditingDone(Sender: TObject);
var
  temp:string;
  auteur:boolean;
begin
  Principale.Query1.SQL.Clear;
  temp:=(Sender as TStringGrid).Cells[5,(Sender as TStringGrid).Row];
  auteur:=false;
  if (length(temp)>0) then
     if (temp[1] in ['0'..'9']) then
        auteur:=StrtoInt(temp)>0;
  if (not auteur) and (strtoint((Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row])>0) then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+(Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row]);
     Principale.Query2.Open;
     auteur:=(DecodeName(Principale.Query2.Fields[1].AsString,1)+' ('+(Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row]+')')=
             ((Sender as TStringGrid).Cells[5,(Sender as TStringGrid).Row]);
     temp:=(Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row];
     end;
  if auteur then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.add('SELECT N.I, N.N FROM N WHERE N.X=1 AND N.I='+temp);
     Principale.Query2.Open;
     (Sender as TStringGrid).Cells[5,(Sender as TStringGrid).Row]:=DecodeName(Principale.Query2.Fields[1].AsString,1)+
                                                                   ' ('+temp+')';
     (Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row]:=temp;
     Principale.Query1.SQL.Add('UPDATE S SET T='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[2,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
        ''', D='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[3,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
        ''', M='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[4,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
        ''', A='''+(Sender as TStringGrid).Cells[0,(Sender as TStringGrid).Row]+
        ''', Q='+(Sender as TStringGrid).Cells[6,(Sender as TStringGrid).Row]+
        ' WHERE no='+(Sender as TStringGrid).Cells[1,(Sender as TStringGrid).Row]);
  end
  else
     Principale.Query1.SQL.Add('UPDATE S SET T='''+
       AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[2,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
       ''', D='''+
       AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[3,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
       ''', M='''+
       AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[4,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
       ''', A='''+
       AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr((Sender as TStringGrid).Cells[5,(Sender as TStringGrid).Row],'\','\\'),'"','\"'),'''','\''')+
       ''', Q='+(Sender as TStringGrid).Cells[6,(Sender as TStringGrid).Row]+
       ' WHERE no='+(Sender as TStringGrid).Cells[1,(Sender as TStringGrid).Row]);
  Principale.Query1.ExecSQL;
end;

end.

