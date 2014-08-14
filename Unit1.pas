{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBCustomDataSet, IBDatabase, DB, IBTable, Grids, DBGrids,
  StdCtrls, xmldom, XMLIntf, oxmldom, XMLDoc, msxmldom, PackageDataXML, ImportResultXML,
  IBQuery, ExtCtrls, GetDict, Menus, OleCtrls,
  TypInfo, XMLSchema, SOAPHTTPPasInv, ComCtrls, SOAPHTTPTrans;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    IBTable1: TIBTable;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBDataSet1: TIBDataSet;
    IBQuery1: TIBQuery;
    MainMenu: TMainMenu;
    Create1: TMenuItem;
    Get1: TMenuItem;
    GetDictionary: TMenuItem;
    HTTPReqResp1: THTTPReqResp;
    ProgressBar1: TProgressBar;
    CreateImportpackage: TMenuItem;
    GetDictionaryList: TMenuItem;
    Send1: TMenuItem;
    XMLDocument1: TXMLDocument;
    Validate: TMenuItem;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Import: TMenuItem;
    ImportResult: TMenuItem;
    Edit2: TEdit;
    IBQueryMain: TIBQuery;
    EditNomAbFrom: TEdit;
    EditNomAbTo: TEdit;
    EditPackageSize: TEdit;
    LabelPackageSize: TLabel;
    LabelNomAbTo: TLabel;
    LabelProxy: TLabel;
    CreateDeletePackage: TMenuItem;
    Delete: TMenuItem;
    GetDeleteResult: TMenuItem;
    CreateAdmissionPackage: TMenuItem;
    AdmissionImport: TMenuItem;
    AdmissionImportResult: TMenuItem;
    MemoResult: TMemo;
    LabelNomAbFrom: TLabel;
    LabelServicePath: TLabel;
    LabelPackageID: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GetDictClick(Sender: TObject);
    procedure GetDictionaryClick(Sender: TObject);
    procedure CreateImportpackageClick(Sender: TObject);
    procedure GetDictionaryListClick(Sender: TObject);
    procedure SendPackageData1Click(Sender: TObject);
    procedure ValidateClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ImportClick(Sender: TObject);
    procedure ImportResultClick(Sender: TObject);
    procedure CreateDeletePackageClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure GetDeleteResultClick(Sender: TObject);
    procedure CreateAdmissionPackageClick(Sender: TObject);
    procedure AdmissionImportClick(Sender: TObject);
    procedure AdmissionImportResultClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  //const N_Dic=33;
var
  Form1: TForm1;
  N_Dic: integer;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  //  ComboBox1.Items := IBTable1.TableNames;
  //Задаём параметры
  Form1.HTTPReqResp1.SendTimeout := 3600000;
  Form1.HTTPReqResp1.ReceiveTimeout := 3600000;
  Form1.HTTPReqResp1.ConnectTimeout := 3600000;
end;

procedure PutAdmissionResultToMemo(admission_path: string; var memo: TMemo);
var
  admission_result: TextFile;
  s: UTF8string;
begin
  //Открываем файл
  AssignFile(admission_result, 'AdmissionData\AdmissionImportResultID.xml');
  Reset(admission_result);
  memo.Lines.Clear;
  while not Eof(admission_result) do
  begin
    ReadLn(admission_result, s); //Считываем строку из файла
    memo.Lines.Add(UTF8ToAnsi(s)); //Заносим строку в Мемо с перекодировкой
  end;
  CloseFile(admission_result);
end;

procedure TForm1.Button1Click(Sender: TObject);
//var
//  admission_result: TextFile;
//  s: UTF8string;
begin
  PutAdmissionResultToMemo('AdmissionData\AdmissionImportResultID.xml', Form1.MemoResult);
  //  //Открываем файл
  //  AssignFile(admission_result, 'AdmissionData\AdmissionImportResultID.xml');
  //  Reset(admission_result);
  //  Form1.MemoResult.Lines.Clear;
  //  while not Eof(admission_result) do
  //  begin
  //    ReadLn(admission_result, s); //Считываем строку из файла
  //    Form1.MemoResult.Lines.Add(UTF8ToAnsi(s)); //Заносим строку в Мемо с перекодировкой
  //  end;
  //  Form1.MemoResult.Lines.LoadFromFile('AdmissionData\AdmissionImportResultID.xml');
  //  Form1.MemoResult.Lines.

end;

procedure TForm1.GetDictClick(Sender: TObject);
var
  GetDic: IXMLDocument;
begin
  GetDic := TXMLDocument.Create(nil);
  GetDic.Active := true;
  //GetDictionary(GetDic);
  GetDic.Active := false;
end;

procedure TForm1.GetDictionaryClick(Sender: TObject);
var
  req, resp: TStringstream;
  context, i, j: integer;
  gd, rd: IXMLDocument;
  //IsGet: boolean;
begin
  gd := TXMLDocument.Create(nil);
  gd.Active := true;
  gd.Version := '1.0';
  gd.Encoding := 'utf-8';
  rd := TXMLDocument.Create(nil);
  rd.Active := true;
  rd.Version := '1.0';
  rd.Encoding := 'utf-8';
  //httpreqresp1.URL := 'http://priem.edu.ru:8000/import/importservice.svc/dictionarydetails';
  httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/dictionarydetails';
  //OpenDialog1.Execute;
  //for i := 1 to 34 {N_dic} do //В данный момент справочник №34 последний
  i := 1;
  while i <= 34 do
  begin
    gd.XML.Clear;
    gd.Active := true;
    rd.XML.Clear;
    with gd.AddChild('Root') do
    begin
      with AddChild('AuthData') do
      begin
        AddChild('Login');
        ChildValues['Login'] := 'at@vsma.ac.ru'; //'ziborova@vsma.ac.ru';
        AddChild('Pass');
        ChildValues['Pass'] := 'BRalQhv'; //'w5Mzjyx';
      end;
      with AddChild('GetDictionaryContent') do
      begin
        AddChild('DictionaryCode');
        ChildValues['DictionaryCode'] := i;
      end;
    end;

    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    for j := 0 to gd.XML.Count - 1 do
      req.WriteString(gd.XML.Strings[j]);

    context := httpreqresp1.Send(req);
    httpreqresp1.Receive(context, resp);

    rd.Active := true;
    rd.LoadFromStream(resp, xetUTF_8);
    rd.XML.Text;
    rd.SaveToFile('Dictionary/' + IntToStr(i) + rd.ChildNodes.Nodes[0].childNodes['Name'].NodeValue + '.xml');
    { if IsGet then
     dicname[i]:=rd.ChildNodes.Nodes[0].childNodes['Name'].NodeValue+'.xml';}
    ProgressBar1.Position := trunc(i * 100 / 34);
    req.Free;
    resp.Free;
    case i of
      2: i := i + 2;
      7: i := i + 3;
      15: i := i + 2;
      19: i := i + 3;
      23: i := i + 7;
    else
      i := i + 1;
    end;
  end;
  MessageBox(0, 'Процесс получения справочников завершён!', 'Успех!', MB_OK);
end;

procedure TForm1.CreateImportpackageClick(Sender: TObject);
var
  PacData {, ImportRes}: IXMLDocument;
  nom_af_from, nom_af_to, nom_af_max, i, package_size: integer; //номера записей, количество записей
begin
  Form1.Caption := '0';
  //подсчёт количества записей в таблице ABIT_FAK
  //PackageDataXML.post('SELECT max(NOM_AF) from ABIT_FAK');
  PackageDataXML.PostToQuery('SELECT MAX(NOM_AF) FROM ABIT_FAK', Form1.IBQueryMain);
  //PackageDataXML.PostToQuery('select count(NOM_AB) from abit',Form1.IBQueryMain);
  Form1.IBQueryMain.Last; //необходимо для верного подсчёта количества записей
  //nom_ab_max := Form1.IBQueryMain.FieldByName('COUNT').AsInteger;
  //nom_af_max:=Form1.IBQueryMain.FieldByName('MAX').AsInteger;
  nom_af_max := StrToInt(EditNomAbTo.Text);
  Form1.ProgressBar1.Position := 0;
  Form1.ProgressBar1.Max := nom_af_max;
  Form1.IBQueryMain.Close;
  //конец подсчёта количества записей в таблице ABIT_FAK
  //package_size := 50; //максимальная величина пакета
  package_size := StrToInt(EditPackageSize.Text); //максимальная величина пакета
  i := StrToInt(EditNomAbFrom.Text);
  while i <= nom_af_max do
  begin
    nom_af_from := i;
    nom_af_to := i + package_size;
    PacData := TXMLDocument.Create(nil);
    PacData.Active := true;
    PackageDataXML.CreatePatternPackageData(PacData, nom_af_from, nom_af_to);
    //Form1.IBQueryMain.Next;
    //Form1.IBQuery1.Close;
    //Form1.IBQueryMain.Close;
    //PacData.Active := false;
    PacData := nil;
    //PacData.Destroy;
    //PacData.Create(nil);
    i := i + package_size;
    Form1.ProgressBar1.Position := i;
  end;
  MessageBox(0, 'Процедура создания пакетов завершена', 'Информация', MB_OK);
  //ImportRes := TXMLDocument.Create(nil);
  //ImportRes.Active := true;
  //ImportResultXML.CreatePatternResultImportPackage(ImportRes);
  //ImportRes.Active := false;

  //PackData.XML;

end;

procedure TForm1.GetDictionaryListClick(Sender: TObject);
var
  reqxml, respxml: IXMLDocument;
  req, resp: TStringstream;
  context, j: integer;
begin
  reqxml := TXMLDocument.Create(nil);
  reqxml.Active := true;
  reqxml.Version := '1.0';
  reqxml.Encoding := 'utf-8';
  respxml := TXMLDocument.Create(nil);
  respxml.Active := true;
  respxml.Version := '1.0';
  respxml.Encoding := 'utf-8';
  //httpreqresp1.URL := 'http://priem.edu.ru:8000/import/importservice.svc/dictionary';
  httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/dictionary';
  //OpenDialog1.Execute;
  //ok:=MessageBox(0,'Изменить Логин и Пароль для входа в ФИС?','',MB_OKCANCEL);
  //if ok=1 then GroupBox1.Visible:=true;
  with reqxml.AddChild('Root') do
  begin
    with AddChild('AuthData') do
    begin
      AddChild('Login');
      ChildValues['Login'] := 'at@vsma.ac.ru';
      AddChild('Pass');
      ChildValues['Pass'] := 'BRalQhv';
    end;
  end;
  resp := TStringStream.Create('');
  req := TStringStream.Create('');
  for j := 0 to reqxml.XML.Count - 1 do
    req.WriteString(reqxml.XML.Strings[j]);

  context := httpreqresp1.Send(req);
  httpreqresp1.Receive(context, resp);

  respxml.Active := true;
  respxml.LoadFromStream(resp, xetUTF_8);

  respxml.SaveToFile({OpenDialog1.FileName+}'ListDictionary.xml');

end;

procedure TForm1.SendPackageData1Click(Sender: TObject);

begin

end;
//-----------------------------------

procedure TForm1.ValidateClick(Sender: TObject);
var
  reqxml, respxml: IXMLDocument;
  //vendor: TDOMVendor;
  req, resp: TStringstream;
  context, i, j: integer;
  nom_af_max, step: integer;
begin
  j := StrToInt(EditNomAbFrom.Text);
  nom_af_max := StrToInt(EditNomAbTo.Text); //8908;
  Form1.ProgressBar1.Max := nom_af_max;
  step := StrToInt(EditPackageSize.Text);
  while j <= nom_af_max do
  begin
    reqxml := TXMLDocument.Create(nil);
    respxml := TXMLDocument.Create(nil);
    //vendor := TDOMVendor.Create;
    //vendor := DOMVendors.Find('Open XML');
    //reqxml.Active := true;
    //reqxml.Version := '1.0';
    //reqxml.Encoding := 'utf-8';
    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    reqxml.Active := true;
    reqxml.LoadFromFile('PackageData\PackageData' + IntToStr(j) + '.xml');
    for i := 0 to reqxml.XML.Count - 1 do
      req.WriteString(reqxml.XML.Strings[i]);
    httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/validate';
    //httpreqresp1.URL:=ComboBox3.Text;
    context := httpreqresp1.Send(req);
    httpreqresp1.Receive(context, resp);

    respxml.Active := true;
    respxml.LoadFromStream(resp, xetUTF_8);

    respxml.SaveToFile('ValidationResult\ValidationResult' + IntToStr(j) + '.xml');
    j := j + step;
    Form1.ProgressBar1.Position := j;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  httpreqresp1.Proxy := ComboBox2.Text;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  //httpreqresp1.URL:=ComboBox3.Text;
end;

procedure TForm1.ImportClick(Sender: TObject); //импорт пакета в систему
var
  reqxml, respxml: IXMLDocument;
  //vendor: TDOMVendor;
  req, resp: TStringstream;
  context, i, j: integer;
  nom_af_max, step: integer;
begin
  j := StrToInt(EditNomAbFrom.Text);
  nom_af_max := StrToInt(EditNomAbTo.Text); //8908;
  step := StrToInt(EditPackageSize.Text);
  Form1.ProgressBar1.Max := nom_af_max;
  while j <= nom_af_max do
  begin
    reqxml := TXMLDocument.Create(nil);
    respxml := TXMLDocument.Create(nil);
    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    reqxml.Active := true;
    reqxml.LoadFromFile('PackageData\PackageData' + IntToStr(j) + '.xml');
    for i := 0 to reqxml.XML.Count - 1 do
      req.WriteString(reqxml.XML.Strings[i]);
    httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/import';
    //httpreqresp1.URL:=ComboBox3.Text;
    context := httpreqresp1.Send(req);
    // httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/import/result';
    httpreqresp1.Receive(context, resp);
    respxml.Active := true;
    respxml.LoadFromStream(resp, xetUTF_8);
    //respxml.Node
    //respxml.ChildNodes.FindNode('ImportPackageInfo');
    {respxml.Node.
    with respxml.Node.ChildNodes.FindNode('PackageID') do
    begin
        PackageID := ChildValues['PackageID'];
    end;
    }
    respxml.SaveToFile('ImportResultID\ImportResultID' + IntToStr(j) + '.xml'); //номер запроса импорта, для дальнейшего получения результата
    j := j + step;
    Form1.ProgressBar1.Position := j;
  end;
end;

procedure TForm1.ImportResultClick(Sender: TObject); //получение результата импорта
var
  reqxml, respxml, ImportIDxml, ImportResultXML: IXMLDocument;
  //vendor: TDOMVendor;
  req, resp: TStringstream;
  context, i, j, k, PackageID: integer;
  nom_af_max, step: integer;
  FileName: string;
  ImportResultFile: TextFile;
begin
  AssignFile(ImportResultFile, 'ImportResult\ImportResult.xml');
  Rewrite(ImportResultFile);
  j := StrToInt(EditNomAbFrom.Text);
  nom_af_max := StrToInt(EditNomAbTo.Text); //8908;
  step := StrToInt(EditPackageSize.Text);
  Form1.ProgressBar1.Max := nom_af_max;
  ImportResultXML := TXMLDocument.Create(nil);
  ImportResultXML.Active := true;
  //ImportResultXML.LoadFromFile('ImportResult\ImportResult.xml');
  ImportResultXML.XML.Clear;
  ImportResultXML.Active := true;
  ImportResultXML.AddChild('root');
  //with ImportResultXML.AddChild('Root') do
  //begin
  while j <= nom_af_max do
  begin
    reqxml := TXMLDocument.Create(nil);
    respxml := TXMLDocument.Create(nil);
    ImportIDxml := TXMLDocument.Create(nil);
    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    reqxml.Active := true;
    ImportIDxml.Active := true;
    FileName := 'ImportResultId\ImportResultID' + IntToStr(j) + '.xml';
    if (FileExists(FileName)) then
    begin
      ImportIDxml.LoadFromFile(FileName);
      ImportIDxml.Active := true;
      if (ImportIDxml.ChildNodes.First.NodeName = 'ImportPackageInfo') then
      begin
        PackageID := ImportIDxml.ChildNodes.FindNode('ImportPackageInfo').ChildNodes.FindNode('PackageID').NodeValue;
        with reqxml do
        begin
          with AddChild('Root') do
          begin
            with AddChild('AuthData') do
            begin
              AddChild('Login');

              ChildValues['Login'] := 'at@vsma.ac.ru';
              AddChild('Pass');

              ChildValues['Pass'] := 'BRalQhv';
            end;
            with AddChild('GetResultImportApplication') do
            begin
              with AddChild('PackageID') do
              begin
                ChildValues['PackageID'] := PackageID;
              end;
            end;
          end;
        end;
        for i := 0 to reqxml.XML.Count - 1 do
          req.WriteString(reqxml.XML.Strings[i]);
        httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/import/result';
        context := httpreqresp1.Send(req);
        httpreqresp1.Receive(context, resp);
        respxml.Active := true;
        respxml.LoadFromStream(resp, xetUTF_8);
        //with ImportResultXML.ChildNodes.FindNode('root') do
        //begin
        //for k := 0 to respxml.ChildNodes.Count - 1 do
        //begin
        //  ImportResultXML.XML.Add(respxml.XML.Strings[k])
        //end;
        //end;
        for k := 0 to respxml.ChildNodes.Count - 1 do
        begin
          WriteLn(ImportResultFile, respxml.xml.strings[k]);
          //WriteLn(ImportResultFile, '123123123');
        end;
        respxml.SaveToFile('ImportResult\ImportResult' + IntToStr(j) + '.xml'); //результат импорта
        //respxml.XML.Strings;
        //ImportResultXML.XML.AddStrings(respxml.XML);
      end;
    end;
    j := j + step;
    Form1.ProgressBar1.Position := j;
    Form1.Caption := IntToStr(j);
  end;
  CloseFile(ImportResultFile);
  //end;
  //ImportResultXML.Active := true;
  //ImportResultXML.SaveToFile('ImportResult\ImportResult.xml'); //результат импорта
  //showmessage(IntToStr(PackageID) + ' ' + IntToStr(j));
end;

procedure TForm1.CreateDeletePackageClick(Sender: TObject);
var
  package_size, nom_af_max, nom_af_from, nom_af_to, i: integer;
begin
  //подсчёт количества записей в таблице ABIT_FAK
  PackageDataXML.PostToQuery('SELECT MAX(NOM_AF) FROM ABIT_FAK', Form1.IBQueryMain);
  Form1.IBQueryMain.Last; //необходимо для верного подсчёта количества записей
  nom_af_max := StrToInt(EditNomAbTo.Text) - StrToInt(EditNomAbFrom.Text);
  Form1.ProgressBar1.Position := 0;
  Form1.ProgressBar1.Max := nom_af_max;
  Form1.IBQueryMain.Close;
  //конец подсчёта количества записей в таблице ABIT_FAK
  package_size := StrToInt(EditPackageSize.Text); //максимальная величина пакета
  i := StrToInt(EditNomAbFrom.Text);
  while i <= nom_af_max do
  begin
    //nom_af_from := StrToInt(EditNomAbFrom.Text);
    //nom_af_to := StrToInt(EditNomAbTo.Text);
    nom_af_from := i;
    nom_af_to := i + package_size;
    PackageDataXML.CreateDeletePackage(nom_af_from, nom_af_to);
    i := i + package_size;
    Form1.ProgressBar1.Position := i;
  end;
  MessageBox(0, 'Процедура создания пакетов с данными для удаления завершена', 'Информация', MB_OK);
  //--------------

  {PacData := TXMLDocument.Create(nil);
  PacData.Active := true;
  PackageDataXML.CreatePatternPackageData(PacData, nom_af_from, nom_af_to);
  PacData.Active := false;

  ImportRes := TXMLDocument.Create(nil);
  ImportRes.Active := true;
  ImportResultXML.CreatePatternResultImportPackage(ImportRes);
  ImportRes.Active := false; }
end;

procedure TForm1.DeleteClick(Sender: TObject);
var
  reqxml, respxml: TXMLDocument;
  req, resp: TStringstream;
  context, i, j: integer;
  nom_af_max, step: integer;
begin
  j := StrToInt(EditNomAbFrom.Text);
  nom_af_max := StrToInt(EditNomAbTo.Text) - StrToInt(EditNomAbFrom.Text);
  step := StrToInt(EditPackageSize.Text);
  Form1.ProgressBar1.Max := nom_af_max;
  while j <= nom_af_max do
  begin
    reqxml := TXMLDocument.Create(nil);
    reqxml.Active := true;
    reqxml.Version := '1.0';
    reqxml.Encoding := 'utf-8';
    respxml := TXMLDocument.Create(nil);
    respxml.Active := true;
    respxml.Version := '1.0';
    respxml.Encoding := 'utf-8';
    reqxml.XML.LoadFromFile('DeleteData/DeleteData' + IntToStr(j) + '.xml');
    httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/delete';
    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    for i := 0 to reqxml.XML.Count - 1 do
      req.WriteString(reqxml.XML.Strings[i]);
    context := httpreqresp1.Send(req);
    httpreqresp1.Receive(context, resp);
    respxml.Active := true;
    respxml.LoadFromStream(resp, xetUTF_8);
    respxml.SaveToFile('DeleteResultID/DeleteResultID' + IntToStr(j) + '.xml');
    j := j + step;
    Form1.ProgressBar1.Position := j;
  end;
end;

procedure TForm1.GetDeleteResultClick(Sender: TObject);
var
  reqxml, respxml, DeleteIDxml {, ImportResultXML}: IXMLDocument;
  //vendor: TDOMVendor;
  req, resp: TStringstream;
  context, i, j, k, PackageID: integer;
  nom_af_max, step: integer;
  FileName: string;
  //ImportResultFile: TextFile;
begin
  //AssignFile(ImportResultFile, 'ImportResult\ImportResult.xml');
  //Rewrite(ImportResultFile);
  j := StrToInt(EditNomAbFrom.Text);
  nom_af_max := StrToInt(EditNomAbTo.Text); //8908;
  step := StrToInt(EditPackageSize.Text);
  Form1.ProgressBar1.Max := nom_af_max;
  //ImportResultXML := TXMLDocument.Create(nil);
  //ImportResultXML.Active := true;
  //ImportResultXML.LoadFromFile('ImportResult\ImportResult.xml');
  //ImportResultXML.XML.Clear;
  //ImportResultXML.Active := true;
  //ImportResultXML.AddChild('root');
  //with ImportResultXML.AddChild('Root') do
  //begin
  while j <= nom_af_max do
  begin
    reqxml := TXMLDocument.Create(nil);
    respxml := TXMLDocument.Create(nil);
    DeleteIDxml := TXMLDocument.Create(nil);
    resp := TStringStream.Create('');
    req := TStringStream.Create('');
    reqxml.Active := true;
    DeleteIDxml.Active := true;
    FileName := 'DeleteResultId\DeleteResultID' + IntToStr(j) + '.xml';
    if (FileExists(FileName)) then
    begin
      DeleteIDxml.LoadFromFile(FileName);
      DeleteIDxml.Active := true;
      if (DeleteIDxml.ChildNodes.First.NodeName = 'DeletePackageInfo') then
      begin
        PackageID := DeleteIDxml.ChildNodes.FindNode('DeletePackageInfo').ChildNodes.FindNode('PackageID').NodeValue;
        with reqxml do
        begin
          with AddChild('Root') do
          begin
            with AddChild('AuthData') do
            begin
              AddChild('Login');

              ChildValues['Login'] := 'at@vsma.ac.ru';
              AddChild('Pass');

              ChildValues['Pass'] := 'BRalQhv';
            end;
            with AddChild('GetResultDeleteApplication') do
            begin
              with AddChild('PackageGUID') do
              begin
                ChildValues['PackageGUID'] := PackageID;
              end;
            end;
          end;
        end;
        for i := 0 to reqxml.XML.Count - 1 do
          req.WriteString(reqxml.XML.Strings[i]);
        httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/delete/result';
        context := httpreqresp1.Send(req);
        httpreqresp1.Receive(context, resp);
        respxml.Active := true;
        respxml.LoadFromStream(resp, xetUTF_8);
        //with ImportResultXML.ChildNodes.FindNode('root') do
        //begin
        //for k := 0 to respxml.ChildNodes.Count - 1 do
        //begin
        //  ImportResultXML.XML.Add(respxml.XML.Strings[k])
        //end;
        //end;
        for k := 0 to respxml.ChildNodes.Count - 1 do
        begin
          //WriteLn(ImportResultFile, respxml.xml.strings[k]);
          //WriteLn(ImportResultFile, '123123123');
        end;
        respxml.SaveToFile('DeleteResult\DeleteResult' + IntToStr(j) + '.xml'); //результат импорта
        //respxml.XML.Strings;
        //ImportResultXML.XML.AddStrings(respxml.XML);
      end;
    end;
    j := j + step;
    Form1.ProgressBar1.Position := j;
    Form1.Caption := IntToStr(j);
  end;
  //CloseFile(ImportResultFile);
  //end;
  //ImportResultXML.Active := true;
  //ImportResultXML.SaveToFile('ImportResult\ImportResult.xml'); //результат импорта
  //showmessage(IntToStr(PackageID) + ' ' + IntToStr(j));
end;

procedure TForm1.CreateAdmissionPackageClick(Sender: TObject);
begin
  PackageDataXML.CreateOrdersOfAdmissionPackage();
  ShowMessage('Процедура выгрузки приказа на зачисление завершена');
end;

procedure TForm1.AdmissionImportClick(Sender: TObject);
var
  reqxml, respxml: IXMLDocument;
  req, resp: TStringstream;
  //FileName: string;
  context, i: integer;
begin
  reqxml := TXMLDocument.Create(nil);
  respxml := TXMLDocument.Create(nil);
  resp := TStringStream.Create('');
  req := TStringStream.Create('');
  reqxml.Active := true;
  reqxml.LoadFromFile('AdmissionData\AdmissionData.xml');
  for i := 0 to reqxml.XML.Count - 1 do
    req.WriteString(reqxml.XML.Strings[i]);
  httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/import';
  context := httpreqresp1.Send(req);
  httpreqresp1.Receive(context, resp);
  respxml.Active := true;
  respxml.LoadFromStream(resp, xetUTF_8);
  respxml.SaveToFile('AdmissionData\AdmissionImportResultID.xml'); //номер запроса импорта, для дальнейшего получения результата
  PutAdmissionResultToMemo('AdmissionData\AdmissionImportResultID.xml', Form1.MemoResult);//Выводим результат отправки пакета
  ShowMessage('Процедура отправки приказа на зачисление завершена');
end;

procedure TForm1.AdmissionImportResultClick(Sender: TObject);
var
  reqxml, respxml, ImportIDxml, ImportResultXML: IXMLDocument;
  req, resp: TStringstream;
  context, i, k, PackageID: integer;
  FileName: string;
  ImportResultFile: TextFile;
begin
  AssignFile(ImportResultFile, 'ImportResult\ImportResult.xml');
  Rewrite(ImportResultFile);
  ImportResultXML := TXMLDocument.Create(nil);
  ImportResultXML.Active := true;
  ImportResultXML.XML.Clear;
  ImportResultXML.Active := true;
  ImportResultXML.AddChild('root');
  reqxml := TXMLDocument.Create(nil);
  respxml := TXMLDocument.Create(nil);
  ImportIDxml := TXMLDocument.Create(nil);
  resp := TStringStream.Create('');
  req := TStringStream.Create('');
  reqxml.Active := true;
  ImportIDxml.Active := true;
  FileName := 'AdmissionData\AdmissionImportResultID.xml';
  if (FileExists(FileName)) then
  begin
    ImportIDxml.LoadFromFile(FileName);
    ImportIDxml.Active := true;
    if (ImportIDxml.ChildNodes.First.NodeName = 'ImportPackageInfo') then
    begin
      PackageID := ImportIDxml.ChildNodes.FindNode('ImportPackageInfo').ChildNodes.FindNode('PackageID').NodeValue;
      with reqxml do
      begin
        with AddChild('Root') do
        begin
          with AddChild('AuthData') do
          begin
            AddChild('Login');

            ChildValues['Login'] := 'at@vsma.ac.ru';
            AddChild('Pass');

            ChildValues['Pass'] := 'BRalQhv';
          end;
          with AddChild('GetResultImportApplication') do
          begin
            with AddChild('PackageID') do
            begin
              ChildValues['PackageID'] := PackageID;
            end;
          end;
        end;
      end;
      for i := 0 to reqxml.XML.Count - 1 do
        req.WriteString(reqxml.XML.Strings[i]);
      httpreqresp1.URL := 'http://' + ComboBox3.Text + '/import/importservice.svc/import/result';
      context := httpreqresp1.Send(req);
      httpreqresp1.Receive(context, resp);
      respxml.Active := true;
      respxml.LoadFromStream(resp, xetUTF_8);
      for k := 0 to respxml.ChildNodes.Count - 1 do
      begin
        WriteLn(ImportResultFile, respxml.xml.strings[k]);
      end;
      respxml.SaveToFile('AdmissionData\AdmissionImportResult.xml'); //результат импорта
    end;
  end;
  CloseFile(ImportResultFile);
end;

end.

