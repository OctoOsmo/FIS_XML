program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  PackageDataXML in 'PackageDataXML.pas',
  ImportResultXML in 'ImportResultXML.pas',
  GetListDict in 'GetListDict.pas',
  GetDict in 'GetDict.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
