program Stemma;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, dbflaz, Unit1, FMUtils, ConnectDb, zcomponent, Noms, Explorateur,
  Parents, Historique, Enfants, Fratrie, evenements, exhibits, Ancetres,
  Descendants, Edit_Exhibits, Show_Image, Image, Edit_Parents, Edit_Citations,
  Edit_Nom, Edit_Evenements, Edit_Temoin, Lieux, Utilisation, Sources, Depots,
  Edit_Source, unitTypes, Edit_Type, a_propos, SelectPersonne, ToDoList,
  ZoneTampon, Explorateur2, AjouteBapteme, AjouteMariage, AjouterSepulture;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPrincipale, Principale);
  Application.CreateForm(TConnexionDb, ConnexionDb);
  Application.CreateForm(TFormNoms, FormNoms);
  Application.CreateForm(TFormExplorateur, FormExplorateur);
  Application.CreateForm(TFormEnfants, FormEnfants);
  Application.CreateForm(TFormHistorique, FormHistorique);
  Application.CreateForm(TFormParents, FormParents);
  Application.CreateForm(TFormFratrie, FormFratrie);
  Application.CreateForm(TFormEvenements, FormEvenements);
  Application.CreateForm(TFormExhibits, FormExhibits);
  Application.CreateForm(TFormAncetres, FormAncetres);
  Application.CreateForm(TFormDescendants, FormDescendants);
  Application.CreateForm(TEditExhibits, EditExhibits);
  Application.CreateForm(TShowImage, ShowImage);
  Application.CreateForm(TFormImage, FormImage);
  Application.CreateForm(TEditParents, EditParents);
  Application.CreateForm(TEditCitations, EditCitations);
  Application.CreateForm(TEditNom, EditNom);
  Application.CreateForm(TEditEvenement, EditEvenement);
  Application.CreateForm(TEditTemoin, EditTemoin);
  Application.CreateForm(TFormLieux, FormLieux);
  Application.CreateForm(TFormUtilisation, FormUtilisation);
  Application.CreateForm(TFormSources, FormSources);
  Application.CreateForm(TFormDepots, FormDepots);
  Application.CreateForm(TEditSource, EditSource);
  Application.CreateForm(TFormTypes, FormTypes);
  Application.CreateForm(TEditType, EditType);
  Application.CreateForm(Tapropos, apropos);
  Application.CreateForm(TFormSelectPersonne, FormSelectPersonne);
  Application.CreateForm(TFormToDoList, FormToDoList);
  Application.CreateForm(TAjouteBapt, AjouteBapt);
  Application.CreateForm(TAjouteMar, AjouteMar);
  Application.CreateForm(TAjouterSep, AjouterSep);
  Application.Run;
end.

