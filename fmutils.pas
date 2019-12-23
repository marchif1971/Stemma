unit FMUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, IniFiles, Grids, StrUtils, Math, Dialogs, LCLType;

procedure SaveFormPosition(Sender: TForm);
procedure SaveGridPosition(Sender: TStringGrid;cols: integer);
procedure GetGridPosition(Sender: TStringGrid;cols: integer);
procedure GetFormPosition(Sender: TForm;a:integer;b:integer;c:integer;d:integer);
procedure SaveModificationTime(no:string);
procedure PopulateCitations(Tableau:TStringGrid;Code:string;No:string);
function DecodeName(Name:string;format:byte):string;
function CodeName(Titre:string;Prenom:string;Nom:string;suffixe:string):string;
function DecodeLieu(Lieu:string):string;
function EstimatePlace(lieu:string;registre:string):string;
function ConvertDate(Date:string;format:byte):string;
function RemoveUTF8(text:string):string;
function DecodePhrase(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string):string;
function DecodePhraseTMG(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string):string;
function DecodePhraseStemma(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string;char:integer):string;
function CalculAge(Date1:string;Date2:string;format:byte):string;
function InterpreteDate(Date:string;format:byte):string;
function getI3(no:string):string;
function getI4(no:string):string;
function getName(no:string):string;
procedure GetCode(out code:string;out no:string);
procedure PutCode(code:string;no:string);
procedure Ecrit_Interet(no:string;maxint:integer;generation:integer);
procedure SosaStradonitz(no:string;sosa:int64;typerapport:integer;generation:integer);

implementation

uses
  unit1,noms,ZoneTampon;

procedure Ecrit_Interet(no:string;maxint:integer;generation:integer);
var
   Form: TForm;
   suivant1,suivant2 :string;
   row:integer;
begin
   // Écrit le maxint dans la personne en question
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.add('UPDATE I SET I=9 WHERE no='+no);
   Principale.Query1.ExecSQL;
   If principale.ProgressBar.Max > 0 then
      begin
      Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
      Application.ProcessMessages;
   end;
   if generation>0 then
      begin
      suivant1:='0';
      suivant2:='0';
      // Trouve un parent
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.add('SELECT R.B, I.I FROM R JOIN I ON R.B=I.NO WHERE R.X=1 AND R.A='+no);
      Principale.Query1.Open;
      if (not Principale.Query1.EOF) and (not (Principale.Query1.Fields[1].AsString='9'))  then
         suivant1:=Principale.Query1.Fields[0].AsString
      else
         If principale.ProgressBar.Max > 0 then
            Principale.ProgressBar.Position:=Principale.ProgressBar.Position+round(power(2, generation-1));
      // trouve l'autre parent
      Principale.Query1.Next;
      if (not Principale.Query1.EOF) and (not (Principale.Query1.Fields[1].AsString='9'))  then
         suivant2:=Principale.Query1.Fields[0].AsString
      else
         If principale.ProgressBar.Max > 0 then
            Principale.ProgressBar.Position:=Principale.ProgressBar.Position+round(power(2, generation-1));
      if strtoint(suivant1)>0 then
         Ecrit_Interet(suivant1,maxint,generation-1);
      if strtoint(suivant2)>0 then
         Ecrit_Interet(suivant2,maxint,generation-1);
   end
   else
   begin
      // ajoute au tampon les ancêtres suivants non traités
      // doit vérifier qu'une zone tampon existe
      Principale.Query1.SQL.Clear;
      Principale.Query1.SQL.add('SELECT N.no, N.I, N, I1, I2, I3, I4, N.X, I.I FROM R JOIN I ON R.B=I.NO JOIN N on R.B=N.I WHERE R.X=1 AND N.X=1 AND R.A='+no);
      Principale.Query1.Open;
      while not Principale.Query1.EOF do
         begin
         if not (Principale.Query1.Fields[8].AsString='9') then
            begin
            // Doit trouver le premier FormTampon !!!
            Form := Application.FindComponent('FormTampon') as TForm;
            row:=(Form as TFormTampon).Tampon.RowCount;
            (Form as TFormTampon).Tampon.RowCount:=(Form as TFormTampon).Tampon.RowCount+1;
            (Form as TFormTampon).Tampon.Cells[0,row]:=Principale.Query1.Fields[0].AsString;
            (Form as TFormTampon).Tampon.Cells[1,row]:=Principale.Query1.Fields[1].AsString;
            (Form as TFormTampon).Tampon.Cells[2,row]:=DecodeName(Principale.Query1.Fields[2].AsString,2);
            (Form as TFormTampon).Tampon.Cells[3,row]:=ConvertDate(Principale.Query1.Fields[5].AsString,1);
            (Form as TFormTampon).Tampon.Cells[4,row]:=ConvertDate(Principale.Query1.Fields[6].AsString,1);
            if Principale.Query1.Fields[7].AsBoolean then
               begin
               if (Principale.Query1.Fields[8].AsString='9') then
                  (Form as TFormTampon).Tampon.Cells[5,row]:='9*'
               else
                  (Form as TFormTampon).Tampon.Cells[5,row]:='*'
               end
            else
               begin
                  if (Principale.Query1.Fields[8].AsString='9') then
                     (Form as TFormTampon).Tampon.Cells[5,row]:='9'
                  else
                     (Form as TFormTampon).Tampon.Cells[5,row]:='';
            end;
            (Form as TFormTampon).Tampon.Cells[6,row]:=RemoveUTF8(Principale.Query1.Fields[3].AsString)+', '+RemoveUTF8(Principale.Query1.Fields[4].AsString);
            Application.ProcessMessages;
         end;
         Principale.Query1.Next;
      end;
   end;
end;

procedure SosaStradonitz(no:string;sosa:int64;typerapport:integer;generation:integer);
var
   suivant1,suivant2,naissance,deces:string;
