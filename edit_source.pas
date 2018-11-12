unit Edit_Source;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Spin, Menus, FMUtils, StrUtils, LCLType, Process, IniFiles;

type

  { TEditSource }

  TEditSource = class(TForm)
    A: TEdit;
    Ajouter1: TMenuItem;
    Ajouter2: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Label11: TLabel;
    Label12: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem9: TMenuItem;
    Modifier1: TMenuItem;
    Modifier2: TMenuItem;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Q: TSpinEdit;
    Supprimer1: TMenuItem;
    Supprimer2: TMenuItem;
    TableauExhibits: TStringGrid;
    Titre: TEdit;
    Label10: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    M: TMemo;
    No: TEdit;
    NomA: TEdit;
    Desc: TEdit;
    TableauDepots: TStringGrid;
    procedure AEditingDone(Sender: TObject);
    procedure Ajouter1Click(Sender: TObject);
    procedure Ajouter2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MEditingDone(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure Modifier2Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Supprimer2Click(Sender: TObject);
    procedure TableauDepotsDblClick(Sender: TObject);
    procedure TableauDepotsEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure PopulateDepots;

var
  EditSource: TEditSource;

implementation

uses
  unit1, sources, utilisation, exhibits, show_image, edit_exhibits;

{ TEditSource }

procedure PopulateDepots;
var
  i:integer;
begin
     // Populate les dépots
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT A.no, A.S, A.D, A.M, D.T FROM A JOIN D ON D.no=A.D WHERE A.S='+EditSource.no.text);
     Principale.Query1.Open;
     Principale.Query1.First;
     EditSource.TableauDepots.RowCount:=Principale.Query1.RecordCount+1;
     i:=1;
     while not Principale.Query1.eof do
        begin
        EditSource.TableauDepots.Cells[0,i]:=Principale.Query1.Fields[0].AsString;
        EditSource.TableauDepots.Cells[1,i]:=Principale.Query1.Fields[4].AsString;
        EditSource.TableauDepots.Cells[2,i]:=Principale.Query1.Fields[3].AsString;
        EditSource.TableauDepots.Cells[3,i]:=Principale.Query1.Fields[2].AsString;
        Principale.Query1.Next;
        i:=i+1;
     end;
end;

procedure TEditSource.FormShow(Sender: TObject);
var
  temp, code, nocode:string;
  auteur:boolean;
begin
  EditSource.ActiveControl:=EditSource.Titre;
  Principale.DataHist.Row:=0;
  Caption:=AnsitoUTF8(Principale.Traduction.Items[190]);
  Button1.Caption:=AnsitoUTF8(Principale.Traduction.Items[152]);
  Button2.Caption:=AnsitoUTF8(Principale.Traduction.Items[164]);
  Label3.Caption:=AnsitoUTF8(Principale.Traduction.Items[171]);
  Label7.Caption:=AnsitoUTF8(Principale.Traduction.Items[193]);
  Label8.Caption:=AnsitoUTF8(Principale.Traduction.Items[191]);
  Label9.Caption:=AnsitoUTF8(Principale.Traduction.Items[162]);
  Label10.Caption:=AnsitoUTF8(Principale.Traduction.Items[179]);
  Label11.Caption:=AnsitoUTF8(Principale.Traduction.Items[192]);
  Label12.Caption:=AnsitoUTF8(Principale.Traduction.Items[298]);
  TableauDepots.Cells[1,0]:=AnsitoUTF8(Principale.Traduction.Items[194]);
  TableauDepots.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[156]);
  TableauExhibits.Cells[2,0]:=AnsitoUTF8(Principale.Traduction.Items[154]);
  TableauExhibits.Cells[4,0]:=AnsitoUTF8(Principale.Traduction.Items[201]);
  Ajouter1.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier1.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer1.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  Ajouter2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  Modifier2.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  Supprimer2.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem1.Caption:=AnsitoUTF8(Principale.Traduction.Items[233]);
  MenuItem2.Caption:=AnsitoUTF8(Principale.Traduction.Items[224]);
  MenuItem3.Caption:=AnsitoUTF8(Principale.Traduction.Items[225]);
  MenuItem4.Caption:=AnsitoUTF8(Principale.Traduction.Items[226]);
  MenuItem10.Caption:=AnsitoUTF8(Principale.Traduction.Items[181]);
  // Populate la form
  Principale.Query1.SQL.Clear;
  GetCode(Code,nocode);
  if code='A' then
     begin
     EditSource.Caption:=AnsitoUTF8(Principale.Traduction.Items[43]);
     Titre.Text:='';
     Desc.Text:='';
     A.Text:='';
     NomA.Text:='';
     M.Text:='';
     Q.Value:=0;
     TableauDepots.RowCount:=1;
     TableauExhibits.RowCount:=1;
     No.Text:='0';
  end
  else
     begin
     if code='S' then
        Principale.Query1.SQL.Add('SELECT S.no, S.T, S.D, S.M, S.Q, S.A FROM S WHERE S.no='+
                                     FormSources.TableauSources.Cells[1,FormSources.TableauSources.Row])
     else
        Principale.Query1.SQL.Add('SELECT S.no, S.T, S.D, S.M, S.Q, S.A FROM S WHERE S.no='+
                                     FormUtilisation.TableauUtilisation.Cells[0,FormUtilisation.TableauUtilisation.Row]);
     Principale.Query1.Open;
     Principale.Query1.First;
     No.Text:=Principale.Query1.Fields[0].AsString;
     Titre.Text:=Principale.Query1.Fields[1].AsString;
     Desc.Text:=Principale.Query1.Fields[2].AsString;
     temp:=Principale.Query1.Fields[5].AsString;
     auteur:=false;
     if (length(temp)>0) then
        if (temp[1] in ['0'..'9']) then
           auteur:=(StrtoInt(temp)>0);
     if auteur then
        begin
        A.Text:=temp;
        Principale.Query2.SQL.Clear;
        Principale.Query2.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+A.Text);
        Principale.Query2.Open;
        Principale.Query2.First;
        NomA.Text:=DecodeName(Principale.Query2.Fields[0].AsString,1);
        NomA.ReadOnly:=true;
     end
     else
        begin
        A.Text:='0';
        NomA.Text:=temp;
        NomA.ReadOnly:=false;
     end;
     M.Text:=Principale.Query1.Fields[3].AsString;
     Q.Value:=Principale.Query1.Fields[4].AsInteger;
     // Populate les dépots
     PopulateDepots;
     // Populate le tableau de documents
     PopulateExhibits(TableauExhibits,'S',No.Text);
  end;
