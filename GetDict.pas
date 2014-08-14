unit GetDict;

interface
uses XMLDoc,xmldom, XMLIntf, oxmldom, msxmldom, SysUtils,Messages,Dialogs,Windows;
//procedure GetDictionary(doc: IXMLDocument);

implementation

uses Unit1;

{procedure GetDictionary(doc: IXMLDocument);
begin
doc.Version:='1.0';
doc.Encoding:='utf-8';
with doc.AddChild('Root') do
  begin
    with AddChild('AuthData') do
      begin
        AddChild('Login');
        ChildValues['Login']:=Form1.LoginEdit.Text;
        AddChild('Pass');
        ChildValues['Pass']:=Form1.PassEdit.Text;
      end;
    with AddChild('GetDictionaryContent') do
      begin
        AddChild('DictionaryCode');
        ChildValues['DictionaryCode']:=Form1.CodeEdit.Text;
      end;
  end;
Doc.SaveToFile('GetDict.xml');
end;}
end.

