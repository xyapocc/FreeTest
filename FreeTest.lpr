program FreeTest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Main, About, Establish, Open
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TEstablishForm, EstablishForm);
  Application.CreateForm(TOpenForm, OpenForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.