end;

procedure TEditSource.MEditingDone(Sender: TObject);
begin
  Principale.DataHist.InsertColRow(false,0);
  Principale.DataHist.Cells[0,0]:='M';
  Principale.DataHist.Cells[1,0]:=M.Text;
end;

procedure TEditSource.MenuItem10Click(Sender: TObject);
var
  ini:TIniFile;
  pdf:string;
begin
  // Visualiser un document de la source
  if TableauExhibits.Row>0 then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT X.Z, X.F FROM X WHERE X.no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
     Principale.Query2.Open;
     if TableauExhibits.Cells[4,TableauExhibits.Row]=AnsitoUTF8(Principale.Traduction.Items[34]) then
        begin
        ShowImage.Caption:=AnsitoUTF8(Principale.Traduction.Items[34]);
        ShowImage.Image.Visible:=false;
        ShowImage.Memo.Visible:=true;
        ShowImage.Button1.Visible:=true;
        ShowImage.Button2.Visible:=true;
        ShowImage.Memo.Text:=Principale.Query2.Fields[0].AsString;
        if ShowImage.Showmodal=mrOk then
           begin
           Principale.Query2.SQL.Clear;
           Principale.Query2.SQL.Add('UPDATE X SET Z='''+
              AnsiReplaceStr(AnsiReplaceStr(ShowImage.Memo.Text,'"','\"'),'''','\''')+
              ''' WHERE X.no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
           Principale.Query2.ExecSQL;
        end;
     end
     else
        begin
        if AnsiPos('.PDF',Principale.Query2.Fields[1].AsString)>0 then
           begin
           Ini := TIniFile.Create('Stemma.ini');
           pdf := ini.ReadString('Parametres','PDF','C:\Program Files (x86)\Adobe\Reader 10.0\Reader\AcroRd32.exe');
           with TProcess.Create(nil) do
           try
              CommandLine:=pdf+' '+Principale.Query2.Fields[1].AsString;
              Execute;
              ini.WriteString('Parametres','PDF',pdf);
           finally
              Free;
           end;
           Ini.Free;
        end
        else
           begin
           ShowImage.Caption:=Principale.Query2.Fields[1].AsString;
           ShowImage.Memo.Visible:=false;
           ShowImage.Button1.Visible:=false;
           ShowImage.Button2.Visible:=false;
           ShowImage.Image.Visible:=true;
           ShowImage.Image.Picture.LoadFromFile(Principale.Query2.Fields[1].AsString);
           ShowImage.Showmodal;
        end;
     end;
  end;
end;

procedure TEditSource.MenuItem5Click(Sender: TObject);
begin
  Button1Click(Sender);
  ModalResult:=mrOk;
end;

procedure TEditSource.MenuItem6Click(Sender: TObject);
var
  j:integer;
  found:boolean;
begin
  if EditSource.ActiveControl.Name='M' then
     begin
     found:=false;
     For j:=Principale.DataHist.Row to Principale.DataHist.RowCount-1 do
        begin
        if Principale.DataHist.Cells[0,j]='M' then
           begin
           M.text:=Principale.DataHist.Cells[1,j];
           found:=true;
           break;
        end;
     end;
     if not found then
        begin
        For j:=0 to Principale.DataHist.RowCount-1 do
           begin
           if Principale.DataHist.Cells[0,j]='M' then
              begin
              M.text:=Principale.DataHist.Cells[1,j];
              found:=true;
              break;
           end;
        end;
     end;
  end;
end;

procedure TEditSource.Modifier2Click(Sender: TObject);
begin
  // Modifier un document à la source
  If TableauExhibits.Row>0 then
     begin
     PutCode('S',TableauExhibits.Cells[0,TableauExhibits.Row]);
     If EditExhibits.Showmodal=mrOK then
        PopulateExhibits(TableauExhibits,'S',no.text);
     end;
end;

procedure TEditSource.Supprimer1Click(Sender: TObject);
begin
  // Supprimer un Dépot
  if TableauDepots.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[44])+
        TableauDepots.Cells[1,TableauDepots.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM A WHERE no='+TableauDepots.Cells[0,TableauDepots.Row]);
        Principale.Query1.ExecSQL;
        TableauDepots.DeleteRow(TableauDepots.Row);
     end;
end;

procedure TEditSource.Supprimer2Click(Sender: TObject);
begin
  // Supprimer un document à la source
  If TableauExhibits.Row>0 then
     if Application.MessageBox(Pchar(AnsitoUTF8(Principale.Traduction.Items[60])+
        TableauExhibits.Cells[2,TableauExhibits.Row]+AnsitoUTF8(Principale.Traduction.Items[28])),pchar(AnsitoUTF8(Principale.Traduction.Items[1])),MB_YESNO)=IDYES then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('DELETE FROM X WHERE no='+TableauExhibits.Cells[0,TableauExhibits.Row]);
        Principale.Query1.ExecSQL;
        TableauExhibits.DeleteRow(TableauExhibits.Row);
     end;
end;

procedure TEditSource.TableauDepotsDblClick(Sender: TObject);
var
  d:string;
begin
  // modification d'un dépot
  if TableauDepots.Row>0 then
     begin
     d:='0';
     if InputQuery(AnsitoUTF8(Principale.Traduction.Items[45]),AnsitoUTF8(Principale.Traduction.Items[46]),d) then
        begin
        Principale.Query1.SQL.Clear;
        Principale.Query1.SQL.Add('SELECT D.T FROM D WHERE D.no='+d);
        Principale.Query1.Open;
        Principale.Query1.First;
        if not Principale.Query1.EOF then
           begin
           TableauDepots.Cells[1,TableauDepots.Row]:=Principale.Query1.Fields[0].AsString;
           TableauDepots.Cells[3,TableauDepots.Row]:=d;
           TableauDepotsEditingDone(Sender);
           PopulateDepots;
        end;
     end;
  end;
end;

procedure TEditSource.AEditingDone(Sender: TObject);
var
  temp:string;
  auteur:boolean;
begin
  temp:=A.Text;
  auteur:=false;
  if length(temp)>0 then
     if (temp[1] in ['0'..'9']) then
        if StrtoInt(A.text)>0 then
           auteur:=true;
  if auteur then
     begin
     Principale.Query2.SQL.Clear;
     Principale.Query2.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+A.Text);
     Principale.Query2.Open;
     Principale.Query2.First;
     NomA.Text:=DecodeName(Principale.Query2.Fields[0].AsString,1);
     NomA.ReadOnly:=true;
  end
  else
     begin
     A.text:='0';
     NomA.ReadOnly:=false;
  end;
end;

procedure TEditSource.Ajouter1Click(Sender: TObject);
var
  d:string;
begin
  // Ajouter un dépot
  d:='0';
  if InputQuery(AnsitoUTF8(Principale.Traduction.Items[47]),AnsitoUTF8(Principale.Traduction.Items[46]),d) then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SELECT D.T FROM D WHERE D.no='+d);
     Principale.Query1.Open;
     Principale.Query1.First;
     if not Principale.Query1.EOF then
        begin
        TableauDepots.RowCount:=TableauDepots.RowCount+1;
        TableauDepots.Row:=TableauDepots.RowCount;
        TableauDepots.Cells[0,TableauDepots.Row]:='0';
        TableauDepots.Cells[1,TableauDepots.Row]:=Principale.Query1.Fields[0].AsString;
        TableauDepots.Cells[2,TableauDepots.Row]:='';
        TableauDepots.Cells[3,TableauDepots.Row]:=d;
        TableauDepotsEditingDone(Sender);
        PopulateDepots;
     end;
  end;
end;

procedure TEditSource.Ajouter2Click(Sender: TObject);
begin
  // Ajouter un document à la source
  If no.text='0' then
     Button1Click(Sender);
  PutCode('S',no.text);
  PutCode('A',no.text);
  If EditExhibits.Showmodal=mrOK then
     PopulateExhibits(TableauExhibits,'S',no.text);
end;

procedure TEditSource.Button1Click(Sender: TObject);
var
  temp:string;
  auteur:boolean;
begin
  Principale.Query1.SQL.Clear;
  temp:=A.Text;
  auteur:=false;
  if (length(temp)>0) then
     if (temp[1] in ['0'..'9']) then
        auteur:=StrtoInt(temp)>0;
  if no.text='0' then
     begin
     if auteur then
        Principale.Query1.SQL.Add('INSERT INTO S (T, D, M, A, Q) VALUES ('''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Titre.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Desc.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(M.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+A.text+''', '+InttoStr(Q.Value)+')')
     else
        Principale.Query1.SQL.Add('INSERT INTO S (T, D, M, A, Q) VALUES ('''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Titre.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Desc.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(M.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(NomA.text,'\','\\'),'"','\"'),'''','\''')+
           ''', '+InttoStr(Q.Value)+')');
  end
  else
    begin
     if auteur then
        Principale.Query1.SQL.Add('UPDATE S SET T='''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Titre.text,'\','\\'),'"','\"'),'''','\''')+
           ''', D='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Desc.text,'\','\\'),'"','\"'),'''','\''')+
           ''', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(M.text,'\','\\'),'"','\"'),'''','\''')+
           ''', A='''+A.text+''', Q='+InttoStr(Q.Value)+' WHERE no='+no.text)
     else
        Principale.Query1.SQL.Add('UPDATE S SET T='''+
           AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Titre.text,'\','\\'),'"','\"'),'''','\''')+
           ''', D='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Desc.text,'\','\\'),'"','\"'),'''','\''')+
           ''', M='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(M.text,'\','\\'),'"','\"'),'''','\''')+
           ''', A='''+AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(NomA.text,'\','\\'),'"','\"'),'''','\''')+
           ''', Q='+InttoStr(Q.Value)+' WHERE no='+no.text);
    end;
  Principale.Query1.ExecSQL;
  if no.text='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''S''');
     Principale.Query1.Open;
     Principale.Query1.First;
     no.text:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
end;

procedure TEditSource.DescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F3 then
     Desc.Text:=Titre.Text;
end;


procedure TEditSource.TableauDepotsEditingDone(Sender: TObject);
begin
  if no.text='0' then
     button1click(Sender);
  Principale.Query1.SQL.Clear;
  if TableauDepots.Cells[0,TableauDepots.Row]='0' then
     Principale.Query1.SQL.Add('INSERT INTO A (S, D, M) VALUES ('+No.Text+', '+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[3,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+', '''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
        ''')')
  else
     Principale.Query1.SQL.Add('UPDATE A SET M='''+
        AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(TableauDepots.Cells[2,TableauDepots.Row],'\','\\'),'"','\"'),'''','\''')+
        ''', D='+TableauDepots.Cells[3,TableauDepots.Row]+
        ' WHERE no='+TableauDepots.Cells[0,TableauDepots.Row]);
  Principale.Query1.ExecSQL;
  if TableauDepots.Cells[0,TableauDepots.Row]='0' then
     begin
     Principale.Query1.SQL.Clear;
     Principale.Query1.SQL.Add('SHOW TABLE STATUS WHERE NAME=''A''');
     Principale.Query1.Open;
     Principale.Query1.First;
     TableauDepots.Cells[0,TableauDepots.Row]:=InttoStr(Principale.Query1.Fields[10].AsInteger-1);
  end;
end;

{ TEditSource }


{$R *.lfm}

end.