begin
   // Vérifie si la personne déjà dans T1
   Principale.Query1.SQL.Clear;
   Principale.Query1.SQL.add('SELECT I, S FROM T1 WHERE I='+no);
   Principale.Query1.Open;
   If Principale.Query1.EOF then
      // si non Écrit dans t1 la personne en question et écrit dans rapport
      begin
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.add('INSERT INTO t1 (i, s) VALUES ('+no+', '+inttostr(sosa)+')');
      Principale.Query2.ExecSQL;
      // Écrit dans rapport (t2)
      Principale.Query3.SQL.Clear;
      Principale.Query3.SQL.add('SELECT N.I, N, I3, I4 FROM N WHERE N.X=1 AND N.I='+no);
      Principale.Query3.Open;
      if Copy(Principale.Query3.Fields[2].AsString,1,1)='1' then
         naissance:=Copy(Principale.Query3.Fields[2].AsString,2,4)
      else
         naissance:='';
      if Copy(Principale.Query3.Fields[3].AsString,1,1)='1' then
         deces:=Copy(Principale.Query3.Fields[3].AsString,2,4)
      else
         deces:='';
      Principale.Query2.SQL.Clear;
      if typerapport=1 then
         Principale.Query2.SQL.add('INSERT INTO t2 (i, s, t) VALUES ('+no+', '+inttostr(sosa)+', ''<DD>'+inttostr(sosa)+
                '. <A HREF=http://genealogie.quebec/info/index.php?no='+no+'>'+AnsiReplaceStr(DecodeName(Principale.Query3.Fields[1].AsString,1),'''','\''')+
                ' ['+no+'] ('+naissance+' - '+deces+')</A></DD>'')');
      Principale.Query2.ExecSQL;
      If principale.ProgressBar.Max > 0 then
         begin
         Principale.ProgressBar.Position:=Principale.ProgressBar.Position+1;
         Application.ProcessMessages;
      end;
      if generation>0 then
         begin
         suivant1:='0';
         suivant2:='0';
         // Trouve un parent
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.add('SELECT R.B, I.I FROM R JOIN I ON R.B=I.NO WHERE R.X=1 AND I.S=''M'' AND R.A='+no);
         Principale.Query2.Open;
         if (not Principale.Query2.EOF)  then
            suivant1:=Principale.Query2.Fields[0].AsString
         else
            If principale.ProgressBar.Max > 0 then
               Principale.ProgressBar.Position:=Principale.ProgressBar.Position+round(power(2, generation-1));
         // trouve l'autre parent
         Principale.Query2.SQL.Clear;
         Principale.Query2.SQL.add('SELECT R.B, I.I FROM R JOIN I ON R.B=I.NO WHERE R.X=1 AND I.S=''F'' AND R.A='+no);
         Principale.Query2.Open;
         if (not Principale.Query2.EOF)  then
            suivant2:=Principale.Query2.Fields[0].AsString
         else
            If principale.ProgressBar.Max > 0 then
               Principale.ProgressBar.Position:=Principale.ProgressBar.Position+round(power(2, generation-1));
         if strtoint(suivant1)>0 then
            SosaStradonitz(suivant1,sosa*2,typerapport,generation-1);
         if strtoint(suivant2)>0 then
            SosaStradonitz(suivant2,sosa*2+1,typerapport,generation-1);
      end;
   end
   else
      begin
      // si oui, écrit référence dans rapport (t2)
      Principale.Query2.SQL.Clear;
      Principale.Query2.SQL.add('INSERT INTO t2 (i, s, t) VALUES ('+no+', '+inttostr(sosa)+', ''<DD>'+inttostr(sosa)+'. voir #'+Principale.Query1.Fields[1].AsString+'</DD>'')');
      Principale.Query2.ExecSQL;
      If principale.ProgressBar.Max > 0 then
         Principale.ProgressBar.Position:=Principale.ProgressBar.Position+round(power(2, generation));
   end;
end;

procedure GetCode(out code:string;out no:string);
begin
   If Principale.Filo.RowCount>0 then
      begin
      code:=Principale.Filo.Cells[0,0];
      no:=Principale.Filo.Cells[1,0];
      Principale.Filo.DeleteRow(0);
   end
   else
      begin
      code:='';
      no:='0';
   end;
end;

procedure PutCode(code:string;no:string);
begin
   Principale.Filo.InsertColRow(false,0);
   Principale.Filo.Cells[0,0]:=code;
   Principale.Filo.Cells[1,0]:=no;
end;

procedure PopulateCitations(Tableau:TStringGrid;Code:string;No:string);
var
   row:integer;
begin
   // Populate le tableau de citations
   Principale.Query2.SQL.Clear;
   Principale.Query2.SQL.Add('SELECT C.no, S.T, C.M, C.Q FROM C JOIN S ON C.S=S.no WHERE C.Y='''+code+''' AND C.N='+No);
   Principale.Query2.Open;
   Principale.Query2.First;
   row:=1;
   Tableau.RowCount:=Principale.Query2.RecordCount+1;
   while not Principale.Query2.EOF do
      begin
      Tableau.Cells[0,row]:=Principale.Query2.Fields[0].AsString;
      Tableau.Cells[1,row]:=Principale.Query2.Fields[1].AsString;
      Tableau.Cells[2,row]:=Principale.Query2.Fields[2].AsString;
      Tableau.Cells[3,row]:=Principale.Query2.Fields[3].AsString;
      Principale.Query2.Next;
      row:=row+1;
   end;
end;

function InterpreteDate(Date:string;format:byte):string;
var
   annee1, mois1, jour1, annee2, mois2, jour2, style, Original, bc1, bc2, temp: string;
   i, len: integer;
   valid: boolean;
   tmpSep1, tmpSep2: integer;
   test:TDateTime;
begin
   // Doit accepter les années négatives
   Original:=Date;
   // Doit accepter année, mois et jour '...'
   while AnsiPos('...',Date)>0 do
      Date:=Copy(Date,1,AnsiPos('...',Date)-1)+'00'+Copy(Date,AnsiPos('...',Date)+3,length(Date));
   if length(Date)=0 then
      if format=1 then
         InterpreteDate:='100000000030000000000'
      else
         InterpreteDate:=''
   else
      begin
      style:='3';
      if (Copy(Date,1,3)='av.') then
         begin
         Date:=Copy(Date,4,length(Date));
         style:='0';
      end;
      if (Copy(Date,1,3)='ap.') then
         begin
         Date:=Copy(Date,4,length(Date));
         style:='4';
      end;
      if (Copy(Date,1,1)='<') then
         begin
         Date:=Copy(Date,2,length(Date));
         style:='0';
      end;
      if (lowercase(Copy(Date,1,1))='c') or (lowercase(Copy(Date,1,1))='v') then
         begin
         Date:=Copy(Date,2,length(Date));
         style:='1';
      end;
      if (Copy(Date,1,1)='>') then
         begin
         Date:=Copy(Date,2,length(Date));
         style:='4';
      end;
      while (Date[1]='.') or (Date[1]=' ') do Date:=Copy(Date,2,length(Date));
      // extract year, month, day
      bc1:='';
      if (Date[1]='-') then
         begin
         bc1:='-';
         Date:=Copy(Date,2,length(Date));
      end;
      Annee1:='0000';
      Mois1:='00';
      Jour1:='00';
      Valid:=true;
      len:=AnsiPos(' ou',Date)-1;
      if len<=0 then
        len:=AnsiPos(' OU',Date)-1;
      if len<=0 then
        len:=AnsiPos('ou',Date)-1;
      if len<=0 then
        len:=AnsiPos('OU',Date)-1;
      if len<=0 then
        len:=AnsiPos(' -',Date)-1;
      if len<=0 then
        len:=AnsiPos('-',Date)-1;
      if len<=0 then
        len:=AnsiPos(' a',Date)-1;
      if len<=0 then
        len:=AnsiPos(' A',Date)-1;
      if len<=0 then
        len:=AnsiPos(' à',Date)-1;
      if len<=0 then
        len:=AnsiPos(' À',Date)-1;
      if len<=0 then
        len:=AnsiPos('a',Date)-1;
      if len<=0 then
        len:=AnsiPos('A',Date)-1;
      if len<=0 then
        len:=AnsiPos('à',Date)-1;
      if len<=0 then
        len:=AnsiPos('À',Date)-1;
      if len<=0 then
         len:=length(Date);
      tmpSep1 := 0;
      tmpSep2 := 0;
      //validate the position of the date separators, if any, and
      //make sure only date separators and numerics are entered ...
      if len>10 then len:=10;
      for i := 1 to len do
         if (i<=len) and (not (Date[i] in ['0'..'9'])) then
            begin
            if i < 3 then valid:=false
            else if tmpSep1 = 0 then tmpSep1 := i
            else if (i = tmpSep1+1) or (tmpSep2 > 0) then
                    if (i = tmpSep2+1) then valid:=false
                    else len := i-1
            else tmpSep2 := i;
         end;

      //check for other error conditions ...
      if ((tmpSep1 = 0) and not (len in [4,6,8])) or
         ((tmpSep1 > 0) and (tmpSep2 - tmpSep1 > 3)) or (tmpSep2 = len) then
            valid:=false;

      if valid then
         if (tmpSep1 > 0) then
             begin
                if (tmpSep1 < 3) then valid:=false; //must be yy, yyy or yyyy
                if valid then
                   begin
                   annee1 := Copy(Date,1,tmpSep1-1);
                   if tmpSep2=0 then
                      mois1 := Copy(Date,tmpSep1+1,len-tmpSep1)
                   else
                      begin
                      mois1 := Copy(Date,tmpSep1+1,tmpSep2-tmpSep1-1);
                      jour1 := Copy(Date,tmpSep2+1,len-tmpSep2);
                   end;
                end;
             end
         else
            begin
            annee1 := Copy(Date,1,4);
            if len>5 then
               mois1 := Copy(Date,5,2);
            if len>7 then
               jour1 := Copy(Date,7,2);
         end;
      while length(annee1)<4 do annee1:='0'+annee1;
      while length(mois1)<2 do mois1:='0'+mois1;
      while length(jour1)<2 do jour1:='0'+jour1;
      if (bc1='-') then
         begin
         annee1:=IntToStr(StrToInt(annee1)*(-1));
         while length(annee1)<4 do annee1:=Copy(annee1,1,1)+'0'+Copy(annee1,2,length(annee1));
      end;
      Date:=Copy(Date,len+1,Length(Date));
      Annee2:='0000';
      Mois2:='00';
      Jour2:='00';
      if length(Date)>0 then
         begin
         while (Date[1]=' ') do Date:=Copy(Date,2,length(Date));
         // Verify Style of 2nd date
         if (Date[1]='-') then
            begin
            Date:=Copy(Date,2,length(Date));
            style:='5';
         end;
         temp:=RemoveUTF8(Date);
         if (lowercase(temp[1])='a') or (lowercase(temp[1])='à') then
         begin
            Date:=Copy(temp,2,length(Date));
            style:='7';
         end;
         if (lowercase(Copy(Date,1,2))='au') then
            begin
            Date:=Copy(Date,3,length(Date));
            style:='7';
         end;
         if (lowercase(Copy(Date,1,2))='ou') then
            begin
            Date:=Copy(Date,3,length(Date));
            style:='6';
         end;
         if length(date)=0 then valid:=false;
         if valid then
            begin
            while (Date[1]=' ') do Date:=Copy(Date,2,length(Date));
            bc2:='';
            if (Date[1]='-') then
               begin
               bc2:='-';
               Date:=Copy(Date,2,length(Date));
            end;
         end;
         if valid and (StrToInt(style)>4) then
            begin
            // extract year, month, day
            len:=Length(Date);
            tmpSep1 := 0;
            tmpSep2 := 0;
            //validate the position of the date separators, if any, and
            //make sure only date separators and numerics are entered ...
            if len>10 then
               valid:=false
            else
               for i := 1 to len do
                  if not (Date[i] in ['0'..'9']) then
                     begin
                     if i < 3 then valid:=false
                     else if tmpSep1 = 0 then tmpSep1 := i
                     else tmpSep2 := i;
                  end;

            //check for other error conditions ...
            if ((tmpSep1 = 0) and not (len in [4,6,8])) or
               ((tmpSep1 > 0) and (tmpSep2 - tmpSep1 > 3)) or (tmpSep2 = len) then
               valid:=false;

            if valid then
               if (tmpSep1 > 0) then
                  begin
                  if (tmpSep1 < 3) then valid:=false; //must be yy, yyy or yyyy
                     if valid then
                        begin
                        annee2 := Copy(Date,1,tmpSep1-1);
                        if tmpSep2=0 then
                           mois2 := Copy(Date,tmpSep1+1,len-tmpSep1)
                        else
                           begin
                           mois2 := Copy(Date,tmpSep1+1,tmpSep2-tmpSep1-1);
                           jour2 := Copy(Date,tmpSep2+1,len-tmpSep2);
                        end;
                     end;
              end
              else
                 begin
                 annee2 := Copy(Date,1,4);
                 mois2 := Copy(Date,5,2);
                 jour2 := Copy(Date,7,2);
              end;
            while length(annee2)<4 do annee2:='0'+annee2;
            while length(mois2)<2 do mois2:='0'+mois2;
            while length(jour2)<2 do jour2:='0'+jour2;
            if (bc2='-') then
               begin
               annee2:=IntToStr(StrToInt(annee2)*(-1));
               while length(annee2)<4 do annee2:=Copy(annee2,1,1)+'0'+Copy(annee2,2,length(annee2));
            end;
         end;
      end;
{ TODO 11 : Si <-999 l'annee a 5 chiffres, ce qui n'est pas pris en compte dans le format de date dans la base de données }
      if (length(annee1)>4) then
         Valid:=false;
      if (length(annee2)>4) then
         Valid:=false;
      if (StrToInt(mois1)>12) or (StrToInt(mois2)>12) or (StrToInt(jour1)>31) or (StrToInt(jour2)>31) then
         Valid:=false;
      { TODO : Bug: n'accepte pas si l'annee, le mois ou le jour est 0... }
      // Valide que le date est valide
      if (StrtoInt(mois1)>0) and (StrtoInt(jour1)>0) and (not (Copy(annee1,1,1)='-')) then
         if not (TryEncodeDate(Strtoint(annee1),Strtoint(mois1),Strtoint(jour1),test)) then valid:=false;
      if (StrtoInt(mois2)>0) and (StrtoInt(jour2)>0) and (not (Copy(annee2,1,1)='-')) then
         if not (TryEncodeDate(Strtoint(annee2),Strtoint(mois2),Strtoint(jour2),test)) then valid:=false;
      if Valid then
         if format=1 then
            InterpreteDate:='1'+Annee1+Mois1+Jour1+'0'+style+Annee2+Mois2+Jour2+'00'
         else
            InterpreteDate:=Original
      else
         if format=1 then
            InterpreteDate:='0'+Original
         else
            InterpreteDate:=Original;
   end;
end;

function GetName(no:string):string;
begin
   Principale.Query4.SQL.Clear;
   Principale.Query4.SQL.Add('SELECT N.N FROM N WHERE N.X=1 AND N.I='+no);
   Principale.Query4.Open;
   Principale.Query4.First;
   if not Principale.Query4.EOF then
      GetName:=DecodeName(Principale.Query4.Fields[0].AsString,1)
   else
      GetName:=DecodeName('',1)
end;

function GetI3(no:string):string;
begin
   Principale.Query4.SQL.Clear;
   Principale.Query4.SQL.Add('SELECT E.PD, E.SD FROM E JOIN W on E.no=W.E JOIN Y on Y.no=E.Y WHERE E.X=1 AND W.X=1 AND Y.Y=''B'' AND W.I='+no);
   Principale.Query4.Open;
   Principale.Query4.First;
   if not Principale.Query4.EOF then
      begin
      if not (Copy(Principale.Query4.Fields[0].AsString,1,1)='1') then
         GetI3:=Principale.Query4.Fields[1].AsString
      else
         GetI3:=Principale.Query4.Fields[0].AsString;
   end
   else
      GetI3:='';
end;

function GetI4(no:string):string;
begin
   Principale.Query4.SQL.Clear;
   Principale.Query4.SQL.Add('SELECT E.PD, E.SD FROM E JOIN W on E.no=W.E JOIN Y on Y.no=E.Y WHERE E.X=1 AND W.X=1 AND Y.Y=''D'' AND W.I='+no);
   Principale.Query4.Open;
   Principale.Query4.First;
   if not Principale.Query4.EOF then
      begin
      if not (Copy(Principale.Query4.Fields[0].AsString,1,1)='1') then
         GetI4:=Principale.Query4.Fields[1].AsString
      else
         GetI4:=Principale.Query4.Fields[0].AsString;
   end
   else
      GetI4:='';
end;

function CalculAge(Date1:string;Date2:string;format:byte):string;
var
   annee1,mois1,jour1:word;
   annee2,mois2,jour2:word;
   annee3,mois3,jour3:word;
   temps1,temps2:TDateTime;
begin
   if (Copy(Date1,1,1)='1') AND (Copy(Date2,1,1)='1') then
      begin
      annee1:=StrtoInt(Copy(Date1,2,4));
      mois1:=StrtoInt(Copy(Date1,6,2));
      jour1:=StrtoInt(Copy(Date1,6,2));
      annee2:=StrtoInt(Copy(Date2,2,4));
      mois2:=StrtoInt(Copy(Date2,6,2));
      jour2:=StrtoInt(Copy(Date2,6,2));
      temps1:=EncodeDate(annee1,mois1,jour1);
      temps2:=EncodeDate(annee2,mois2,jour2);
      if temps1>temps2 then
         DecodeDate(temps1-temps2,annee3,mois3,jour3)
      else
         DecodeDate(temps2-temps1,annee3,mois3,jour3);
      if format=0 then
         CalculAge:=inttostr(annee3);
   end
   else
      CalculAge:='';
end;

function DecodePhraseTMG(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string):string;
var
  RoleRecherche, Remplace, Code, temp, Sexe:string;
  i, PosStart1, PosStart2, PosEnd1, PosEnd2, PosSeparateur:integer;
  Continue:boolean;
begin
   if AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(phrase))>0 then
      begin
      phrase:=copy(phrase,AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(phrase))+4+length(Principale.Traduction.Items[320]),length(phrase));
      if AnsiPos('[L=',uppercase(phrase))>0 then
         phrase:=copy(phrase,1,AnsiPos('[L=',uppercase(phrase)));
   end;
   RoleRecherche:='[R='+role;
   if AnsiPos(RoleRecherche,uppercase(phrase))>0 then
      begin
      phrase:=copy(phrase,AnsiPos(RoleRecherche,uppercase(phrase))+length(RoleRecherche)+1,length(phrase));
      if AnsiPos('[R=',uppercase(phrase))>0 then
         phrase:=copy(phrase,1,AnsiPos('[R=',uppercase(phrase))-1);
   end;
   if AnsiPos('$!&',uppercase(phrase))>0 then
      begin
      Principale.Query4.SQL.Clear;
      Principale.Query4.SQL.Add('SELECT S FROM I WHERE no='+Sujet);
      Principale.Query4.Open;
      if Principale.Query4.Fields[0].AsString='F' then
         phrase:=copy(phrase,AnsiPos('$!&',phrase)+3,length(phrase))
      else
         phrase:=copy(phrase,1,AnsiPos('$!&',phrase)-1);
   end;
   PosStart1:=0;
   PosStart2:=0;
   PosEnd1:=0;
   PosEnd2:=0;
   PosSeparateur:=0;
   Continue:=true;
   while ((PosEnd2<=PosStart2) AND Continue) do
      begin
      i:=PosEnd2+1;
      while (i<=length(phrase)) do
         begin
         if Copy(phrase,i,1)='[' then
            begin
            PosStart2:=i;
            i:=length(phrase);
         end;
         i:=i+1;
      end;
      Continue:=(Copy(phrase,PosStart2,1)='[');
      if Continue then
         begin
         i:=PosStart2-1;
         while i>0 do
            begin
            if Copy(Phrase,i,1)='<' then
               begin
               PosStart1:=i;
               i:=0;
            end
            else
               if Copy(Phrase,i,1)='>' then
                  begin
                  PosStart1:=0;
                  i:=0;
               end;
            i:=i-1;
         end;
         i:=PosStart2+1;
         while i<=length(phrase) do
            begin
            if Copy(Phrase,i,1)=']' then
               begin
               PosEnd2:=i;
               i:=length(phrase);
            end;
            i:=i+1;
         end;
         i:=PosEnd2+1;
         while i<=length(phrase) do
            begin
               if Copy(Phrase,i,1)='>' then
                  begin
                  PosEnd1:=i;
                  i:=length(phrase);
               end
               else
                  if Copy(Phrase,i,1)='<' then
                     begin
                     PosEnd1:=0;
                     i:=length(phrase);
                  end;
               i:=i+1;
         end;
         if ((PosStart1>0) and (PosEnd1>0)) then
            begin
            i:=PosStart1+1;
            while i<=(PosEnd1-1) do
               begin
               if Copy(Phrase,i,1)='|' then
                  begin
                  PosSeparateur:=i;
                  i:=PosEnd1;
               end;
               i:=i+1;
            end;
         end;
      end;
   end;

// Trouve ce qui doit être remplacé

   Remplace:='';
   if TypeEvenement='R' then
      begin
      if PosEnd2>PosStart2 then
         begin
         Code:=Copy(Phrase,PosStart2+1,PosEnd2-PosStart2-1);
         if Code='A' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT SD FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Sujet);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
         if Code='A1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT SD, A FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
         if Code='A2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT SD, B FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
         if Code='AO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT SD, B, A FROM R WHERE no='+Evenement);
            Principale.Query3.SQL.Clear;
            if Principale.Query4.Fields[1].AsString=sujet then
               Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString)
            else
               Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[2].AsString);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
         if Code='D' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT SD FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=ConvertDate(Principale.Query4.Fields[0].AsString,0);
         end;
//         if Code='L' then remplace:='/LIEU/'; JAMAIS DANS type 'R'
         if Code='M' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT M FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=Principale.Query4.Fields[0].AsString;
            if AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))>0 then
               begin
               Remplace:=copy(Remplace,AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))+4+length(Principale.Traduction.Items[320]),length(Remplace));
               if AnsiPos('[L=',uppercase(Remplace))>0 then
                  Remplace:=copy(Remplace,1,AnsiPos('[L=',uppercase(Remplace)));
            end;
         end;
         if (Code='W') or (Code='N') then
            begin
            Principale.Query4.SQL.Clear;
            if role='ENFANT' then
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.A WHERE N.X=1 and R.no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE N.X=1 and R.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P' then
            begin
            Principale.Query4.SQL.Clear;
            if role='ENFANT' then
               Principale.Query4.SQL.Add('SELECT I.S FROM R JOIN I ON R.A=I.no WHERE R.no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT I.S FROM R JOIN I ON R.B=I.no WHERE R.no='+Evenement);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[66])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[67]);
         end;
         if Code='PP' then
            begin
            Principale.Query4.SQL.Clear;
            if role='ENFANT' then
               Principale.Query4.SQL.Add('SELECT I.S FROM R JOIN I ON R.A=I.no WHERE R.no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT I.S FROM R JOIN I ON R.B=I.no WHERE R.no='+Evenement);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[68])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[69]);
         end;
         if Code='PO' then
            begin
            Principale.Query4.SQL.Clear;
            if role='ENFANT' then
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE N.X=1 and R.no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.A WHERE N.X=1 and R.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.A WHERE N.X=1 and R.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE N.X=1 and R.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='PAR' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Sujet);
            Principale.Query4.Open;
            Sexe:=Principale.Query4.Fields[0].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I=R.B WHERE R.X=1 AND N.X=1 AND R.A='+Sujet+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if Sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
         if Code='PARO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT A,B FROM R WHERE no='+Evenement);
            Principale.Query4.Open;
            if role='ENFANT' then
               Remplace:=Principale.Query4.Fields[1].AsString
            else
               Remplace:=Principale.Query4.Fields[0].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Remplace);
            Principale.Query4.Open;
            Sexe:=Principale.Query4.Fields[0].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
         if Code='PAR1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT R.A, I.S FROM R JOIN I on R.A=I.no WHERE R.no='+Evenement);
            Remplace:=Principale.Query4.Fields[0].AsString;
            Sexe:=Principale.Query4.Fields[1].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if Sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
         if Code='PAR2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT R.B, I.S FROM R JOIN I on R.B=I.no WHERE R.no='+Evenement);
            Remplace:=Principale.Query4.Fields[0].AsString;
            Sexe:=Principale.Query4.Fields[1].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
//         if Code='WO' then remplace:='/Noms de tous les témoins/'; JAMAIS DANS type 'R'
         if Copy(Code,1,2)='R:' then // soit ENFANT, soit PARENT
            begin
            Principale.Query4.SQL.Clear;
            if Copy(Code,3,length(code))='ENFANT' then
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.A WHERE N.X=1 and R.no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE N.X=1 and R.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
      end;
   end;
   if TypeEvenement='E' then
      begin
      if PosEnd2>PosStart2 then
         begin
         Code:=Copy(Phrase,PosStart2+1,PosEnd2-PosStart2-1);
         if Code='A' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT PD FROM E WHERE no='+Evenement);
            Principale.Query4.Open;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Sujet);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
         if Code='A1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT E.PD, W.I FROM E JOIN W on E.no=W.E WHERE W.X=1 AND no='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Principale.Query3.SQL.Clear;
               Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString);
               Principale.Query3.Open;
               Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
               if Remplace='0' then Remplace:='';
            end;
         end;
         if Code='A2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT E.PD, W.I FROM E JOIN W on E.no=W.E WHERE W.X=1 AND no='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  begin
                  Principale.Query3.SQL.Clear;
                  Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString);
                  Principale.Query3.Open;
                  Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
                  if Remplace='0' then Remplace:='';
               end;
            end;
         end;
         if Code='AO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT E.PD, W.I FROM E JOIN W on E.no=W.E WHERE W.X=1 AND (NOT (W.I='+sujet+')) AND no='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Principale.Query3.SQL.Clear;
               Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Principale.Query4.Fields[1].AsString);
               Principale.Query3.Open;
               Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
               if Remplace='0' then Remplace:='';
            end;
         end;
         if Code='D' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT PD FROM E WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=ConvertDate(Principale.Query4.Fields[0].AsString,0);
         end;
         if Code='L' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT L.L FROM L JOIN E ON L.no=E.L WHERE E.no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeLieu(Principale.Query4.Fields[0].AsString);
         end;
         if Code='M' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT M FROM E WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=Principale.Query4.Fields[0].AsString;
            if AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))>0 then
               begin
               Remplace:=copy(Remplace,AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))+4+length(Principale.Traduction.Items[320]),length(Remplace));
               if AnsiPos('[L=',uppercase(Remplace))>0 then
                  Remplace:=copy(Remplace,1,AnsiPos('[L=',uppercase(Remplace))-1);
            end;
         end;
         if (Code='N') then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N FROM N WHERE N.X=1 and N.I='+Sujet);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1);
         end;
         if (Code='W') or (Code='P') then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Sujet);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[66])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[67]);
         end;
         if Code='PP' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Sujet);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[68])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[69]);
         end;
         if Code='PO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN W on N.I=W.I WHERE W.X=1 AND N.X=1 AND W.E='+Evenement+' AND NOT W.I='+Sujet);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN W on N.I=W.I WHERE W.X=1 AND N.X=1 AND W.E='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN W on N.I=W.I WHERE W.X=1 AND N.X=1 AND W.E='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
            end;
         end;
         if Code='PAR' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Sujet);
            Principale.Query4.Open;
            Sexe:=Principale.Query4.Fields[0].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I=R.B WHERE R.X=1 AND N.X=1 AND R.A='+Sujet+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
         if Code='PARO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT W.I, I.S FROM W JOIN I on W.I=I.no WHERE W.X=1 AND W.E='+Evenement+' AND NOT W.I='+Sujet);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Remplace:=Principale.Query4.Fields[0].AsString;
               Sexe:=Principale.Query4.Fields[1].AsString;
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I=R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
               Principale.Query4.Open;
               if not Principale.Query4.EOF then
                  begin
                  if sexe='F' then
                     Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
                  else
                     Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
                  Principale.Query4.Next;
                  if not Principale.Query4.EOF then
                     Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               end
               else
                  Remplace:='';
            end;
         end;
         if Code='PAR1' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT W.I, I.S FROM W JOIN I on W.I=I.no WHERE W.X=1 AND W.E='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Sexe:=Principale.Query4.Fields[1].AsString;
               Remplace:=Principale.Query4.Fields[0].AsString;
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I=R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
               Principale.Query4.Open;
               if not Principale.Query4.EOF then
                  begin
                  if sexe='F' then
                     Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
                  else
                     Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
                  Principale.Query4.Next;
                  if not Principale.Query4.EOF then
                     Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               end
               else
                  Remplace:='';
            end;
         end;
         if Code='PAR2' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT W.I, I.S FROM W JOIN I on W.I=I.no WHERE W.X=1 AND W.E='+Evenement);
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  begin
                  Remplace:=Principale.Query4.Fields[0].AsString;
                  Sexe:=Principale.Query4.Fields[1].AsString;
                  Principale.Query4.SQL.Clear;
                  Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I=R.B WHERE R.X=1 AND N.X=1 AND R.A='+Remplace+' ORDER BY R.SD');
                  Principale.Query4.Open;
                  if not Principale.Query4.EOF then
                     begin
                     if sexe='F' then
                        Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
                     else
                        Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
                     Principale.Query4.Next;
                     if not Principale.Query4.EOF then
                        Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
                  end
                  else
                     Remplace:='';
               end;
            end;
         end;
         if Code='WO' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN W on N.I=W.I JOIN E on W.E=E.no WHERE N.X=1 AND W.X=0 AND E.no='+Evenement);
            Principale.Query4.Open;
            While not Principale.Query4.EOF do
               begin
               temp:=DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if length(remplace)=0 then
                  Remplace:=temp
               else
                  if Principale.Query4.EOF then
                     Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+temp
                  else
                     Remplace:=Remplace+', '+temp;
            end;
         end;
         if Copy(Code,1,2)='R:' then
            begin
            RoleRecherche:=Copy(Code,3,length(Code));
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN W on N.I=W.I WHERE N.X=1 AND W.E='+
               Evenement+' AND W.R='''+RoleRecherche+'''');
            Principale.Query4.Open;
            While not Principale.Query4.EOF do
               begin
               temp:=DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if length(remplace)=0 then
                  Remplace:=temp
               else
                  if Principale.Query4.EOF then
                     Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+temp
                  else
                     Remplace:=Remplace+', '+temp;
            end;
         end;
      end;
   end;
   if TypeEvenement='N' then
      begin
      if PosEnd2>PosStart2 then
         begin
         Code:=Copy(Phrase,PosStart2+1,PosEnd2-PosStart2-1);
         if (Code='A') or (Code='A1') then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT PD FROM N WHERE no='+Evenement);
            Principale.Query4.Open;
            Principale.Query3.SQL.Clear;
            Principale.Query3.SQL.Add('SELECT N.I3 FROM N WHERE N.I='+Sujet);
            Principale.Query3.Open;
            Remplace:=CalculAge(Principale.Query3.Fields[0].AsString,Principale.Query4.Fields[0].AsString,0);
            if Remplace='0' then Remplace:='';
         end;
//         if Code='A2' then JAMAIS DANS TYPE 'N'
//         if Code='AO' then JAMAIS DANS TYPE 'N'
         if Code='D' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT PD FROM N WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=ConvertDate(Principale.Query4.Fields[0].AsString,0);
         end;
//         if Code='L' then remplace:='/LIEU/'; JAMAIS DANS type 'N'
         if Code='M' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT M FROM N WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=Principale.Query4.Fields[0].AsString;
            if AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))>0 then
               begin
               Remplace:=copy(Remplace,AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))+4+length(Principale.Traduction.Items[320]),length(Remplace));
               if AnsiPos('[L=',uppercase(Remplace))>0 then
                  Remplace:=copy(Remplace,1,AnsiPos('[L=',uppercase(Remplace)));
            end;
         end;
         if (Code='W') or (Code='N') or (Code='P1') or (Copy(Code,1,2)='R:') then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N FROM N WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1)
         end;
         if Code='P' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM N JOIN I ON N.I=I.no WHERE N.no='+Evenement);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[66])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[67]);
         end;
         if Code='PP' then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM N JOIN I ON N.I=I.no WHERE N.no='+Evenement);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[68])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[69]);
         end;
//         if Code='PO' then JAMAIS DANS TYPE 'N'
//         if Code='P2' then JAMAIS DANS TYPE 'N'
         if (Code='PAR') or (Code='PAR1') then
            begin
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT I.S FROM I WHERE I.no='+Sujet);
            Principale.Query4.Open;
            Sexe:=Principale.Query4.Fields[0].AsString;
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N.N FROM N JOIN R on N.I = R.B WHERE R.X=1 AND N.X=1 AND R.A='+Sujet+' ORDER BY R.SD');
            Principale.Query4.Open;
            if not Principale.Query4.EOF then
               begin
               if sexe='F' then
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[70])+DecodeName(Principale.Query4.Fields[0].AsString,1)
               else
                  Remplace:=AnsitoUTF8(Principale.Traduction.Items[71])+DecodeName(Principale.Query4.Fields[0].AsString,1);
               Principale.Query4.Next;
               if not Principale.Query4.EOF then
                  Remplace:=Remplace+AnsitoUTF8(Principale.Traduction.Items[72])+DecodeName(Principale.Query4.Fields[0].AsString,1);
            end
            else
               Remplace:='';
         end;
//         if Code='PARO' then JAMAIS DANS TYPE 'N'
//         if Code='PAR2' then JAMAIS DANS TYPE 'N'
//         if Code='WO' then remplace:='/Noms de tous les témoins/'; JAMAIS DANS type 'N'
      end;
   end;

   // Remplace

   if length(remplace)=0 then
      if (PosStart1>0) AND (PosEnd1>0) AND (PosEnd1>PosStart1) AND (PosStart1<PosStart2) AND (PosEnd1>PosEnd2) then
         if (PosSeparateur>0) AND (PosSeparateur<PosEnd2) then // on a "...<...|...[.]...>..."
            phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosStart1+1,PosSeparateur-PosStart1-1)+
                    Copy(phrase,PosEnd1+1,Length(phrase))
         else
            if (PosSeparateur>0) AND (PosSeparateur>PosEnd2) then // on a "...<...[.]...|...>..."
               phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosSeparateur+1,PosEnd1-PosSeparateur-1)+
                       Copy(phrase,PosEnd1+1,Length(phrase))
            else // on a "...<...[...]...>...
               phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosEnd1+1,Length(phrase))
      else // on a " ...[...]..."
         phrase:=Copy(phrase,1,PosStart2-1)+Copy(phrase,PosEnd2+1,Length(phrase))
   else
      if (PosStart1>0) AND (PosEnd1>0) AND (PosEnd1>PosStart1) AND (PosStart1<PosStart2) AND (PosEnd1>PosEnd2) then
         if (PosSeparateur>0) AND (PosSeparateur<PosEnd2) then // on a "...<...|...[.]...>..."
            phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosSeparateur+1,PosStart2-PosSeparateur-1)+
                    Remplace+Copy(phrase,PosEnd2+1,PosEnd1-PosEnd2-1)+Copy(Phrase,PosEnd1+1,Length(Phrase))
         else
            if (PosSeparateur>0) AND (PosSeparateur>PosEnd2) then // on a "...<...[.]...|...>..."
               phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosStart1+1,PosStart2-PosStart1-1)+
                       Remplace+Copy(phrase,PosEnd2+1,PosSeparateur-PosEnd2-1)+Copy(Phrase,PosEnd1+1,Length(Phrase))
            else // on a "...<...[...]...>...
               phrase:=Copy(phrase,1,PosStart1-1)+Copy(phrase,PosStart1+1,PosStart2-PosStart1-1)+
                       Remplace+Copy(phrase,PosEnd2+1,PosEnd1-PosEnd2-1)+Copy(Phrase,PosEnd1+1,Length(Phrase))
      else // on a " ...[...]..."
         phrase:=Copy(phrase,1,PosStart2-1)+Remplace+Copy(phrase,PosEnd2+1,Length(phrase));

   if PosEnd2>PosStart2 then
      phrase:=DecodePhraseTMG(sujet,role,phrase,TypeEvenement,evenement);

   DecodePhraseTMG:=phrase;
end;

function DecodePhraseStemma(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string;char:integer):string;
var
  RoleRecherche, Remplace, temp, Sexe:string;
  PosEnd1, PosSep1, PosSep2, PosSep3, compte:integer;
begin
   compte:=0;
   if AnsiPos('<L='+Principale.Traduction.Items[319]+'>',uppercase(phrase))>0 then
      begin
      phrase:=copy(phrase,AnsiPos('<L='+Principale.Traduction.Items[319]+'>',uppercase(phrase))+5,length(phrase));
      if AnsiPos('</L>',uppercase(phrase))>0 then
         phrase:=copy(phrase,1,AnsiPos('</L>',uppercase(phrase)));
   end;
   RoleRecherche:='<R='+role;
   if AnsiPos(RoleRecherche,uppercase(phrase))>0 then
      begin
      phrase:=copy(phrase,AnsiPos(RoleRecherche,uppercase(phrase))+length(RoleRecherche)+1,length(phrase));
      if AnsiPos('</R>',uppercase(phrase))>0 then
         phrase:=copy(phrase,1,AnsiPos('</R>',uppercase(phrase))-1);
   end;
   while (not ((copy(phrase,char,1)='$') or (copy(phrase,char,1)='<'))) and (char<length(phrase)) do
      char:=char+1;
   if length(sujet)>0 then
      begin
      if copy(phrase,char,1)='$' then
         begin
         // Vérifie si c'est une variable, si oui remplace par sa valeur
         if copy(phrase,char+1,1)='L' then
            begin
            // Remplace par le Lieu
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT L.L FROM L JOIN E ON L.no=E.L WHERE E.no='+Evenement);
            Principale.Query4.Open;
            remplace:=DecodeLieu(Principale.Query4.Fields[0].AsString);
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+2,length(phrase));
         end;
         if copy(phrase,char+1,1)='N' then
            begin
            // Remplace par le Nom
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT N FROM N WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=DecodeName(Principale.Query4.Fields[0].AsString,1);
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+2,length(phrase));
         end;
         if copy(phrase,char+1,1)='M' then
            begin
            // Remplace par le Mémo
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT M FROM '+TypeEvenement+' WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=Principale.Query4.Fields[0].AsString;
            if AnsiPos('<L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))>0 then
               begin
               Remplace:=copy(Remplace,AnsiPos('<L='+Principale.Traduction.Items[320]+'>',uppercase(Remplace))+4+length(Principale.Traduction.Items[320]),length(Remplace));
               if AnsiPos('</L>',uppercase(Remplace))>0 then
                  Remplace:=copy(Remplace,1,AnsiPos('</L>',uppercase(Remplace)));
            end;
            if AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))>0 then
               begin
               Remplace:=copy(Remplace,AnsiPos('[L='+Principale.Traduction.Items[320]+']',uppercase(Remplace))+4+length(Principale.Traduction.Items[320]),length(Remplace));
               if AnsiPos('[L=',uppercase(Remplace))>0 then
                  Remplace:=copy(Remplace,1,AnsiPos('[L=',uppercase(Remplace)));
            end;
            phrase:=Copy(phrase,1,char-1)+Remplace+
                    Copy(phrase,char+2,length(phrase));
         end;
         if copy(phrase,char+1,1)='P' then
            begin
            // Remplace par le Pronom
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT S FROM I WHERE no='+Sujet);
            Principale.Query4.Open;
            if Principale.Query4.Fields[0].AsString='F' then
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[66])
            else
               Remplace:=AnsitoUTF8(Principale.Traduction.Items[67]);
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+2,length(phrase));
         end;
         if copy(phrase,char+1,1)='D' then
            begin
            // Remplace par la Date
            Principale.Query4.SQL.Clear;
            if TypeEvenement='R' then
               Principale.Query4.SQL.Add('SELECT SD FROM R WHERE no='+Evenement)
            else
               Principale.Query4.SQL.Add('SELECT PD FROM '+TypeEvenement+' WHERE no='+Evenement);
            Principale.Query4.Open;
            Remplace:=ConvertDate(Principale.Query4.Fields[0].AsString,0);
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+2,length(phrase));
         end;
         if copy(phrase,char+1,2)='R_' then
            begin
            // Vérifie quel role, remplace par la liste des noms }
            temp:=Copy(phrase,char+3,length(phrase));
            posend1:=AnsiPos('_',temp);
            if posend1>0 then
               begin
               RoleRecherche:=Copy(temp,1,posend1-1);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  remplace:='';
                  if TypeEvenement='N' then
                     begin
                     remplace:=GetName(sujet);
                  end;
                  if TypeEvenement='R' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT R.A, R.B FROM R WHERE no='+Evenement);
                     Principale.Query4.Open;
                     if RoleRecherche='PARENT' then
                        remplace:=GetName(Principale.Query4.Fields[1].AsString)
                     else
                        remplace:=GetName(Principale.Query4.Fields[0].AsString)
                  end;
                  if TypeEvenement='E' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I, N.N FROM W JOIN E ON E.no=W.E JOIN N ON N.I=W.I WHERE N.X=1 AND E.no='+
                                               Evenement+' AND W.R='''+RoleRecherche+'''');
                     Principale.Query4.Open;
                     Principale.Query4.First;
                     compte:=0;
                     while not Principale.Query4.EOF do
                        begin
                        temp:=DecodeName(Principale.Query4.Fields[1].AsString,1);
                        if compte=0 then
                           remplace:=temp;
                        if compte=1 then
                           remplace:=temp+Principale.Traduction.Items[72]+remplace;
                        if compte>1 then
                           remplace:=temp+', '+remplace;
                        Principale.Query4.Next;
                        compte:=compte+1;
                     end;
                  end;
               end;
            end;
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+3+posend1,length(phrase));
         end;
         if copy(phrase,char+1,3)='RO_' then
            begin
            // Vérifie quel role, remplace par la liste des noms }
            temp:=Copy(phrase,char+4,length(phrase));
            posend1:=AnsiPos('_',temp);
            if posend1>0 then
               begin
               RoleRecherche:=Copy(temp,1,posend1-1);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  remplace:='';
                  if TypeEvenement='R' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT R.A, R.B FROM R WHERE no='+Evenement);
                     Principale.Query4.Open;
                     if RoleRecherche='PARENT' then
                        remplace:=GetName(Principale.Query4.Fields[0].AsString)
                     else
                        remplace:=GetName(Principale.Query4.Fields[1].AsString)
                  end;
                  if TypeEvenement='E' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I, N.N FROM W JOIN E ON E.no=W.E JOIN N ON N.I=W.I WHERE N.X=1 AND E.no='+
                                               Evenement+' AND W.R='''+RoleRecherche+'''');
                     Principale.Query4.Open;
                     compte:=0;
                     while not Principale.Query4.EOF do
                        begin
                        if not (Principale.Query4.Fields[0].AsString=sujet) then
                           begin
                           temp:=DecodeName(Principale.Query4.Fields[1].AsString,1);
                           if compte=0 then
                              remplace:=temp;
                           if compte=1 then
                              remplace:=temp+Principale.Traduction.Items[72]+remplace;
                           if compte>1 then
                              remplace:=temp+', '+remplace;
                           compte:=compte+1;
                        end;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+4+posend1,length(phrase));
         end;
         if copy(phrase,char+1,3)='RP_' then
            begin
            // Vérifie quel role, remplace par la liste des noms
            temp:=Copy(phrase,char+4,length(phrase));
            posend1:=AnsiPos('_',temp);
            if posend1>0 then
               begin
               RoleRecherche:=Copy(temp,1,posend1-1);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  remplace:='';
                  if TypeEvenement='R' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT R.A, R.B FROM R WHERE no='+Evenement);
                     Principale.Query4.Open;
                     Principale.Query3.SQL.Clear;
                     if RoleRecherche='PARENT' then
                        Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                  Principale.Query4.Fields[1].AsString)
                     else
                        Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                  Principale.Query4.Fields[0].AsString);
                     Principale.Query3.Open;
                     while not Principale.Query3.EOF do
                        begin
                        if length(remplace)=0 then
                           remplace:=GetName(Principale.Query3.Fields[1].AsString)
                        else
                           remplace:=remplace+Principale.Traduction.Items[72]+GetName(Principale.Query3.Fields[1].AsString);
                        Principale.Query3.Next;
                     end;
                  end;
                  if TypeEvenement='E' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON E.no=W.E WHERE E.no='+
                                               Evenement+' AND W.R='''+RoleRecherche+'''');
                     Principale.Query4.Open;
                     compte:=0;
                     while not Principale.Query4.EOF do
                        begin
                        Principale.Query3.SQL.Clear;
                        Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                   Principale.Query4.Fields[0].AsString);
                        Principale.Query3.Open;
                        while not Principale.Query3.EOF do
                           begin
                           temp:=getname(Principale.Query3.Fields[1].AsString);
                           if compte=0 then
                              remplace:=temp;
                           if compte=1 then
                              remplace:=temp+Principale.Traduction.Items[72]+remplace;
                           if compte>1 then
                              remplace:=temp+', '+remplace;
                           compte:=compte+1;
                           Principale.Query3.Next;
                        end;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+4+posend1,length(phrase));
         end;
         if copy(phrase,char+1,4)='ROP_' then
            begin
            // Vérifie quel role, remplace par la liste des noms
            temp:=Copy(phrase,char+5,length(phrase));
            posend1:=AnsiPos('_',temp);
            if posend1>0 then
               begin
               RoleRecherche:=Copy(temp,1,posend1-1);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  remplace:='';
                  if TypeEvenement='R' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT R.A, R.B FROM R WHERE no='+Evenement);
                     Principale.Query4.Open;
                     Principale.Query3.SQL.Clear;
                     if RoleRecherche='PARENT' then
                        Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                  Principale.Query4.Fields[0].AsString)
                     else
                        Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                  Principale.Query4.Fields[1].AsString);
                     Principale.Query3.Open;
                     while not Principale.Query3.EOF do
                        begin
                        if length(remplace)=0 then
                           remplace:=GetName(Principale.Query3.Fields[1].AsString)
                        else
                           remplace:=remplace+Principale.Traduction.Items[72]+GetName(Principale.Query3.Fields[1].AsString);
                        Principale.Query3.Next;
                     end;
                  end;
                  if TypeEvenement='E' then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON E.no=W.E WHERE E.no='+
                                               Evenement+' AND W.R='''+RoleRecherche+'''');
                     Principale.Query4.Open;
                     while not Principale.Query4.EOF do
                        begin
                        compte:=0;
                        if not (Principale.Query4.Fields[0].AsString=sujet) then
                           begin
                           Principale.Query3.SQL.Clear;
                           Principale.Query3.SQL.Add('SELECT R.A, R.B FROM R WHERE X=1 AND R.A='+
                                                      Principale.Query4.Fields[0].AsString);
                           Principale.Query3.Open;
                           while not Principale.Query3.EOF do
                              begin
                              temp:=getname(Principale.Query3.Fields[1].AsString);
                              if compte=0 then
                                 remplace:=temp;
                              if compte=1 then
                                    remplace:=temp+Principale.Traduction.Items[72]+remplace;
                              if compte>1 then
                                    remplace:=temp+', '+remplace;
                              compte:=compte+1;
                              Principale.Query3.Next;
                           end;
                        end;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            phrase:=Copy(phrase,1,char-1)+remplace+
                    Copy(phrase,char+5+posend1,length(phrase));
         end;
         if (char+1) < length(phrase) then
            phrase:=DecodePhraseStemma(sujet,role,phrase,TypeEvenement,evenement,char+1);
      end;
      if copy(phrase,char,4)='<$S=' then
         begin
         // Vérifie si c'est une fonction
         temp:=Copy(phrase,char+6,length(phrase));
         posend1:=AnsiPos('</S>',temp);
         temp:=copy(phrase,char+6,posend1-1);
         if ((copy(phrase,char+4,2)='M>') or (copy(phrase,char+4,2)='F>')) and
            (posend1>0) then
            begin
            // Si c'est une fonction remplace par sa valeur
            Sexe:=Copy(phrase,char+4,1);
            Principale.Query4.SQL.Clear;
            Principale.Query4.SQL.Add('SELECT S FROM I WHERE no='+sujet);
            Principale.Query4.Open;
            if (sexe=Principale.Query4.Fields[0].AsString) or
               ((sexe='M') and (Principale.Query4.Fields[0].AsString='?'))then
               remplace:=temp
            else
               remplace:='';
            phrase:=Copy(phrase,1,char-1)+remplace+Copy(phrase,char+9+posend1,length(phrase));
         end;
         phrase:=DecodePhraseStemma(sujet,role,phrase,TypeEvenement,evenement,char);
      end;
      if copy(phrase,char,2)='<<' then
         begin
         temp:=Copy(phrase,char+3,length(phrase));
         possep1:=AnsiPos('|',temp);
         posend1:=AnsiPos('>>',temp);
         temp:=Copy(temp,possep1+1,length(temp));
         possep2:=AnsiPos('|',temp)+possep1;
         temp:=Copy(temp,possep2-possep1+1,length(temp));
         if AnsiPos('|',temp)>0 then
            begin
            possep3:=AnsiPos('|',temp)+possep2;
            if possep3>posend1 then possep3:=posend1;
            end
         else
            possep3:=posend1;
         // Vérifie si c'est une fonction, si oui remplace par sa valeur
         if (possep1>0) and (posend1>0) and (possep2>0) then
            begin
            remplace:=Copy(phrase,char+3+possep1,possep2-possep1-1);
            temp:=Copy(phrase,char+2,possep1);
            if Copy(temp,1,2)='$M' then
               begin
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT M FROM '+TypeEvenement+' WHERE no='+Evenement);
               Principale.Query4.Open;
               If length(Principale.Query4.Fields[0].AsString)>0 then
                  remplace:=Copy(phrase,char+3+possep1+possep2,posend1-possep2-1);
            end;
            if Copy(temp,1,2)='$L' then
               begin
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT L.L FROM L JOIN E ON L.no=E.L WHERE E.no='+Evenement);
               Principale.Query4.Open;
               If length(DecodeLieu(Principale.Query4.Fields[0].AsString))>0 then
                  remplace:=Copy(phrase,char+3+possep1+possep2,posend1-possep2-1);
            end;
            if Copy(temp,1,2)='$D' then
               begin
               Principale.Query4.SQL.Clear;
               if TypeEvenement='E' then
                  Principale.Query4.SQL.Add('SELECT PD FROM E WHERE E.no='+Evenement);
               if TypeEvenement='N' then
                  Principale.Query4.SQL.Add('SELECT PD FROM N WHERE E.no='+Evenement);
               if TypeEvenement='R' then
                  Principale.Query4.SQL.Add('SELECT SD FROM R WHERE E.no='+Evenement);
               Principale.Query4.Open;
               If Length(ConvertDate(Principale.Query4.Fields[0].AsString,1))>0 then
                  remplace:=Copy(phrase,char+3+possep1+possep2,posend1-possep2-1);
            end;
            if Copy(temp,1,3)='$R_' then
               begin
               RoleRecherche:=Copy(phrase,char+5,possep1-4);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               compte:=0;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  if (TypeEvenement='N') or (TypeEvenement='R') then
                     compte:=1;
                  if (TypeEvenement='E') then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON W.E=E.no WHERE '+
                                               'W.R='''+RoleRecherche+''' AND E.no='+Evenement);
                     Principale.Query4.Open;
                     compte:=Principale.Query4.RecordCount;
                  end;
               end;
            end;
            if Copy(temp,1,4)='$RO_' then
               begin
               RoleRecherche:=Copy(phrase,char+6,possep1-5);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               compte:=0;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  if (TypeEvenement='N') or (TypeEvenement='R') then
                     compte:=0;
                  if (TypeEvenement='E') then
                     begin
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON W.E=E.no WHERE '+
                                               'W.R='''+RoleRecherche+''' AND E.no='+Evenement);
                     Principale.Query4.Open;
                     compte:=Principale.Query4.RecordCount;
                     While not Principale.Query4.Eof do
                        begin
                        if Principale.Query4.Fields[0].AsString=sujet then
                           compte:=compte-1;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            if Copy(temp,1,4)='$RP_' then
               begin
               RoleRecherche:=Copy(phrase,char+6,possep1-5);
               // Vérifie que le role est dans la liste des roles possible }
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               compte:=0;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  if (TypeEvenement='N') then
                     begin
                     // Décompte les parents du sujet
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT R.B FROM R WHERE X=1 AND R.A='+
                                               Sujet);
                     Principale.Query4.Open;
                     compte:=Principale.Query4.RecordCount;
                  end;
                  if (TypeEvenement='R') then
                     begin
                     // Décompte les parents du role
                     Principale.Query4.SQL.Clear;
                     if RoleRecherche='PARENT' then
                        Principale.Query4.SQL.Add('SELECT B FROM R WHERE no='+
                                                  Evenement)
                     else
                        Principale.Query4.SQL.Add('SELECT A FROM R WHERE no='+
                                                  Evenement);
                     Principale.Query4.Open;
                     Principale.Query3.SQL.Clear;
                     Principale.Query3.SQL.Add('SELECT B FROM R WHERE X=1 AND A='+
                                               Principale.Query4.Fields[0].AsString);
                     Principale.Query3.Open;
                     compte:=Principale.Query3.RecordCount;
                  end;
                  if (TypeEvenement='E') then
                     begin
                     // Decompte les parents des témoins
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON W.E=E.no WHERE '+
                                               'W.R='+RoleRecherche);
                     Principale.Query4.Open;
                     while not Principale.Query4.EOF do
                        begin
                        Principale.Query3.SQL.Clear;
                        Principale.Query3.SQL.Add('SELECT B FROM R WHERE X=1 AND A='+
                                                  Principale.Query4.Fields[0].AsString);
                        Principale.Query3.Open;
                        compte:=compte+Principale.Query3.RecordCount;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            if Copy(temp,1,5)='$ROP_' then
               begin
               // Decompte les parents des autres témoins
               RoleRecherche:=Copy(phrase,char+7,possep1-6);
               // Vérifie que le role est dans la liste des roles possible
               Principale.Query4.SQL.Clear;
               Principale.Query4.SQL.Add('SELECT Y.R FROM Y JOIN '+TypeEvenement+
                                         ' ON Y.no='+TypeEvenement+'.Y WHERE '+
                                         TypeEvenement+'.no='+Evenement);
               Principale.Query4.Open;
               compte:=0;
               if AnsiPos(RoleRecherche,Principale.Query4.Fields[0].AsString)>0 then
                  begin
                  if (TypeEvenement='E') then
                     begin
                     // Decompte les parents des autres témoins
                     Principale.Query4.SQL.Clear;
                     Principale.Query4.SQL.Add('SELECT W.I FROM W JOIN E ON W.E=E.no WHERE '+
                                               'W.R='''+RoleRecherche+''' AND E.no='+Evenement);
                     Principale.Query4.Open;
                     while not Principale.Query4.EOF do
                        begin
                        if Principale.Query4.Fields[0].AsString<>sujet then
                           begin
                           Principale.Query3.SQL.Clear;
                           Principale.Query3.SQL.Add('SELECT B FROM R WHERE X=1 AND A='+
                                                     Principale.Query4.Fields[0].AsString);
                           Principale.Query3.Open;
                           compte:=compte+Principale.Query3.RecordCount;
                        end;
                        Principale.Query4.Next;
                     end;
                  end;
               end;
            end;
            if (compte=1) or ((compte>1) and (possep3=posend1)) then
               remplace:=Copy(phrase,char+3+possep2,possep3-possep2-1)
            else
               if compte>1 then
                  remplace:=Copy(phrase,char+3+possep3,posend1-possep3-1);
            phrase:=Copy(phrase,1,char-1)+remplace+Copy(phrase,char+4+posend1,length(phrase));
            phrase:=DecodePhraseStemma(sujet,role,phrase,TypeEvenement,evenement,char);
         end
         else
            begin
            if (char+1) < length(phrase) then
               phrase:=DecodePhraseStemma(sujet,role,phrase,TypeEvenement,evenement,char+1);
         end;
      end;
   end;
   DecodePhraseStemma:=phrase;
end;


function DecodePhrase(sujet:string;role:string;phrase:string;TypeEvenement:string;evenement:string):string;
var
  i:integer;
begin
   If copy(phrase,1,4)='!TMG' then
      DecodePhrase:=trim(DecodePhraseTMG(sujet,role,copy(phrase,5,length(phrase)),TypeEvenement,evenement))
   else
      begin
      DecodePhrase:=trim(DecodePhraseStemma(sujet,role,phrase,TypeEvenement,evenement,1));
   end;
   // Remplace les "  " par " "
   for i:=1 to length(DecodePhrase)-1 do
      if Copy(DecodePhrase,i,2)='  ' then
         DecodePhrase:=Copy(DecodePhrase,1,i)+Copy(DecodePhrase,i+2,length(DecodePhrase));
   if not (Copy(DecodePhrase,length(DecodePhrase),1)='.') then
      DecodePhrase:=DecodePhrase+'.';
   DecodePhrase:=UpperCase(Copy(DecodePhrase,1,1))+Copy(DecodePhrase,2,Length(DecodePhrase));
end;

procedure SaveModificationTime(no:string);
begin
  Principale.Query4.SQL.Clear;
  Principale.Query4.SQL.Add('UPDATE I SET date='''+FormatDateTime('YYYYMMDD',now)+
                            ''' WHERE no='+no);
  Principale.Query4.ExecSQL;
  if Principale.MenuItem8.Checked then PopulateNom;
end;

function DecodeLieu(Lieu:string):string;
var
  article, detail, ville, region, province, pays: string;
  pos1,pos2:integer;
begin
   If copy(lieu,1,4)='!TMG' then
      begin
      article:='';
      lieu:=copy(lieu,5,length(lieu));
      detail:=copy(lieu,1,AnsiPos('|',lieu)-1);
      lieu:=copy(lieu,AnsiPos('|',lieu)+1,length(lieu));
      detail:=copy(lieu,1,AnsiPos('|',lieu)-1);
      lieu:=copy(lieu,AnsiPos('|',lieu)+1,length(lieu));
      ville:=copy(lieu,1,AnsiPos('|',lieu)-1);
      lieu:=copy(lieu,AnsiPos('|',lieu)+1,length(lieu));
      region:=copy(lieu,1,AnsiPos('|',lieu)-1);
      lieu:=copy(lieu,AnsiPos('|',lieu)+1,length(lieu));
      province:=copy(lieu,1,AnsiPos('|',lieu)-1);
      lieu:=copy(lieu,AnsiPos('|',lieu)+1,length(lieu));
      pays:=copy(lieu,1,AnsiPos('|',lieu)-1);
   end
   else
      begin
      Pos1:=AnsiPos('<Article>',Lieu)+9;
      Pos2:=AnsiPos('</Article>',Lieu);
      if (Pos1+Pos2)>9 then
         Article:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Article:='';
      Pos1:=AnsiPos('<Détail>',Lieu)+9;
      Pos2:=AnsiPos('</Détail>',Lieu);
      if (Pos1+Pos2)>9 then
         Detail:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Detail:='';
      Pos1:=AnsiPos('<Ville>',Lieu)+7;
      Pos2:=AnsiPos('</Ville>',Lieu);
      if (Pos1+Pos2)>7 then
         Ville:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Ville:='';
      Pos1:=AnsiPos('<Région>',Lieu)+9;
      Pos2:=AnsiPos('</Région>',Lieu);
      if (Pos1+Pos2)>9 then
         Region:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Region:='';
      Pos1:=AnsiPos('<Province>',Lieu)+10;
      Pos2:=AnsiPos('</Province>',Lieu);
      if (Pos1+Pos2)>10 then
         Province:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Province:='';
      Pos1:=AnsiPos('<Pays>',Lieu)+6;
      Pos2:=AnsiPos('</Pays>',Lieu);
      if (Pos1+Pos2)>6 then
         Pays:=Copy(Lieu,Pos1,Pos2-Pos1)
      else
         Pays:='';
   end;
   if length(detail)=0 then
      lieu:=trim(article+' '+ville+', '+region+', '+province+', '+pays)
   else
      lieu:=trim(article+' '+detail+', '+ville+', '+region+', '+province+', '+pays);
   while (AnsiPos(', , ',lieu)>0) do
      begin
      lieu:=copy(lieu,1,AnsiPos(', , ',lieu)-1)+copy(lieu,AnsiPos(', , ',lieu)+2,length(lieu));
   end;
   if copy(lieu,length(lieu),1)=',' then
      lieu:=copy(lieu,1,length(lieu)-1);
   if copy(lieu,1,2)=', ' then lieu:=copy(lieu,3,length(lieu));
   DecodeLieu:=lieu;
end;

function RemoveUTF8(text:string):string;
begin
   text:=AnsiReplaceStr(text,'å','a');
   text:=AnsiReplaceStr(text,'á','a');
   text:=AnsiReplaceStr(text,'à','a');
   text:=AnsiReplaceStr(text,'â','a');
   text:=AnsiReplaceStr(text,'ä','a');
   text:=AnsiReplaceStr(text,'ç','c');
   text:=AnsiReplaceStr(text,'é','e');
   text:=AnsiReplaceStr(text,'è','e');
   text:=AnsiReplaceStr(text,'ê','e');
   text:=AnsiReplaceStr(text,'ë','e');
   text:=AnsiReplaceStr(text,'ì','i');
   text:=AnsiReplaceStr(text,'ï','i');
   text:=AnsiReplaceStr(text,'î','i');
   text:=AnsiReplaceStr(text,'í','i');
   text:=AnsiReplaceStr(text,'ò','o');
   text:=AnsiReplaceStr(text,'ö','o');
   text:=AnsiReplaceStr(text,'ô','o');
   text:=AnsiReplaceStr(text,'ø','o');
   text:=AnsiReplaceStr(text,'ù','u');
   text:=AnsiReplaceStr(text,'û','u');
   text:=AnsiReplaceStr(text,'ú','u');
   text:=AnsiReplaceStr(text,'ü','u');
   text:=AnsiReplaceStr(text,'ÿ','y');
   text:=AnsiReplaceStr(text,'ý','y');
   text:=AnsiReplaceStr(text,'ž','z');
   text:=AnsiReplaceStr(text,'Å','A');
   text:=AnsiReplaceStr(text,'Á','A');
   text:=AnsiReplaceStr(text,'À','A');
   text:=AnsiReplaceStr(text,'Â','A');
   text:=AnsiReplaceStr(text,'Ä','A');
   text:=AnsiReplaceStr(text,'Æ','AE');
   text:=AnsiReplaceStr(text,'Ç','C');
   text:=AnsiReplaceStr(text,'É','E');
   text:=AnsiReplaceStr(text,'È','E');
   text:=AnsiReplaceStr(text,'Ê','E');
   text:=AnsiReplaceStr(text,'Ë','E');
   text:=AnsiReplaceStr(text,'Ì','I');
   text:=AnsiReplaceStr(text,'Ï','I');
   text:=AnsiReplaceStr(text,'Î','I');
   text:=AnsiReplaceStr(text,'Ò','O');
   text:=AnsiReplaceStr(text,'Ö','O');
   text:=AnsiReplaceStr(text,'Ô','O');
   text:=AnsiReplaceStr(text,'Ù','U');
   text:=AnsiReplaceStr(text,'Û','U');
   text:=AnsiReplaceStr(text,'Ü','U');
   text:=AnsiReplaceStr(text,'Š','S');
   text:=AnsiReplaceStr(text,'Ž','Z');
   text:=AnsiReplaceStr(text,'''','');
   text:=AnsiReplaceStr(text,'-',' ');
   RemoveUTF8:=text;
end;

function ConvertDate(Date:string;format:byte):string;
var
   temp1, temp2, annee1, annee2, mois1, mois2, jour1, jour2: string;
   type1, type2, style : integer;
begin
   if copy(Date,1,1)<>'1' then
      ConvertDate := Copy(Date,2,length(Date))
   else
      begin
      annee1:=copy(Date,2,4);
      mois1 :=copy(Date,6,2);
      jour1 :=copy(Date,8,2);
      annee2:=copy(Date,12,4);
      mois2 :=copy(Date,16,2);
      jour2 :=copy(Date,18,2);
      style :=strtoint(copy(Date,11,1));
      type1:=0;
      type2:=0;
      if ((mois1='00') and (jour1='00')) then type1:=1 else    // annee seulement
      if ((annee1='0000') and (jour1='00')) then type1:=2 else // mois seulement
      if ((mois1='00') and (annee1='0000')) then type1:=3 else // jour seulement
      if (jour1='00') then type1:=4 else                       // manque jour seulement
      if (mois1='00') then type1:=5 else                       // manque mois seulement
      if (annee1='0000') then type1:=6;                        // manque annee seulement
      if ((mois2='00') and (jour2='00')) then type2:=1 else    // annee seulement
      if ((annee2='0000') and (jour2='00')) then type2:=2 else // mois seulement
      if ((mois2='00') and (annee2='0000')) then type2:=3 else // jour seulement
      if (jour2='00') then type2:=4 else                       // manque jour seulement
      if (mois2='00') then type2:=5 else                       // manque mois seulement
      if (annee2='0000') then type2:=6;                        // manque annee seulement
      if Copy(Date,1,21)='100000000030000000000' then
         ConvertDate :=''
      else
         begin
         If format=0 then
            begin
            Jour1:=IntToStr(StrtoInt(Jour1));
            Jour2:=IntToStr(StrtoInt(Jour2));
            Annee1:=IntToStr(StrtoInt(Annee1));
            Annee2:=IntToStr(StrtoInt(Annee2));
            if StrToInt(Jour1)=1 then Jour1:=AnsitoUTF8(Principale.Traduction.Items[74]);
            if StrToInt(Jour2)=1 then Jour2:=AnsitoUTF8(Principale.Traduction.Items[74]);
            case StrToInt(mois1) of
               1:mois1:=AnsitoUTF8(Principale.Traduction.Items[75]);
               2:mois1:=AnsitoUTF8(Principale.Traduction.Items[76]);
               3:mois1:=AnsitoUTF8(Principale.Traduction.Items[77]);
               4:mois1:=AnsitoUTF8(Principale.Traduction.Items[78]);
               5:mois1:=AnsitoUTF8(Principale.Traduction.Items[79]);
               6:mois1:=AnsitoUTF8(Principale.Traduction.Items[80]);
               7:mois1:=AnsitoUTF8(Principale.Traduction.Items[81]);
               8:mois1:=AnsitoUTF8(Principale.Traduction.Items[82]);
               9:mois1:=AnsitoUTF8(Principale.Traduction.Items[83]);
               10:mois1:=AnsitoUTF8(Principale.Traduction.Items[84]);
               11:mois1:=AnsitoUTF8(Principale.Traduction.Items[85]);
               12:mois1:=AnsitoUTF8(Principale.Traduction.Items[86]);
            end;
            case StrToInt(mois2) of
               1:mois2:=AnsitoUTF8(Principale.Traduction.Items[75]);
               2:mois2:=AnsitoUTF8(Principale.Traduction.Items[76]);
               3:mois2:=AnsitoUTF8(Principale.Traduction.Items[77]);
               4:mois2:=AnsitoUTF8(Principale.Traduction.Items[78]);
               5:mois2:=AnsitoUTF8(Principale.Traduction.Items[79]);
               6:mois2:=AnsitoUTF8(Principale.Traduction.Items[80]);
               7:mois2:=AnsitoUTF8(Principale.Traduction.Items[81]);
               8:mois2:=AnsitoUTF8(Principale.Traduction.Items[82]);
               9:mois2:=AnsitoUTF8(Principale.Traduction.Items[83]);
               10:mois2:=AnsitoUTF8(Principale.Traduction.Items[84]);
               11:mois2:=AnsitoUTF8(Principale.Traduction.Items[85]);
               12:mois2:=AnsitoUTF8(Principale.Traduction.Items[86]);
            end;
            case style of
               0:case type1 of
                    0:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[87])+Jour1+' '+Mois1+' '+Annee1;
                    1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[88])+Annee1;
                    2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[88])+Mois1;
                    3:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[89])+Jour1;
                    4:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[88])+Mois1+' '+Annee1;
                    5:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[89])+Jour1+
                                   AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[89])+Jour1+' '+Mois1;
                 end;
               1:case type1 of
                    0:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[91])+Jour1+' '+Mois1+' '+Annee1;
                    1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Annee1;
                    2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Mois1;
                    3:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1;
                    4:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Mois1+' '+Annee1;
                    5:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1+' '+Mois1;
                 end;
               2:case type1 of
                    0:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[91])+Jour1+' '+Mois1+' '+Annee1;
                    1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Annee1;
                    2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Mois1;
                    3:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1;
                    4:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[92])+Mois1+' '+Annee1;
                    5:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[93])+Jour1+' '+Mois1;
                 end;
               3:case type1 of
                    0:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[94])+Jour1+' '+Mois1+' '+Annee1;
                    1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[95])+Annee1;
                    2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[95])+Mois1;
                    3:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1;
                    4:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[95])+Mois1+' '+Annee1;
                    5:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1+' '+Mois1;
                 end;
               4:case type1 of
                    0:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[97])+Jour1+' '+Mois1+' '+Annee1;
                    1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[98])+Annee1;
                    2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[98])+Mois1;
                    3:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[99])+Jour1;
                    4:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[98])+Mois1+' '+Annee1;
                    5:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[99])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[99])+Jour1+' '+Mois1;
                 end;
               5:begin
                 case type1 of
                    0:temp1:=AnsitoUTF8(Principale.Traduction.Items[100])+Jour1+' '+Mois1+' '+Annee1;
                    1:temp1:=AnsitoUTF8(Principale.Traduction.Items[101])+Annee1;
                    2:temp1:=AnsitoUTF8(Principale.Traduction.Items[101])+Mois1;
                    3:temp1:=AnsitoUTF8(Principale.Traduction.Items[102])+Jour1;
                    4:temp1:=AnsitoUTF8(Principale.Traduction.Items[101])+Mois1+' '+Annee1;
                    5:temp1:=AnsitoUTF8(Principale.Traduction.Items[102])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:temp1:=AnsitoUTF8(Principale.Traduction.Items[102])+Jour1+' '+Mois1;
                 end;
                 case type2 of
                    0:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[103])+Jour2+' '+Mois2+' '+Annee2;
                    1:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[72])+Annee2;
                    2:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[72])+Mois2;
                    3:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[104])+Jour2;
                    4:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[72])+Mois2+' '+Annee2;
                    5:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[104])+Jour2+AnsitoUTF8(Principale.Traduction.Items[90])+Annee2;
                    6:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[104])+Jour2+' '+Mois2;
                 end;
                 end;
               6:begin
                 case type1 of
                    0:temp1:=AnsitoUTF8(Principale.Traduction.Items[94])+Jour1+' '+Mois1+' '+Annee1;
                    1:temp1:=AnsitoUTF8(Principale.Traduction.Items[95])+Annee1;
                    2:temp1:=AnsitoUTF8(Principale.Traduction.Items[95])+Mois1;
                    3:temp1:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1;
                    4:temp1:=AnsitoUTF8(Principale.Traduction.Items[95])+Mois1+' '+Annee1;
                    5:temp1:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:temp1:=AnsitoUTF8(Principale.Traduction.Items[96])+Jour1+' '+Mois1;
                 end;
                 case type2 of
                    0:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[105])+Jour2+' '+Mois2+' '+Annee2;
                    1:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[106])+Annee2;
                    2:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[106])+Mois2;
                    3:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[107])+Jour2;
                    4:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[106])+Mois2+' '+Annee2;
                    5:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[107])+Jour2+AnsitoUTF8(Principale.Traduction.Items[90])+Annee2;
                    6:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[107])+Jour2+' '+Mois2;
                 end;
                 end;
               7:begin
                 case type1 of
                    0:temp1:=AnsitoUTF8(Principale.Traduction.Items[108])+Jour1+' '+Mois1+' '+Annee1;
                    1:temp1:=AnsitoUTF8(Principale.Traduction.Items[109])+Annee1;
                    2:temp1:=AnsitoUTF8(Principale.Traduction.Items[109])+Mois1;
                    3:temp1:=AnsitoUTF8(Principale.Traduction.Items[110])+Jour1;
                    4:temp1:=AnsitoUTF8(Principale.Traduction.Items[109])+Mois1+' '+Annee1;
                    5:temp1:=AnsitoUTF8(Principale.Traduction.Items[110])+Jour1+AnsitoUTF8(Principale.Traduction.Items[90])+Annee1;
                    6:temp1:=AnsitoUTF8(Principale.Traduction.Items[110])+Jour1+' '+Mois1;
                 end;
                 case type2 of
                    0:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[111])+Jour2+' '+Mois2+' '+Annee2;
                    1:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[112])+Annee2;
                    2:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[112])+Mois2;
                    3:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[113])+Jour2;
                    4:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[112])+Mois2+' '+Annee2;
                    5:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[113])+Jour2+AnsitoUTF8(Principale.Traduction.Items[90])+Annee2;
                    6:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[113])+Jour2+' '+Mois2;
                 end;
                 end;
            end;
         end
         else
            begin
            case type1 of
               0:temp1:=Annee1+'/'+Mois1+'/'+Jour1;
               1:temp1:=Annee1;
               2:temp1:='.../'+Mois1+'/...';
               3:temp1:='.../.../'+Jour1;
               4:temp1:=Annee1+'/'+Mois1+'/...';
               5:temp1:=Annee1+'/.../'+Jour1;
               6:temp1:='.../'+Mois1+'/'+Jour1;
            end;
            case type2 of
               0:temp2:=Annee2+'/'+Mois2+'/'+Jour2;
               1:temp2:=Annee2;
               2:temp2:='.../'+Mois2+'/...';
               3:temp2:='.../.../'+Jour2;
               4:temp2:=Annee2+'/'+Mois2+'/...';
               5:temp2:=Annee2+'/.../'+Jour2;
               6:temp2:='.../'+Mois2+'/'+Jour2;
            end;
            case style of
               0:ConvertDate:='<'+temp1;
               1:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[114])+temp1;
               2:ConvertDate:=AnsitoUTF8(Principale.Traduction.Items[114])+temp1;
               3:ConvertDate:=temp1;
               4:ConvertDate:='>'+temp1;
               5:ConvertDate:=temp1+' - '+temp2;
               6:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[115])+temp2;
               7:ConvertDate:=temp1+AnsitoUTF8(Principale.Traduction.Items[112])+temp2;
            end;
         end;
      end;
   end;
