unit PackageDataXML;

interface
uses XMLDoc, xmldom, XMLIntf, oxmldom, msxmldom, SysUtils, Messages, Dialogs, Windows, DB, IBQuery;

procedure CreatePatternPackageData(PackageData: IXMLDocument; var nom_af_from: integer; var nom_af_to: integer); //Создать шаблон пакета с импортируемыми данными
procedure CreateDeletePackage(nom_af_from: integer; nom_af_to: integer); //Создать шаблон с динными для удалени
procedure CreateOrdersOfAdmissionPackage();
procedure PutAdmInfo(node: IXMLNode);
procedure PutApplications(node: IXMLNode; nom_af_from: integer; nom_af_to: integer);
procedure PutCompGroupItem(node: IXMLNode);
procedure post(const s: string);
procedure PostToQuery(const s: string; Query: TIBQuery);
const
  ns = 5;
var
  n_sp: array[1..ns] of integer = (1, 2, 3, 7, 8);

implementation
uses unit1;

procedure CreateOrdersOfAdmissionPackage();
var
  PackageData: TXMLDocument;
  OrderQuery: TIBQuery;
  kat, CompetitiveGroupUID, nom_af: Integer;
  str_date: string;

begin
  PackageData := TXMLDocument.Create(nil);
  OrderQuery := TIBQuery.Create(nil);
  OrderQuery.Database := Form1.IBDatabase1;
  //PackageDataXML.PostToQuery('se', OrderQuery);
  PackageData.Active := true;
  PackageData.Version := '1.0';
  PackageData.Encoding := 'utf-8';
  PostToQuery('SELECT af.* FROM ABIT_FAK af LEFT JOIN ABIT a on a.NOM_AB=af.NOM_AB WHERE ' +
    'af.N_FAK in (1,2,3,7,8) AND af.STATUS_Z not in (3,6) AND a.ZABR not in (1,2) AND a.DOK_IN_PK=''1'' AND af.ZACHISLEN>0 AND af.nom_af < 15 ORDER BY af.NOM_AF', OrderQuery);
  OrderQuery.First;
  with PackageData do
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
      with AddChild('PackageData') do
      begin
        with AddChild('OrdersOfAdmission') do
        begin
          while not OrderQuery.Eof do
          begin
            with AddChild('OrderOfAdmission') do
            begin
              with AddChild('Application') do
              begin
                AddChild('ApplicationNumber');
                nom_af := OrderQuery.FieldByName('NOM_AF').AsInteger;
                ChildValues['ApplicationNumber'] := '20142014' + IntToStr(nom_af + 1);
                Form1.Caption := IntToStr(nom_af);
                AddChild('RegistrationDate');
                str_date := OrderQuery.FieldByName('DAT_PZ').AsString;
                ChildValues['RegistrationDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2) + 'T00:00:00';
              end;
              post('select af.nom_af, f.directionid from abit_fak af left join fakult f on af.n_fak=f.n_fak where nom_af=' + OrderQuery.FieldByName('NOM_AF').AsString);
              AddChild('DirectionID');
              ChildValues['DirectionID'] := Form1.IBQuery1.FieldByName('DirectionID').AsInteger;
              AddChild('FinanceSourceID');
              post('SELECT af.KATEG from ABIT_FAK af left join KATEG_PR kpr on af.KATEG=kpr.KATEG where NOM_AF=' +
                OrderQuery.FieldByName('NOM_AF').AsString);
              kat := Form1.IBQuery1.Fields.Fields[0].AsInteger; //Категория приёма абитуриента
              post('SELECT k.NOM_TIPPOS, tip.FSID from KATEG_PR k left join SP_TIPPOS  tip on k.nom_tippos=tip.nom_tippos  where k.KATEG=' +
                IntToStr(kat));
              ChildValues['FinanceSourceID'] := Form1.IBQuery1.FieldByName('FSID').AsInteger;
              AddChild('EducationFormID');
              post('SELECT N_FAK from KATEG_PR where KATEG=' + IntToStr(kat));
              if ((Form1.IBQuery1.FieldByName('N_FAK').AsInteger = 19) or (Form1.IBQuery1.FieldByName('N_FAK').AsInteger = 5)) then
                ChildValues['EducationFormID'] := 10
              else
                ChildValues['EducationFormID'] := 11;
              AddChild('EducationLevelID');
              post('SELECT f.VUZ, f.N_FAK from ABIT_FAK af left join FAKULT f on af.N_FAK=f.N_FAK where af.NOM_AF=' + OrderQuery.FieldByName('NOM_AF').AsString);
              if (Form1.IBQuery1.FieldByName('VUZ').AsInteger = 1) then
              begin
                if (Form1.IBQuery1.FieldByName('N_FAK').AsInteger = 5) then
                  ChildValues['EducationLevelID'] := 2
                else
                  ChildValues['EducationLevelID'] := 5;
              end
              else
                ChildValues['EducationLevelID'] := 17;
              //              post('select af.nom_af, af.nom_spis from ABIT_FAK af where af.nom_spis in (1,2) and af.zachislen in (4,5) AND  af.zach_cel=0 AND af.priz_spis=1 AND af.NOM_AF=' +
              //                OrderQuery.FieldByName('NOM_AF').AsString);
              post('select af.nom_af, af.nom_spis from ABIT_FAK af where af.nom_spis in (1,2) AND af.NOM_AF=' +
                OrderQuery.FieldByName('NOM_AF').AsString);
              Form1.IBQuery1.Last;
              if (Form1.IBQuery1.RecordCount > 0) then
              begin
                AddChild('Stage');
                ChildValues['Stage'] := Form1.IBQuery1.FieldByName('NOM_SPIS').AsInteger;
              end;
              {post('select af.* from abit_fak af  left join FAKULT f on af.N_FAK=f.N_FAK where f.VUZ=1 AND ' +
                '(af.zachislen=3 and af.zach_cel=0 and af.priz_spis in (1,2)) AND af.NOM_AF=' +
              OrderQuery.FieldByName('NOM_AF').AsString);}
              post('select af.* from abit_fak af  left join FAKULT f on af.N_FAK=f.N_FAK where f.VUZ=1 AND ' +
                '(af.zachislen=3 and af.priz_spis in (1,2,3,4)) AND af.NOM_AF=' + IntToStr(nom_af));
              Form1.IBQuery1.Last;
              AddChild('IsBeneficiary');
              if (Form1.IBQuery1.RecordCount > 0) then
                ChildValues['IsBeneficiary'] := 1
              else
                ChildValues['IsBeneficiary'] := 0;
              ////is foreigner
//              AddChild('IsForeigner');
//              ChildValues['IsForeigner'] := 0;
//              //Competative groups
//              AddChild('CompetitiveGroupUID'); //в какие конкурсные группы было подано заявление
//              // begin
// //                AddChild();
//              post('SELECT N_FAK from ABIT_FAK where NOM_AF=' + IntToStr(nom_af));
//              case Form1.IBQuery1.FieldByName('N_FAK').AsInteger of
//                1: //лечебный
//                  begin
//                    ChildValues['CompetitiveGroupUID'] := 141;
//                    CompetitiveGroupUID := 141;
//                  end;
//                2: //педиатрический
//                  begin
//                    ChildValues['CompetitiveGroupUID'] := 149;
//                    CompetitiveGroupUID := 149;
//                  end;
//                3: //стоматологический
//                  begin
//                    ChildValues['CompetitiveGroupUID'] := 1415;
//                    CompetitiveGroupUID := 1415;
//                  end;
//                7: //фармацевтичесий
//                  begin
//                    ChildValues['CompetitiveGroupUID'] := 1419;
//                    CompetitiveGroupUID := 1419;
//                  end;
//                8: //медико-профилактический
//                  begin
//                    ChildValues['CompetitiveGroupUID'] := 1423;
//                    CompetitiveGroupUID := 1423;
//                  end;
//              else
//                begin
//                  {ChildValues['CompetitiveGroupUID'] := 1;
//                  CompetitiveGroupUID := 1;}
//                end;
//              end; //end of case
//              //end; //end of CompetitiveGroupUID

            end;
            OrderQuery.Next;
          end; //проход по запросу
        end;
      end;
    end;
  end;
  PackageData.SaveToFile('AdmissionData\AdmissionData.xml');
end;

procedure CreatePatternPackageData(PackageData: IXMLDocument; var nom_af_from: integer; var nom_af_to: integer);
begin
  //PackageData.XML.Create();
  //PackageData.Active:=true;
  PackageData.Version := '1.0';
  PackageData.Encoding := 'utf-8';
  //PackageData.XML.Append('<?xml version="1.0" encoding="utf-8"?>');
  with PackageData do
  begin
    with AddChild('Root') do
    begin
      with AddChild('PackageData') do
      begin
        //fix it in future
          {with AddChild('AdmissionInfo') do //сведения о приёмной кампании
          begin
            //PutAdmInfo(AddChild('AdmissionVolume'));                            //Объём приема (контрольные цифры)
            //PutCompGroupItem(AddChild('CompetitiveGroupItems'));
          end;}
        PutApplications(AddChild('Applications'), nom_af_from, nom_af_to);
        {
        with AddChild('OrdersOfAdmission') do //Списки заявлений абитуриентов, включённых в приказ
        //необходимо заполнить информацией из базы
        begin
          with AddChild('OrderOfAdmission') do
          begin
            with AddChild('Application') do
            begin
              AddChild('ApplicationNumber');
              ChildValues['ApplicationNumber']:=1;
              AddChild('RegistrationDate');
              ChildValues['RegistrationDate']:='2012-02-20T09:00:00';
            end;
            AddChild('DirectionID');
            ChildValues['DirectionID']:=2713;
            AddChild('EducationFormID');
            ChildValues['EducationFormID']:=11;
            AddChild('FinanceSourceID');
            ChildValues['FinanceSourceID']:=14;
            AddChild('EducationLevelID');
            ChildValues['EducationLevelID']:=5;//ID уровня образования (справочник 2)
          end;
        end;
        }
        {with AddChild('OrdersOfAdmission') do //Списки заявлений абитуриентов, включённых в приказ
        begin
          with AddChild('OrderOfAdmissionByType') do
          begin
            AddChild('OrderTypeID');
            with AddChild('Orders') do
            begin
              with AddChild('OrderOfAdmission') do
              begin
                with AddChild('Application') do
                begin
                  AddChild('ApplicationNumber');
                  AddChild('RegistrationDate');
                end;
                AddChild('DirectionID');
                AddChild('EducationFormID');
                AddChild('FinanceSourceID');
              end;
            end;
          end;
        end;}
      end;
      with AddChild('AuthData') do
      begin
        AddChild('Login');

        ChildValues['Login'] := 'at@vsma.ac.ru';
        AddChild('Pass');

        ChildValues['Pass'] := 'BRalQhv';
      end;

    end;
  end;
  PackageData.SaveToFile('PackageData\PackageData' + IntToStr(nom_af_from) + '.xml');
end;
//--------------------------------------------------------------------------

procedure CreateDeletePackage(nom_af_from: integer; nom_af_to: integer);
var
  DelData: TXMLDocument;
  DeleteQuery: TIBQuery;
  str_date: string;
begin
  DelData := TXMLDocument.Create(nil);
  DelData.Active := true;
  DeleteQuery := TIBQuery.Create(nil);
  DeleteQuery.Database := Form1.IBDatabase1;
  DeleteQuery.Close;
  DeleteQuery.Sql.Clear;
  DeleteQuery.Sql.Append('select a.NOM_AF, a.DAT_PZ from ABIT_FAK a left join KATEG_PR k on a.KATEG=k.KATEG left join ABIT ab on ab.NOM_AB=a.NOM_AB where a.NOM_AF>=' + IntToStr(nom_af_from) + ' and a.NOM_AF<=' + IntToStr(nom_af_to) + ' order by a.NOM_AF');
  DeleteQuery.Open;
  DeleteQuery.First;
  DelData.Version := '1.0';
  DelData.Encoding := 'utf-8';
  Form1.ProgressBar1.Max := nom_af_to - nom_af_from;
  Form1.ProgressBar1.Position := 0;
  with DelData do
  begin
    with AddChild('Root') do
    begin
      with AddChild('DataForDelete') do
      begin
        with AddChild('Applications') do
        begin
          while (not DeleteQuery.Eof) do
          begin
            with AddChild('Application') do
            begin
              ChildValues['ApplicationNumber'] := DeleteQuery.FieldByName('NOM_AF').AsInteger;
              str_date := DeleteQuery.FieldByName('DAT_PZ').AsString;
              ChildValues['RegistrationDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2) + 'T00:00:00';
              DeleteQuery.Next;
              Form1.ProgressBar1.Position := DeleteQuery.FieldByName('NOM_AF').AsInteger;
            end;
          end;
        end;
      end;
      with AddChild('AuthData') do
      begin
        AddChild('Login');
        ChildValues['Login'] := 'at@vsma.ac.ru';
        AddChild('Pass');
        ChildValues['Pass'] := 'BRalQhv';
      end;
    end;
  end;
  DelData.SaveToFile('DeleteData\DeleteData' + IntToStr(nom_af_from) + '.xml');
end;
//--------------------------------------------------------------------------

procedure PutAdmInfo(node: IXMLNode);
var
  i: integer;
  //s, s1: string;
begin
  //n_sp:=(1,2,3,7,8,9,10,11,19);
  for i := 1 to ns do
  begin
    with node do
    begin
      with AddChild('Item') do //Объём приема по направлениям подготовки (несколько элементов)
      begin
        AddChild('UID'); //идентификатор
        ChildValues['UID'] := i;

        AddChild('EducationLevelID'); //ИД образовательной программы
        ChildValues['EducationLevelID'] := 5;

        AddChild('DirectionID');
        post('SELECT DIRECTIONID from FAKULT where N_FAK=' + IntToStr(n_sp[i]));
        ChildValues['DirectionID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
        //from dictionary
        AddChild('NumberBudgetO'); //бюджетные места очной формы

        post('Select sum(Priem_kol) from Kateg_Pr where N_FAk=' + IntToStr(n_sp[i]) + ' And (Nom_TipPos=1)');
        ChildValues['NumberBudgetO'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;

        AddChild('NumberBudgetC'); //бюджетные места целевого приёма

        post('Select sum(Priem_kol) from Kateg_Pr where N_FAk=' + IntToStr(n_sp[i]) + ' And (Nom_TipPos=2)');
        ChildValues['NumberBudgetC'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;

        AddChild('NumberBudgetOZ'); //бюджетные места очно-заочной формы

        AddChild('NumberBudgetZ'); //бюджетные места заочной формы

        AddChild('NumberPaidO'); //места с оплатой обучения очной формы

        post('Select sum(Priem_kol) from Kateg_Pr where N_FAk=' + IntToStr(n_sp[i]) + ' And (Nom_TipPos=3 or Nom_TipPos=4)');
        ChildValues['NumberPaidO'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;

        AddChild('NumberPaidOZ'); //места с оплатой обучения очно-заочной формы

        AddChild('NumberPaidZ'); //места с оплатой заочной формы
        if n_sp[i] = 7 then
        begin
          post('Select sum(Priem_kol) from Kateg_Pr where N_FAk=19 And Nom_TipPos=3');
          ChildValues['NumberPaidZ'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
        end;

      end;
    end;

  end;
end;
//--------------------------------------------------------------

procedure PutCompGroupItem(node: IXMLNode);
var
  i, {j,} k, b, count, kat, npos {,nfak}: integer;
  s {,s1}: string;
begin
  //--------------------------
  {Form1.IBTable1.Active:=false;
  Form1.IBTable1.TableName:='ABIT_FAK';
  Form1.IBTable1.Active:=true;
  count:=7798;
  for i:=1 to count do
  Form1.IBTable1.Next;}
  //---------------------------

  //Form1.IbTable1.Active := false;
  //Form1.IBTable1.TableName := 'KATEG_PR';
  //Form1.IBTable1.Active := true;
  post('SELECT count(KATEG) FROM KATEG_PR');
  count := Form1.IBQuery1.Fields.Fields[0].AsInteger;
  with node do
  begin
    for i := 1 to count do
      with AddChild('CompetitiveGroup') do //конкурсная группа
      begin
        kat := Form1.IBTable1.Fields.Fields[0].AsInteger;
        AddChild('UID'); //идентификатор
        ChildValues['UID'] := i;

        AddChild('EducationLevelID'); //ИД образовательной программы
        ChildValues['EducationLevelID'] := 5;

        AddChild('Course'); //курс
        ChildValues['Course'] := 1;

        AddChild('Name'); //Наименование конкурсной группы

        npos := Form1.IBTable1.Fields.Fields[2].AsInteger;
        //post('SELECT SPEC from FAKULT where N_FAK=' + IntToStr(nfak));
        s := Form1.IBQuery1.Fields[0].AsString;
        post('SELECT NAME from SP_TIPPOS where NOM_TIPPOS=' + IntToStr(npos));
        s := s + '. ' + Form1.IBQuery1.Fields[0].AsString;
        if npos <> 1 then
        begin
          post('SELECT NAPRAVIL from KATEG_PR where KATEG=' + IntToStr(kat));
          s := s + '. ' + Form1.IBQuery1.Fields[0].AsString;
        end;
        ChildValues['Name'] := s;

        with AddChild('Items') do //перечень направлений подготовки
        begin
          with AddChild('CompetitiveGroupItem') do //направления поготовки конкурсной группы
          begin
            AddChild('UID');
            ChildValues['UID'] := i;

            //не работает
            AddChild('DirectionID'); //Ид направления подготовки
            post('SELECT DIRECTIONID from FAKULT where N_FAK=' + IntToStr(n_sp[i]));
            ChildValues['DirectionID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;

            AddChild('NumberBudgetO'); //бюджетные места очной формы
            if (Form1.IBTable1.Fields.Fields[2].AsInteger = 1) or (Form1.IBTable1.Fields.Fields[2].AsInteger = 2) then
              ChildValues['NumberBudgetO'] := Form1.IBTable1.Fields.Fields[4].AsInteger;
            AddChild('NumberBudgetOZ'); //бюджетные места очно-заочной формы
            AddChild('NumberBudgetZ'); //бюджетные места заочной формы
            AddChild('NumberPaidO'); //места с оплатой обучения очной формы
            //if ((Form1.IBTable1.Fields.Fields[2].AsInteger = 3) or (Form1.IBTable1.Fields.Fields[2].AsInteger = 4)) and (nfak <> 19) then
              //ChildValues['NumberPaidO'] := Form1.IBTable1.Fields.Fields[4].AsInteger;
            AddChild('NumberPaidOZ'); //места с оплатой обучения очно-заочной формы
            AddChild('NumberPaidZ'); //места с оплатой обучения заочной формы
            //if nfak = 19 then
              //ChildValues['NumberPaidZ'] := Form1.IBTable1.Fields.Fields[4].AsInteger;
          end;
        end;
        if (npos = 2) then
          with AddChild('TargetOrganizations') do //сведения о целевом наборе
          begin
            with AddChild('TargetOrganization') do //сведения о целевом наборе от организации
            begin
              AddChild('UID');
              ChildValues['UID'] := Form1.IBTable1.Fields.Fields[3].AsInteger;
              AddChild('TargetOrganizationName'); //наименование организации с которой заключён договор
              post('SELECT NAPRAVIL from KATEG_PR where KATEG=' + IntToStr(kat));
              ChildValues['TargetOrgnizationName'] := Form1.IBQuery1.Fields.Fields[0].AsString;
              with AddChild('Items') do //напрваления подготовки целевого приёма
              begin
                with AddChild('CompetitiveGroupTargetItem') do //места для целевого приёма
                begin
                  AddChild('UID');
                  ChildValues['UID'] := Form1.IBTable1.Fields.Fields[3].AsInteger;
                  AddChild('NumberBudgetC'); //количество мест целевого приёма
                  ChildValues['NumberBudgetC'] := Form1.IBTable1.Fields.Fields[4].AsInteger;
                  AddChild('DirectionID'); //ИД направления подготовки
                  post('SELECT DIRECTIONID from FAKULT where N_FAK=' + IntToStr(n_sp[i]));
                  ChildValues['DirectionID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
                end;
              end;
            end;
          end;
        {with AddChild('CommonBenefit') do //условия предоставления общей льготы
        begin
          with AddChild('CommonBenefitItem') do //условие предоставления общей льготы
          begin
            AddChild('UID'); //Идентификатор в ИС ОУ
            with AddChild('OlympicDiplomTypes') do //Типы дипломов
            begin
              AddChild('OlympicDiplomTypeID');
            end;
            AddChild('BenefitKindID'); //Вид льготы
            AddChild('IsForAllOlympics'); //флаг действия льготы для всех олимпиад
            with AddChild('Olypmics') do //Перечень олимпиад, для которых действует льгота
            begin //ИД Олимпиады
              AddChild('OlympicID');
            end;
          end;
        end;}
        //----не готово ----------------
        with AddChild('EntranceTestItems') do //вступительные испытания конкурсной группы
        begin
          b := 10;
          for k := 1 to 6 do
          begin

            with AddChild('EntranceTestItem') do //вступительное испытание
            begin
              AddChild('UID'); //ИД в ИС ОУ
              ChildValues['UID'] := k;
              AddChild('EntranceTestTypeID'); //вид вступительного испытания
              ChildValues['EntranceTestTypeID'] := 1;
              AddChild('Form'); //форма вступительного испытания
              if k mod 2 = 0 then
                ChildValues['Form'] := 'Письменно'
              else
                ChildValues['Form'] := 'ЕГЭ';
              AddChild('MinScore'); //минимальное количество баллов
              if k mod 2 <> 0 then
              begin
                post('SELECT Z_NEUD from SP_EKZAM where EKZ_NOM=' + IntToStr(b));
                ChildValues['MinScore'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
              end;
              with AddChild('EntranceTestSubject') do //дисфиплина вступительног испытания
              begin
                AddChild('SubjectID'); //ИД дисциплины
                AddChild('SubjectName'); //наименование дисциплины
                post('SELECT NAME from SP_EKZAM where EKZ_NOM=' + IntToStr(b));
                ChildValues['SubjectName'] := Form1.IBQuery1.Fields.Fields[0].AsString;
              end;
              with AddChild('EntranceTestBenefits') do
              begin
                with AddChild('EntranceTestBenefit') do
                begin
                  AddChild('UID');
                  with AddChild('OlympicDiplomTypes') do
                  begin
                    AddChild('OlympicDiplomTypeId');
                  end;
                  AddChild('BenefitKindID');
                  AddChild('IsForAllOlympics');
                  with AddChild('Olympics') do
                  begin
                    AddChild('OlympicID');
                  end;
                end;
              end;
              if k mod 2 = 0 then
                inc(b);
            end;
          end;
        end;
        //----не готово ----------------
        Form1.IBTable1.Next;
      end;

  end;
end;
//--------------------------------------------------------------------------

procedure PutApplications(node: IXMLNode; nom_af_from: integer; nom_af_to: integer);
var
  nom_app, {c_app,} {i,} nom_ab, {nom_r, nom_p,} kat {,nom_lan,} {n_fak, kateg} {категория приёма}: integer;
  //f: TextFile;
  {np, rai, punkt,}str_date, OriginalReceivedDate, EduDocumentName: string;
  N_SEGE, {record_count,} OriginalReceived, CompetitiveGroupID, ResultDocumentType: integer;
  IBQuerySvidEGE, IBQueryEntranceTestResults, IBQueryBenefit: TIBQuery;
begin
  OriginalReceived := 0;
  PostToQuery('SELECT af.* FROM ABIT_FAK af LEFT JOIN ABIT a on a.NOM_AB=af.NOM_AB WHERE af.NOM_AF>=' +
    IntToStr(nom_af_from) + ' AND af.NOM_AF<' + IntToStr(nom_af_to) +
    ' AND af.STATUS_Z not in (3,6) AND a.ZABR not in (1,2) AND a.DOK_IN_PK=''1'' ORDER BY af.NOM_AF', Form1.IBQueryMain);
  //PostToQuery('SELECT * FROM ABIT WHERE N_FAK=1 AND KATEG=1 AND NOM_AB>=' + IntToStr(nom_ab_from) + ' AND NOM_AB<' + IntToStr(nom_ab_to) + ' ORDER BY NOM_AB', Form1.IBQueryMain);
  with node do
  begin
    Form1.IBQueryMain.First;
    while not Form1.IBQueryMain.Eof do
    begin
      Form1.Caption := IntToStr(StrToInt(Form1.Caption) + 1);
      //n_fak := Form1.IBQueryMain.FieldByName('N_FAK').AsInteger;
      //kateg := Form1.IBQueryMain.FieldByName('KATEG').AsInteger;
      post('SELECT N_SEGE from BALL_EGE where NOM_AB=' + Form1.IBQueryMain.FieldByName('NOM_AB').AsString);
      //N_SEGE := Form1.IBQuery1.FieldByName('N_SEGE').AsInteger;
      //if {(n_fak = 1) and (kateg = 1) and}(N_SEGE <> 0) then //fix it
      //begin
      with AddChild('Application') do //заявления абитуриентов
      begin
        nom_app := Form1.IBQueryMain.FieldByName('NOM_AF').AsInteger;
        nom_ab := Form1.IBQueryMain.FieldByName('NOM_AB').AsInteger;
        //----------------OriginalRecivedDate---------------------------------//дата предоставления оригиналов документов
        post('select KOPIA, DAT_PZ, USER_KOPIA_DAT_NA_0 from ABIT where NOM_AB=' + IntToStr(nom_ab));
        if (Form1.IBQuery1.FieldByName('KOPIA').AsInteger = 0) then
        begin
          if (Form1.IBQuery1.FieldByName('USER_KOPIA_DAT_NA_0').AsString <> '') then
          begin
            str_date := Form1.IBQuery1.FieldByName('USER_KOPIA_DAT_NA_0').AsString;
          end
        end
        else
        begin
          str_date := Form1.IBQuery1.FieldByName('DAT_PZ').AsString;
        end;
        OriginalReceivedDate := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
        //--------------------------------------------------------------------//
        AddChild('UID');
        ChildValues['UID'] := '20142014' + IntToStr(nom_app);
        AddChild('ApplicationNumber');
        ChildValues['ApplicationNumber'] := '20142014' + IntToStr(nom_app + 1);
        with AddChild('Entrant') do
        begin
          //from ABIT
          AddChild('UID');
          ChildValues['UID'] := nom_ab; //Form1.IBTable1.Fields.Fields[1].AsInteger;
          AddChild('FirstName');
          post('Select NAM from ABIT where NOM_AB=' + IntToStr(nom_ab));
          ChildValues['FirstName'] := Form1.IBQuery1.Fields.Fields[0].AsString;
          AddChild('MiddleName');
          post('Select OTCH from ABIT where NOM_AB=' + IntToStr(nom_ab));
          ChildValues['MiddleName'] := Form1.IBQuery1.Fields.Fields[0].AsString;
          AddChild('LastName');
          post('Select FAM from ABIT where NOM_AB=' + IntToStr(nom_ab));
          ChildValues['LastName'] := Form1.IBQuery1.Fields.Fields[0].AsString;
          AddChild('GenderID'); //dictionary
          post('SELECT POL from ABIT where NOM_AB=' + IntToStr(nom_ab));
          {assignfile(f,'1.txt');
          ReWrite(f);
          write(f,Form1.IBQuery1.Fields.Fields[0].AsString);
          closefile(f);}
          if (Form1.IBQuery1.Fields.Fields[0].AsString = string('М')) then
            ChildValues['GenderID'] := 1 //men
          else
            ChildValues['GenderID'] := 2; //women
          //fix it!
          //AddChild('Snils');
          {with AddChild('RegistrationAddress') do
          begin
            AddChild('CountryID');
            post('SELECT NOM_GOS from ABIT where NOM_AB=' + IntToStr(nom_ab));
            nom_gos := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            post('SELECT COUNTRYID from GOSUDAR where NOM_GOS=' + IntToStr(nom_gos));
            ChildValues['CountryID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            AddChild('RegionID');
            post('SELECT NOM_OBL from ABIT where NOM_AB=' + IntToStr(nom_ab));
            nom_reg := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            post('SELECT RegionID from OBLAST where NOM_OBL=' + IntToStr(nom_reg));
            ChildValues['RegoinID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            AddChild('CityName');
            post('SELECT NOM_RAI from ABIT where NOM_AB=' + intToStr(nom_ab));
            nom_r := Form1.IBQuery1.Fields.Fields[0].asInteger;
            post('SELECT NOM_PUN from ABIT where NOM_AB=' + IntToStr(nom_ab));
            nom_p := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            post('SELECT NAME From RAION where NOM_RAI=' + IntToStr(nom_r));
            rai := Form1.IBQuery1.Fields.Fields[0].AsString;
            post('SELECT NAME from NAS_PUNKT where NOM_PUN=' + inttostr(nom_p));
            punkt := Form1.IBQuery1.Fields.Fields[0].AsString;
            if rai = '---' then
              np := punkt
            else
              np := rai + ', ' + punkt;
            ChildValues['CityName'] := np;
            AddChild('PostalCode');
            post('SELECT INDEKS From ABIT where NOM_AB=' + IntToStr(nom_ab));
            //                       ChildValues['PostalCode']:=StrToInt(Form1.IBQuery1.Fields.Fields[0].AsString);
            AddChild('Street');
            post('SELECT ULIC from ABIT where NOM_AB=' + IntToStr(nom_ab));
            ChildValues['Street'] := Form1.IBQuery1.Fields.Fields[0].AsString;
            AddChild('Building');
            post('SELECT DOM from ABIT where NOM_AB=' + IntToStr(nom_ab));
            ChildValues['Building'] := Form1.IBQuery1.Fields.Fields[0].AsString;
            AddChild('BuildingPart');
            post('SELECT KORP from ABIT where NOM_AB=' + IntToStr(nom_ab));
            ChildValues['BuildingPart'] := Form1.IBQuery1.Fields.Fields[0].AsString;
            AddChild('Room');
            post('SELECT KVART from ABIT where NOM_AB=' + IntToStr(nom_ab));
            ChildValues['Room'] := Form1.IBQuery1.Fields.Fields[0].AsString;
            AddChild('Phone');
          end;
          with AddChild('FactAddress') do
          begin
            AddChild('CountryID');
            AddChild('RegionID');
            AddChild('CityName');
            AddChild('PostalCode');
            AddChild('Street');
            AddChild('Building');
            AddChild('BuildingPart');
            AddChild('Room');
            AddChild('Phone');
          end;
          AddChild('MobilePhone');
          AddChild('Email');
          with AddChild('ForeignLanguages') do
          begin
            AddChild('LanguageID');
            post('SELECT NOM_IJZ from ABIT where NOM_AB=' + IntToStr(nom_ab));
            nom_lan := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            post('SELECT LID from SP_IJZ where NOM_IJZ=' + IntToStr(nom_lan));
            ChildValues['LanguageID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
          end;
          with AddChild('FatherData') do
          begin
            AddChild('FirstName');
            AddChild('MiddleName');
            AddChild('LastName');
            AddChild('WorkPlace');
            AddChild('Position');
            AddChild('WorkPhone');
          end;
          with AddChild('MotherData') do
          begin
            AddChild('FirstName');
            AddChild('MiddleName');
            AddChild('LastName');
            AddChild('WorkPlace');
            AddChild('Position');
            AddChild('WorkPhone');
          end;}
        end; //end of entrant
        AddChild('RegistrationDate');
        post('SELECT DAT_PZ from ABIT_FAK where NOM_AF=' + inttostr(nom_app));
        str_date := Form1.IBQuery1.fieldbyname('DAT_PZ').AsString;
        ChildValues['RegistrationDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2) + 'T00:00:00'; //AsDateTime;
        post('SELECT * FROM ABIT_FAK WHERE NOM_AF=' + IntToStr(nom_app));
        if (Form1.IBQuery1.FieldByName('STATUS_Z').AsInteger = 6) then
        begin
          AddChild('LastDenyDate');
          post('SELECT ZABR from ABIT where NOM_AB=' + IntToStr(nom_ab));
          str_date := Form1.IBQuery1.FieldByName('DAT_ZABR').AsString;
          ChildValues['LastDenyDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2) + 'T00:00:00'; //.AsDateTime
        end;
        AddChild('NeedHostel');
        post('SELECT POTREB_OB from ABIT Where NOM_AB=' + IntToStr(nom_ab));
        ChildValues['NeedHostel'] := Form1.IBQuery1.Fields.Fields[0].AsString;
        AddChild('StatusID');
        post('SELECT * FROM ABIT_FAK WHERE NOM_AF=' + IntToStr(nom_app));
        ChildValues['StatusID'] := Form1.IBQuery1.FieldByName('STATUS_Z').AsString;

        with AddChild('SelectedCompetitiveGroups') do //в какие конкурсные группы было подано заявление
        begin
          AddChild('CompetitiveGroupID');
          //post('SELECT KATEG from ABIT_FAK where NOM_AF=' + IntToStr(nom_app));
          //ChildValues['CompetitiveGroupID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
          {case Form1.IBQuery1.FieldByName('N_FAK').AsInteger of
            9:
              begin
                ChildValues['CompetitiveGroupID'] := 2;
                CompetitiveGroupID := 2;
              end;
            10, 11:
              begin
                ChildValues['CompetitiveGroupID'] := 3;
                CompetitiveGroupID := 3
              end;
          else
            begin
              ChildValues['CompetitiveGroupID'] := 1;
              CompetitiveGroupID := 1;
            end;
          end;}//obsolete
          case Form1.IBQuery1.FieldByName('N_FAK').AsInteger of
            1: //лечебный
              begin
                ChildValues['CompetitiveGroupID'] := 141;
                CompetitiveGroupID := 141;
              end;
            2: //педиатрический
              begin
                ChildValues['CompetitiveGroupID'] := 149;
                CompetitiveGroupID := 149;
              end;
            3: //стоматологический
              begin
                ChildValues['CompetitiveGroupID'] := 1415;
                CompetitiveGroupID := 1415;
              end;
            7: //фармацевтичесий
              begin
                ChildValues['CompetitiveGroupID'] := 1419;
                CompetitiveGroupID := 1419;
              end;
            8: //медико-профилактический
              begin
                ChildValues['CompetitiveGroupID'] := 1423;
                CompetitiveGroupID := 1423;
              end;
          else
            begin
              {ChildValues['CompetitiveGroupID'] := 1;
              CompetitiveGroupID := 1;}
            end;
          end;
        end;

        with AddChild('SelectedCompetitiveGroupItems') do //в какие конкурсные группы было подано заявление
        begin
          AddChild('CompetitiveGroupItemID');
          //post('SELECT KATEG from ABIT_FAK where NOM_AF=' + IntToStr(nom_app));
          //ChildValues['CompetitiveGroupID'] := Form1.IBQuery1.Fields.Fields[0].AsInteger;
          {post('select a.nom_af as NOM_AF, a.nom_ab as NOM_AB, f.directionid as DIRECTION_ID from abit_fak a left join fakult f on a.n_fak=f.n_fak where NOM_AF=' + IntToStr(nom_app));
          ChildValues['CompetitiveGroupItemID'] := Form1.IBQuery1.FieldByname('DIRECTION_ID').AsString; }
          ChildValues['CompetitiveGroupItemID'] := CompetitiveGroupID;
        end;

        with AddChild('FinSourceAndEduForms') do
        begin
          with AddChild('FinSourceEduForm') do
          begin
            AddChild('FinanceSourceID');
            post('SELECT KATEG from ABIT_FAK where NOM_AF=' + IntToStr(nom_app));
            kat := Form1.IBQuery1.Fields.Fields[0].AsInteger;
            post('SELECT k.NOM_TIPPOS, tip.FSID from KATEG_PR k left join SP_TIPPOS  tip on k.nom_tippos=tip.nom_tippos  where k.KATEG=' + IntToStr(kat));
            {case Form1.IBQuery1.Fields.Fields[0].AsInteger of
              1: ChildValues['FinanceSourceID'] := abs(14);
              2: ChildValues['FinanceSourceID'] := abs(15);
              3: ChildValues['FinanceSourceID'] := abs(16);
              4: ChildValues['FinanceSourceID'] := abs(15);
            end;}
            ChildValues['FinanceSourceID'] := Form1.IBQuery1.FieldByName('FSID').AsInteger;
            AddChild('EducationFormID');
            post('SELECT N_FAK from KATEG_PR where KATEG=' + IntToStr(kat));
            if ((Form1.IBQuery1.FieldByName('N_FAK').AsInteger = 19) or (Form1.IBQuery1.FieldByName('N_FAK').AsInteger = 5)) then
              ChildValues['EducationFormID'] := 10
            else
              ChildValues['EducationFormID'] := 11;
            post('SELECT KATEG,N_FAK,NOM_TIPPOS,NOM_OBL from KATEG_PR where KATEG=' + IntToStr(kat));
            if (Form1.IBQuery1.FieldByName('NOM_TIPPOS').AsInteger = 2) {//если целевое направление} then
            begin
              AddChild('TargetOrganizationUID');
              ChildValues['TargetOrganizationUID'] := Form1.IBQuery1.FieldByName('NOM_OBL').AsInteger;
            end;
          end;
        end;
        //Льготы
        {
        IBQueryBenefit := TIBQuery.Create(nil);
        IBQueryBenefit.Database := Form1.IBDatabase1;
        //Запрос, есть ли у абитуриенты льготы
        PostToQuery('select count(a.nom_ab) from abit a where a.NOM_AB=' +
          IntToStr(nom_ab) +
          ' and (exists(select * from abit_be be where be.nom_ab=a.nom_ab)' +
          ' or (exists(select * from abit_vk vk where vk.nom_ab=a.nom_ab))' +
          ' or (exists(select * from abit_pp pp where pp.nom_ab=a.nom_ab))' +
          ' or (exists(select * from abit_olimp ao where ao.nom_ab=a.nom_ab and ao.nom_olimp IS NOT NULL )))', IBQueryBenefit);
        IBQueryBenefit.Open;
        IBQueryBenefit.First;
        if (IBQueryBenefit.FieldByName('COUNT').AsInteger > 0) then
        begin
          with AddChild('ApplicationCommonBenefit') do
          begin
            AddChild('UID');
            ChildValues['UID'] := nom_ab;
            AddChild('CompetitiveGroupID');
            ChildValues['CompetitiveGroupID'] := CompetitiveGroupID;
            //запрос олимпиады дающие льготы по абитуриенту
            //post('SELECT * from ABIT_OLIMP ao join OLIMP o on ao.NOM_OLIMP=o.NOM_OLIMP where ao.NOM_AB=' + IntToStr(nom_ab));
            //Запрос льготы вне конкурса
            post('SELECT vk.nom, vk.nom_katstud, vk.nom_ab, dl.dok_nom, dl.dok_data  from ABIT_VK vk left join dok_lgota dl on vk.nom_ab=dl.nom_ab '
              + 'where dl.priz_lgota=2 and dl.dok containing ''МС'' and vk.NOM_AB=' + IntToStr(nom_ab)); //МС справка МСЭ
            Form1.IBQuery1.Open;
            Form1.IBQuery1.Last;
            if (Form1.IBQuery1.RecordCount > 0) then
            begin
              AddChild('BenefitKindID');
              ChildValues['BenefitKindID'] := 1;
              AddChild('DocumentTypeID');
              ChildValues['DocumentTypeID'] := 11; //справко об учстановлении инвалидности
              with AddChild('DocumentReason') do
              begin
                with AddChild('MedicalDocuments') do
                begin
                  with AddChild('BenefitDocument') do
                  begin
                    with AddChild('DisabilityDocument') do
                    begin
                      AddChild('OriginalReceived');
                      ChildValues['OriginalReceived'] := 1; //должны принимать только оригиналы
                      AddChild('OriginalReceivedDate');
                      ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
                      AddChild('DocumentSeries');
                      ChildValues['DocumentSeries'] := 'нет'; //'МСЭ-'+Form1.IBQuery1.FieldByName('NOM_AB').AsString;
                      AddChild('DocumentNumber');
                      ChildValues['DocumentNumber'] := Form1.IBQuery1.FieldByName('DOK_NOM').AsString;
                      AddChild('DocumentDate');
                      str_date := Form1.IBQuery1.FieldByName('DOK_DATA').AsString;
                      ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2); //.AsDateTime + 'T00:00:00'
                      AddChild('DisabilityTypeID');
                      ChildValues['DisabilityTypeID'] := 4; //Ребёнок инвалид
                    end;
                  end;
                  with AddChild('AllowEducationDocument') do
                  begin
                    post('SELECT vk.nom, vk.nom_katstud, vk.nom_ab, dl.dok_nom, dl.dok_data  from ABIT_VK vk left join dok_lgota dl on vk.nom_ab=dl.nom_ab '
                      + 'where dl.priz_lgota=2 and dl.dok containing ''реабилитационная'' and vk.NOM_AB=' + IntToStr(nom_ab)); //МС справка МСЭ
                    Form1.IBQuery1.Open;
                    Form1.IBQuery1.First;
                    AddChild('OriginalReceived');
                    ChildValues['OriginalReceived'] := 1; //должны принимать только оригиналы
                    AddChild('OriginalReceivedDate');
                    ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
                    AddChild('DocumentNumber');
                    ChildValues['DocumentNumber'] := Form1.IBQuery1.FieldByName('DOK_NOM').AsString;
                    str_date := Form1.IBQuery1.FieldByName('DOK_DATA').AsString;
                    ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
                    AddChild('DisabilityTypeID');
                  end;
                end;
              end;
            end;
          end;
        end; //Конеец льгот по заявлению
        }
        //fix it!
        {with AddChild('ApplicationCommonBenefit') do
        begin
          AddChild('UID');
          AddChild('DocumentTypeID');
          with AddChild('DocumentReason') do
          begin
            with AddChild('OlympicDocument') do
            begin
              AddChild('UID');
              AddChild('DocumentNumber');
              AddChild('DocumentDate');
              AddChild('DiplomaTypeID');
              AddChild('OlympicID');
            end;
            with AddChild('OlympicTotalDocument') do
            begin
              //ChildType['OlympicTotalDocument']:='TOlympicTotalDocument';
              AddChild('UID');
              AddChild('DocumentSeries');
              AddChild('DocumentNumber');
              AddChild('OlympicPlace');
              AddChild('OlympicDate');
              AddChild('DiplomaTypeID');
              with AddChild('Subjects') do
              begin
                with AddChild('SubjectBriefData') do
                begin
                  AddChild('SubjectID');
                end;
              end;
            end;
            with AddChild('MedicalDocuments') do
            begin
              with AddChild('BenefitDocument') do
              begin
                with AddChild('DisabilityDocument') do
                begin
                  AddChild('UID');
                  AddChild('DocumentSeries');
                  AddChild('DocumentNumber');
                  AddChild('DocumentDate');
                  AddChild('DocumentOrganization');
                  AddChild('DisabilityTypeID');
                end;
                with AddChild('MedicalDocument') do
                begin
                  AddChild('UID');
                  AddChild('DocumentNumber');
                  AddChild('DocumentDate');
                  AddChild('DocumentOrganization');
                end;
              end;
              with AddChild('AllowEducationDocument') do
              begin
                AddChild('UID');
                AddChild('DocumentNumber');
                AddChild('DocumentDate');
                AddChild('DocumentOrganization');
              end;
            end;
            with AddChild('CustomDocument') do
            begin
              AddChild('UID');
              AddChild('DocumentSeries');
              AddChild('DocumentNumber');
              AddChild('DocumentDate');
              AddChild('DocumentOrganization');
              AddChild('AdditionalInfo');
              AddChild('DocumentTypeNameText');
            end;
          end;
          AddChild('BenefitKindID');
        end;}
        //fix it!
        {
        IBQueryEntranceTestResults := TIBQuery.Create(nil);
        IBQueryEntranceTestResults.Database := Form1.IBDatabase1;
        PostToQuery('SELECT b.NOM_B, b.BALL_OLIM, b.PRIZ_OLIM, b.PRIZVED, b.N_SEGE, p.SUBJECTID, p.NOM_PREDM' +
          ' from BALL_EGE b left join SP_PREDMET p on b.NOM_PREDM=p.NOM_PREDM where b.PRIZVED<>2 and b.NOM_AB=' + IntToStr(nom_ab), IBQueryEntranceTestResults);
        with IBQueryEntranceTestResults do
        begin
          close;
          open;
          last;
          if (recordcount > 0) then
            with AddChild('EntranceTestResults') do
            begin
              first;
              while not eof do
              begin
                with AddChild('EntranceTestResult') do
                begin
                  AddChild('UID');
                  ChildValues['UID'] := '2014'+IntToStr(nom_app)+IBQueryEntranceTestResults.FieldByName('NOM_B').AsString;
                  AddChild('ResultValue');
                  ChildValues['ResultValue'] := IBQueryEntranceTestResults.FieldByName('BALL_OLIM').AsInteger;
                  AddChild('ResultSourceTypeID');
                  if (IBQueryEntranceTestResults.FieldByName('PRIZ_OLIM').AsInteger = 0) then
                  begin
                    case IBQueryEntranceTestResults.FieldByName('PRIZVED').AsInteger of
                      1:
                        begin
                          ChildValues['ResultSourceTypeID'] := 1; //Есть ЕГЭ, Свидетельство ЕГЭ
                          ResultDocumentType := 1;
                        end;
                      3:
                        begin
                          ChildValues['ResultSourceTypeID'] := 2; //Будет писать В ВГМА, Вступительное испытание ОУ
                          ResultDocumentType := 2;
                        end;
                    else
                      ResultDocumentType := 0; //не должно выполниться
                    end;
                  end
                  else
                  begin
                    ChildValues['ResultSourceTypeID'] := 3; //Призёр олимпиады
                    ResultDocumentType := 3;
                  end;
                  with AddChild('EntranceTestSubject') do
                  begin
                    AddChild('SubjectID');
                    ChildValues['SubjectID'] := IBQueryEntranceTestResults.FieldByName('SubjectID').AsInteger;
                    //AddChild('SubjectName');
                  end;
                  //with AddChild('EntranceTestTypeID') do
                  //begin
                  ChildValues['EntranceTestTypeID'] := 1; //В академии только один тип
                  //end;
                  //with AddChild('CompetitiveGroupID') do
                  //begin
                  ChildValues['CompetitiveGroupID'] := CompetitiveGroupID;
                  //end;
                  with AddChild('ResultDocument') do
                  begin
                    case (ResultDocumentType) of
                      1: //Если есть ЕГЭ
                        begin
                          AddChild('EgeDocumentID');
                          ChildValues['EgeDocumentID'] := '100000' + IntToStr(IBQueryEntranceTestResults.FieldByName('N_SEGE').AsInteger);
                        end;
                      2: //Если сдавал в ВГМА
                        begin
                          with AddChild('InstitutionDocument') do
                          begin
                            AddChild('DocumentNumber');
                            ChildValues['DocumentNumber'] := nom_ab; //совпадает с номером абитуриента
                            AddChild('DocumentTypeID');
                            ChildValues['DocumentTypeID'] := 2; //Экзаменационный лист
                          end;
                        end;
                      3: //Если Призёр олимпиады
                        begin
                          with AddChild('OlympicDocument') do
                          begin
                            PackageDataXML.post('select ao.N_ABIT_OL, ao.NOM_PREDM, ao.DOk_NOM, ao.OLIMP_KTO as OLIMP_KTO,' +
                              ' ab.DAT_PZ, ao.DOK_DATA, ol.OLIMPICID_B, ol.OLIMPICID_H, ol.OLIMPICID_R,' +
                              '(select max(af.ZACHISLEN) as ZACHISLEN from abit_fak af where af.NOM_AB=ao.NOM_AB)' +
                              ' from ABIT_OLIMP ao left join ABIT ab on ab.NOM_AB=ao.NOM_AB' +
                              ' left join olimp ol on ol.NOM_OLIMP=ao.NOM_OLIMP' +
                              ' where ao.NOM_AB = ' +
                              IntToStr(nom_ab) + ' and ao.NOM_PREDM = ' + IBQueryEntranceTestResults.FieldByName('NOM_PREDM').AsString +
                              ' AND ao.DOK_NOM is not null');
                            AddChild('UID');
                            ChildValues['UID'] := Form1.IBQuery1.FieldByName('N_ABIT_OL').AsInteger;
                            AddChild('OriginalReceived');
                            if (Form1.IBQuery1.FieldByName('ZACHISLEN').AsInteger > 0) then
                            begin
                              ChildValues['OriginalReceived'] := 1;
                              AddChild('OriginalReceivedDate');
                              str_date := Form1.IBQuery1.FieldByName('DAT_PZ').AsString;
                              ChildValues['OriginalReceivedDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
                            end
                            else
                            begin
                              ChildValues['OriginalReceived'] := 0;
                            end;
                            AddChild('DocumentNumber');
                            ChildValues['DocumentNumber'] := Form1.IBQuery1.FieldByName('DOK_NOM').AsInteger;
                            AddChild('DocumentDate');
                            str_date := Form1.IBQuery1.FieldByName('DOK_DATA').AsString;
                            if (str_date <> '') then
                            begin
                              ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
                            end;
                            AddChild('DiplomaTypeID');
                            if (Form1.IBQuery1.FieldByName('OLIMP_KTO').AsString = 'призером') then
                            begin
                              ChildValues['DiplomaTypeID'] := 2;
                            end
                            else
                            begin
                              ChildValues['DiplomaTypeID'] := 1;
                            end;
                            AddChild('OlympicID');
                            case (Form1.IBQuery1.FieldByName('NOM_PREDM').AsInteger) of
                              1:
                                begin
                                  ChildValues['OlympicID'] := Form1.IBQuery1.FieldByName('OLIMPICID_B').AsInteger;
                                end;
                              2:
                                begin
                                  ChildValues['OlympicID'] := Form1.IBQuery1.FieldByName('OLIMPICID_H').AsInteger;
                                end;
                              3:
                                begin
                                  ChildValues['OlympicID'] := Form1.IBQuery1.FieldByName('OLIMPICID_R').AsInteger;
                                end;
                            end; //case OlympicID NOM_PREDM
                          end; //OlympicDocument
                        end; //Если Призёр олимпиады
                    end; //ResultDocument
                  end;
                end; //entrance test result
                next;
              end; //while not eof
            end; //entrance test results
        end; //test results query
        }
        {with AddChild('LastEducation') do
        begin
          AddChild('KindLastEducationID');
          AddChild('OriginalDocumentsReceived');
          post('SELECT KOPIA from ABIT where NOM_AB=' + intToStr(nom_ab));
          if StrToInt(Form1.IBQuery1.Fields.Fields[0].AsString) = 0 then
            ChildValues['OriginalDocumentReceived'] := true
          else
            ChildValues['OriginalDocumentReceived'] := false;
          AddChild('IsSameVPO');
        end;}
        with AddChild('ApplicationDocuments') do
        begin
          IBQuerySVIDEGE := TIBQuery.Create(nil);
          IBQuerySVIDEGE.Database := Form1.IBDatabase1;
          PostToQuery('Select distinct e.N_SEGE, e.NOM_AB, e.EGE_NOM, e.EGE_SERIA, e.EGE_DATA, e.EGE_KEM from SVIDEGE e left join ball_ege b on e.n_sege=b.n_sege where b.N_SEGE IS NOT NULL and e.EGE_NOM IS NOT NULL AND  e.NOM_AB=' + IntToStr(nom_ab), IBQuerySVIDEGE);
          with IBQuerySVIDEGE do
          begin
            close;
            open;
            last;
            if (recordcount > 0) then
              with AddChild('EgeDocuments') do
              begin
                first;
                while not eof do
                begin
                  N_SEGE := IBQuerySVIDEGE.FieldByName('N_SEGE').AsInteger; //ID свидетельства ЕГЭ
                  str_date := '20' + copy(IBQuerySVIDEGE.FieldByName('EGE_NOM').AsString, 14, 2); //Год сдачи ЕГЭ
                  with AddChild('EgeDocument') do
                  begin
                    AddChild('UID');
                    ChildValues['UID'] := 100000 + N_SEGE;
                    AddChild('OriginalReceived');
                    PackageDataXML.post('Select KOPIA from ABIT where NOM_AB=' + IntToStr(nom_ab));
                    OriginalReceived := Form1.IBQuery1.FieldByName('KOPIA').AsInteger;
                    ChildValues['OriginalReceived'] := OriginalReceived;
                    if (OriginalReceived = 1) then
                    begin
                      AddChild('OriginalReceivedDate');
                      ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
                    end;
                    AddChild('DocumentNumber');
                    //                    ChildValues['DocumentNumber'] := Form1.IBQuery1.FieldByName('EGE_NOM').AsString;
                    ChildValues['DocumentNumber'] := IBQuerySVIDEGE.FieldByName('EGE_NOM').AsString; // EGE_NOM.AsString;
                    //                    str_date := IntToStr(N_SEGE); //Form1.IBQuery1.FieldByName('EGE_DATA').AsString;
                    ChildValues['DocumentYear'] := str_date;
                    with AddChild('Subjects') do
                    begin
                      PackageDataXML.post('select b.ball_100 as ball_100, p.subjectid as subjectid from ball_ege b left join sp_predmet p on p.nom_predm=b.nom_predm where ball_100 is not null and b.NOM_AB=' + IntToStr(nom_ab) + '  and b.n_sege=' + IntToStr(N_SEGE));
                      with Form1.IBQuery1 do
                      begin
                        //close;
                        //open;
                        //last;
                        //if ((recordcount > 0) {and (Form1.IBQuery1.FieldByName('ball_100').AsString <> '')}) then
                        //begin
                        first;
                        while not eof do
                        begin
                          with AddChild('SubjectData') do
                          begin
                            AddChild('SubjectID');
                            ChildValues['SubjectID'] := fieldByName('SUBJECTID').AsInteger;
                            AddChild('Value');
                            ChildValues['Value'] := FieldByName('BALL_100').AsInteger;
                          end;
                          next;
                        end;
                        //end;
                        close;
                      end;
                    end;
                  end;
                  next;
                end;
              end; //of ege documents
          end; //of query on svidege
          IBQuerySVIDEGE.Destroy;
          with AddChild('IdentityDocument') do
          begin
            PackageDataXML.post('select * from ABIT where NOM_AB=' + IntToStr(nom_ab));
            AddChild('UID');
            ChildValues['UID'] := '200000' + Form1.IBQuery1.FieldByName('DOK_S').AsString + Form1.IBQuery1.FieldByName('DOK_N').AsString;
            AddChild('OriginalReceived');
            ChildValues['OriginalReceived'] := OriginalReceived;
            if (OriginalReceived = 1) then
            begin
              AddChild('OriginalReceivedDate');
              ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
            end;
            AddChild('DocumentSeries');
            ChildValues['DocumentSeries'] := trim(Form1.IBQuery1.FieldByName('DOK_S').AsString);
            AddChild('DocumentNumber');
            ChildValues['DocumentNumber'] := trim(Form1.IBQuery1.FieldByName('DOK_N').AsString);
            AddChild('DocumentDate');
            str_date := Form1.IBQuery1.FieldByName('DATE_PASP').AsString;
            ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
            AddChild('DocumentOrganization');
            ChildValues['DocumentOrganization'] := Form1.IBQuery1.FieldByName('KEM_DOK').AsString;
            AddChild('IdentityDocumentTypeID');
            case Form1.IBQuery1.FieldByName('TIP_DOK').AsInteger of
              1: ChildValues['IdentityDocumentTypeID'] := 1; //паспорт гражданина РФ
              2: ChildValues['IdentityDocumentTypeID'] := 3; //паспорт гражданина иностранного государства
              3: ChildValues['IdentityDocumentTypeID'] := 9; //паспорт гражданина СССР
              4: ChildValues['IdentityDocumentTypeID'] := 4; //свидетельство о рождении
              5: ChildValues['IdentityDocumentTypeID'] := 10; //временное удостоверение
              6: ChildValues['IdentityDocumentTypeID'] := 11; //вид на жительство
              7: ChildValues['IdentityDocumentTypeID'] := 2; //Российский заграничный паспорт
              8: ChildValues['IdentityDocumentTypeID'] := 9; //другой документ
            end;
            PackageDataXML.post('select * from ABIT a left join gosudar g on a.GRAJD=g.NOM_GOS where a.NOM_AB=' + IntToStr(nom_ab));
            AddChild('NationalityTypeID');
            ChildValues['NationalityTypeID'] := Form1.IBQuery1.FieldByName('COUNTRYID').AsInteger; //1; //fix it
            PackageDataXML.post('select * from ABIT where NOM_AB=' + IntToStr(nom_ab));
            AddChild('BirthDate');
            str_date := Form1.IBQuery1.FieldByName('DAT_R').AsString;
            ChildValues['BirthDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
            //AddChild('BirthPlace');
          end; //of identity documents
          with AddChild('EduDocuments') do
          begin
            with AddChild('EduDocument') do
              //выбор типа документа из базы
            begin
              if (Form1.IBQuery1.FieldByName('ATTESTAT').AsInteger = 1) then
              begin
                EduDocumentName := 'SchoolCertificateDocument';
              end
              else
              begin
                if (Form1.IBQuery1.FieldByName('DIPL_VUZA').AsInteger = 1) then
                begin
                  EduDocumentName := 'HighEduDiplomaDocument';
                end
                else
                begin
                  EduDocumentName := 'MiddleEduDiplomaDocument';
                end
              end; //end if
              with AddChild(EduDocumentName) do
                //with AddChild('SchoolCertificateDocument') do
              begin
                AddChild('UID');
                ChildValues['UID'] := '300000' + IntTostr(nom_ab) + Form1.IBQuery1.FieldByName('ATT_NOM').AsString;
                AddChild('OriginalReceived');
                ChildValues['OriginalReceived'] := OriginalReceived;
                if (OriginalReceived = 1) then
                begin
                  AddChild('OriginalReceivedDate');
                  ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
                end;
                AddChild('DocumentSeries');
                ChildValues['DocumentSeries'] := trim(Form1.IBQuery1.FieldByName('ATT_SERIA').AsString);
                AddChild('DocumentNumber');
                ChildValues['DocumentNumber'] := trim(Form1.IBQuery1.FieldByName('ATT_NOM').AsString);
                AddChild('DocumentDate');
                str_date := Form1.IBQuery1.FieldByName('ATT_DATE').AsString;
                ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
                AddChild('DocumentOrganization');
                ChildValues['DocumentOrganization'] := Form1.IBQuery1.FieldByName('ATT_KEM').AsString;
                AddChild('EndYear');
                ChildValues['EndYear'] := Form1.IBQuery1.FieldByName('GOD_UCHZ').AsInteger;
              end;
            end; //of edu document
          end; //of edu documents
          PackageDataXML.post('select d.N_DOK_LG, d.DOK, d.DOK_NOM, d.DOK_DATA, d.NOM_AB from abit a left join DOK_LGOTA d on a.NOM_AB=d.NOM_AB where d.DOK like ''%военный%'' and a.nom_ab = ' + IntToStr(nom_ab));
          Form1.IBQuery1.First;
          while (not Form1.IBQuery1.Eof) do
          begin
            with AddChild('MilitaryCardDocument') do
            begin
              AddChild('UID');
              ChildValues['UID'] := '400000' + Form1.IBQuery1.FieldByName('N_DOK_LG').AsString;
              AddChild('OriginalReceived');
              ChildValues['OriginalReceived'] := OriginalReceived;
              if (OriginalReceived = 1) then
              begin
                AddChild('OriginalReceivedDate');
                ChildValues['OriginalReceivedDate'] := OriginalReceivedDate;
              end;
              AddChild('DocumentSeries');
              ChildValues['DocumentSeries'] := trim(copy(Form1.IBQuery1.FieldByName('DOK_NOM').AsString, 0, 2));
              AddChild('DocumentNumber');
              ChildValues['DocumentNumber'] := trim(copy(Form1.IBQuery1.FieldByName('DOK_NOM').AsString, 3, Length(Form1.IBQuery1.FieldByName('DOK_NOM').AsString)));
              AddChild('DocumentDate');
              str_date := Form1.IBQuery1.FieldByname('DOK_DATA').AsString;
              ChildValues['DocumentDate'] := copy(str_date, 7, 4) + '-' + copy(str_date, 4, 2) + '-' + copy(str_date, 1, 2);
              //AddChild('DocumentOrganization');
            end;
            Form1.IBQuery1.Next;
          end;
          {with AddChild('CustomDocuments') do
          begin
            with AddChild('CustomDocument') do
            begin
              AddChild('UID');
              AddChild('OriginalReceived');
              AddChild('OriginalReceivedDate');
              AddChild('DocumentSeries');
              AddChild('DocumentNumber');
              AddChild('DocumentDate');
              AddChild('DocumentOrganization');
              AddChild('AdditionalInfo');
              AddChild('DocumentTypeNameText');
            end;
          end;}
        end; //of application documents
      end; //of application
      Form1.IBQueryMain.Next;
    end; //of IBQueryMain
  end; //done with node
  Form1.IBQuery1.Close;
  Form1.IBQueryMain.Close;
  //MessageBox(0, 'Complete!', 'Success!', MB_OK);
  //inc(i);
  //end;
end;
//------------------------------------------------------------------------------------------

procedure post(const s: string);
begin
  with Form1.IBQuery1 do
  begin
    Active := false;
    //Free;
    Close;
    Sql.Clear;
    //Sql.Add(s);
    Sql.Append(s);
    Open;
  end;

end;
//------------------------------------------------------------------------------------------

procedure PostToQuery(const s: string; Query: TIBQuery); //Запись строки SQL запроса из строки s в IBQueryMain
begin
  with Query do
  begin
    //Active := false;
    Close;
    Sql.Clear;
    Sql.Append(s);
    Open;
    //Active := true;
  end;
end;

end.

