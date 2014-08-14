unit ImportResultXML;

interface
uses xmldom, XMLIntf, oxmldom, XMLDoc, msxmldom;
procedure CreatePatternResultImportPackage(IxmlDoc: IXMLDocument);
implementation

procedure CreatePatternResultImportPackage(IxmlDoc: IXMLDocument);
begin
//IxmlDoc.XML.Append('<?xml version="1.0" encoding="utf-8"?>');
IxmlDoc.Encoding:='utf-8';
IxmlDoc.Version:='1.0';
with IxmlDoc do
  begin
    with AddChild('ImportResultPackage') do
      begin
        AddChild('PackageID');
        with AddChild('Log') do
          begin
            with AddChild('Successful') do
              begin
                AddChild('AdmissionVolumes');
                AddChild('CompetitiveGroupItems');
                AddChild('Applications');
                AddChild('OrdersOfAdmissions');
              end;
            with AddChild('Failed') do
              begin
                with AddChild('AdmissionVolumes') do
                  begin
                    with AddChild('AdmissionVolume') do
                      begin
                        with AddChild('ErrorInfo') do
                          begin
                            AddChild('ErrorCode');
                            AddChild('Message');
                            with AddChild('ConflictItemsInfo') do
                              begin
                                with AddChild('Applications') do
                                  begin
                                    with AddChild('Application') do
                                      begin
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('OrdersOfAdmission') do
                                  begin
                                    with AddChild('Application') do
                                      begin
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('CompetitiveGroupItems') do
                                  begin
                                    with AddChild('CompetitiveGroupItem') do
                                      begin
                                        AddChild('CompetitiveGroupItemID');
                                        AddChild('DirectionCode');
                                        AddChild('DirectionName');
                                        AddChild('CompetitiveGroupName');
                                      end;
                                  end;
                                with AddChild('EntranceTestResults') do
                                  begin
                                    with AddChild('EntranceTestResult') do
                                      begin
                                        AddChild('EntranceTestResultID');
                                        AddChild('SubjectName');
                                        AddChild('resultSourceType');
                                        AddChild('ResultValue');
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('ApplicationCommonBenefits') do
                                  begin
                                    with AddChild('ApplicationCommonBenefit') do
                                      begin
                                        AddChild('ApplicationCommonBenefitID');
                                        AddChild('BenefitKindName');
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                              end;

                          end;
                        AddChild('EducationLevelName');
                        AddChild('DirectionName');
                      end;
                  end;
                with AddChild('CompetitiveGroups') do
                  begin
                    with AddChild('CompetitiveGroup') do
                      begin
                        with AddChild('ErrorInfo') do
                          begin
                            AddChild('ErrorCode');
                            AddChild('Message');
                            with AddChild('ConflictItemsInfo') do
                              begin
                                with AddChild('Applications') do
                                  begin
                                    with AddChild('Application') do
                                      begin
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('OrdersOfAdmission') do
                                  begin
                                    with AddChild('Application') do
                                      begin
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('CompetitiveGroupItems') do
                                  begin
                                    with AddChild('CompetitiveGroupItem') do
                                      begin
                                        AddChild('CompetitiveGroupItemID');
                                        AddChild('DirectionCode');
                                        AddChild('DirectionName');
                                        AddChild('CompetitiveGroupName');
                                      end;
                                  end;
                                with AddChild('EntranceTestResults') do
                                  begin
                                    with AddChild('EntranceTestResult') do
                                      begin
                                        AddChild('EntranceTestResultID');
                                        AddChild('SubjectName');
                                        AddChild('resultSourceType');
                                        AddChild('ResultValue');
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                                with AddChild('ApplicationCommonBenefits') do
                                  begin
                                    with AddChild('ApplicationCommonBenefit') do
                                      begin
                                        AddChild('ApplicationCommonBenefitID');
                                        AddChild('BenefitKindName');
                                        AddChild('ApplicationNumber');
                                        AddChild('RegistrationDate');
                                      end;
                                  end;
                              end;
                           end;

                        end;
                  end;
                with AddChild('CompetitiveGroupItems') do
                  begin
                  end;
                with AddChild('TargetOrganizations') do
                  begin
                  end;
                with AddChild('TargetOrganizationDirections') do
                  begin
                  end;
                with AddChild('EntranceTestItems') do
                  begin
                  end;
                with AddChild('CommonBenefit') do
                  begin
                  end;
                with AddChild('EntranceTestBenefits') do
                  begin
                  end;
                with AddChild('Applications') do
                  begin
                  end;
                with AddChild('OlympicDocuments') do
                  begin
                  end;
                with AddChild('OlympicTotalDocuments') do
                  begin
                  end;
                with AddChild('DisabilityDocuments') do
                  begin
                  end;
                with AddChild('MedicalDocuments') do
                  begin
                  end;
                with AddChild('AllowEducationDocuments') do
                  begin
                  end;
                with AddChild('CustomDocuments') do
                  begin
                  end;
                with AddChild('EntranceTestResults') do
                  begin
                  end;
                with AddChild('ApplicationCommonBenefits') do
                  begin
                  end;
                with AddChild('OrdersOfAdmissions') do
                  begin
                  end;
              end;
          end;
        with AddChild('Conflicts') do
          begin
          end;
      end;
  end;
IXMLDoc.SaveToFile('ImportResultXML.xml');
end;
end.