end;

procedure SaveFormPosition(Sender: TForm);
var
     ini:TIniFile;
begin
     Ini := TIniFile.Create('Stemma.ini');
     ini.WriteInteger(Sender.Name,'Haut',Sender.Top);
     ini.WriteInteger(Sender.Name,'Gauche',Sender.Left);
     ini.WriteInteger(Sender.Name,'Hauteur',Sender.Height);
     ini.WriteInteger(Sender.Name,'Largeur',Sender.Width);
     Ini.Free;
end;

procedure SaveGridPosition(Sender: TStringGrid; cols:integer);
var
     ini:TIniFile;
     i:integer;
begin
     Ini := TIniFile.Create('Stemma.ini');
     For i:= 0 to cols-1 do
        ini.WriteInteger(Sender.Name,inttostr(i),Sender.Columns[i].width);
     Ini.Free;
end;

procedure GetFormPosition(Sender: TForm;a:integer;b:integer;c:integer;d:integer);
var
   ini:TIniFile;
begin
     Ini := TIniFile.Create('Stemma.ini');
     Sender.Top := ini.ReadInteger(Sender.Name,'Haut',a);
     Sender.Left := ini.ReadInteger(Sender.Name,'Gauche',b);
     Sender.Height := ini.ReadInteger(Sender.Name,'Hauteur',c);
     Sender.Width := ini.ReadInteger(Sender.Name,'Largeur',d);
     Ini.Free;
end;

function EstimatePlace(lieu:string;registre:string):string;
var
   temp:string;
begin
   temp:='';
   if length(lieu)>0 then
      temp:='1';
   if (lowercase(lieu)='broughton') then
        temp:='29846';
   if (lowercase(lieu)='québec') then
        temp:='22894';
   if (lowercase(lieu)='st-elzéar') or (lowercase(lieu)='saint-elzéar') then
        temp:='33724';
   if (lowercase(lieu)='ste-marie') or (lowercase(lieu)='sainte-marie') then
        temp:='31031';
   if (lowercase(lieu)='st-gilles') or (lowercase(lieu)='saint-gilles') then
        temp:='27986';
   if (lowercase(lieu)='st-giles') or (lowercase(lieu)='saint-giles') then
        temp:='27986';
   if (lowercase(lieu)='st-sylvestre') or (lowercase(lieu)='saint-sylvestre') then
        temp:='32334';
   if (lowercase(lieu)='cette paroisse') then
        temp:=registre;
   EstimatePlace:=temp;
end;

procedure GetGridPosition(Sender: TStringGrid;cols:integer);
var
   ini:TIniFile;
   i: integer;
begin
     Ini := TIniFile.Create('Stemma.ini');
     For i:= 0 to cols-1 do
        Sender.Columns[i].Width :=ini.ReadInteger(Sender.Name,inttostr(i),15);
     Ini.Free;
end;

function CodeName(Titre:string;Prenom:string;Nom:string;suffixe:string):string;
var
   temp:string;
begin
   temp:='';
   if length(Titre)>0 then
      temp:=temp+'<Titre>'+Titre+'</Titre>';
   if length(Prenom)>0 then
      temp:=temp+'<Prénom>'+Prenom+'</Prénom>';
   if length(Nom)>0 then
      temp:=temp+'<Nom>'+Nom+'</Nom>';
   if length(Suffixe)>0 then
      temp:=temp+'<Suffixe>'+Suffixe+'</Suffixe>';
   CodeName:=AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(temp,'\','\\'),'"','\"'),'''','\''');
end;

function DecodeName(Name:string;format:byte):string;
var
   titre,prenom,nom,suffixe,temp,nomcomplet:string;
   Pos1, Pos2:integer;
begin
   nomcomplet := '';
   temp:=Name;
   titre:='';
   prenom:='';
   nom:='';
   suffixe:='';
   if copy(Name,1,5)='!TMG|' then
      begin
      temp := copy(temp,6,length(temp));
      nom := trim(copy(temp,1,AnsiPos('|',temp)-1));
      temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
      titre := trim(copy(temp,1,AnsiPos('|',temp)-1));
      temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
      prenom := trim(copy(temp,1,AnsiPos('|',temp)-1));
      temp := copy(temp,AnsiPos('|',temp)+1,length(temp));
      suffixe := trim(copy(temp,1,AnsiPos('|',temp)-1));
   end
   else
      begin
      // Traiter les noms avec <N=TITRE></N>...
      Pos1:=AnsiPos('<Titre>',temp)+7;
      Pos2:=AnsiPos('</Titre>',temp);
      if (Pos1+Pos2)>7 then
         titre:=Copy(temp,Pos1,Pos2-Pos1);
      Pos1:=AnsiPos('<Prénom>',temp)+9;     // 9 car le 'é' prends 2 position en ANSI
      Pos2:=AnsiPos('</Prénom>',temp);
      if (Pos1+Pos2)>9 then
         prenom:=Copy(temp,Pos1,Pos2-Pos1);
      Pos1:=AnsiPos('<Nom>',temp)+5;
      Pos2:=AnsiPos('</Nom>',temp);
      if (Pos1+Pos2)>5 then
         nom:=Copy(temp,Pos1,Pos2-Pos1);
      Pos1:=AnsiPos('<Suffixe>',temp)+9;
      Pos2:=AnsiPos('</Suffixe>',temp);
      if (Pos1+Pos2)>9 then
         Suffixe:=Copy(temp,Pos1,Pos2-Pos1);
   end;
   if format = 1 then
      begin
      If length(titre) > 0 then
         nomcomplet := titre;
      If length(prenom) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := prenom
         else
            nomcomplet := nomcomplet + ' ' + prenom;
      If length(nom) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := nom
         else
            nomcomplet := nomcomplet + ' ' + nom;
      If length(suffixe) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := suffixe
         else
            nomcomplet := nomcomplet + ' ' + suffixe;
   end;
   if format = 2 then
      begin
      If length(nom) > 0 then
         nomcomplet := nom;
      If length(suffixe) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := suffixe
         else
            nomcomplet := nomcomplet + ' ' + suffixe;
      If length(prenom) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := ', '+prenom
         else
            nomcomplet := nomcomplet + ', ' + prenom;
      If length(titre) > 0 then
         If length(nomcomplet) = 0 then
            nomcomplet := '('+titre+')'
         else
            nomcomplet := nomcomplet + ' (' + titre + ')';
   end;
   If length(nomcomplet) = 0 then nomcomplet := '???';
   if format = 3 then // Titre
      nomcomplet:=titre;
   if format = 4 then // Prénom
      nomcomplet:=prenom;
   if format = 5 then // Nom
      nomcomplet:=nom;
   if format = 6 then // Suffixe
      nomcomplet:=suffixe;
   DecodeName := nomcomplet;
end;

end.

