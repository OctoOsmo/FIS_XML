
{*********************************************************************************************************************************************************************************}
{                                                                                                                                                                                 }
{                                                                                XML Data Binding                                                                                 }
{                                                                                                                                                                                 }
{         Generated on: 28.02.2012 11:54:43                                                                                                                                       }
{       Generated from: D:\ГосОбрНеобходимость\ФИС\XML схемы методов сервиса автоматизированного взаимодействия\Валидация импортируемого пакета\XSD ValidationResultPackage.xsd   }
{   Settings stored in: D:\ГосОбрНеобходимость\Projects\XSD ValidationResultPackage.xdb                                                                                           }
{                                                                                                                                                                                 }
{*********************************************************************************************************************************************************************************}

unit XSDValidationResultPackage;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLValidationResultPackage = interface;

{ IXMLValidationResultPackage }

  IXMLValidationResultPackage = interface(IXMLNode)
    ['{A8A1CBD6-3196-4443-A737-791C49582CF3}']
    { Property Accessors }
    function Get_StatusCode: Byte;
    function Get_Message: WideString;
    procedure Set_StatusCode(Value: Byte);
    procedure Set_Message(Value: WideString);
    { Methods & Properties }
    property StatusCode: Byte read Get_StatusCode write Set_StatusCode;
    property Message: WideString read Get_Message write Set_Message;
  end;

{ Forward Decls }

  TXMLValidationResultPackage = class;

{ TXMLValidationResultPackage }

  TXMLValidationResultPackage = class(TXMLNode, IXMLValidationResultPackage)
  Public
    { IXMLValidationResultPackage }
    function Get_StatusCode: Byte;
    function Get_Message: WideString;
    procedure Set_StatusCode(Value: Byte);
    procedure Set_Message(Value: WideString);
  end;

{ Global Functions }

function GetValidationResultPackage(Doc: IXMLDocument): IXMLValidationResultPackage;
function LoadValidationResultPackage(const FileName: WideString): IXMLValidationResultPackage;
function NewValidationResultPackage: IXMLValidationResultPackage;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetValidationResultPackage(Doc: IXMLDocument): IXMLValidationResultPackage;
begin
  Result := Doc.GetDocBinding('ValidationResultPackage', TXMLValidationResultPackage, TargetNamespace) as IXMLValidationResultPackage;
end;

function LoadValidationResultPackage(const FileName: WideString): IXMLValidationResultPackage;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('ValidationResultPackage', TXMLValidationResultPackage, TargetNamespace) as IXMLValidationResultPackage;
end;

function NewValidationResultPackage: IXMLValidationResultPackage;
begin
  Result := NewXMLDocument.GetDocBinding('ValidationResultPackage', TXMLValidationResultPackage, TargetNamespace) as IXMLValidationResultPackage;
end;

{ TXMLValidationResultPackage }

function TXMLValidationResultPackage.Get_StatusCode: Byte;
begin
  Result := ChildNodes['StatusCode'].NodeValue;
end;

procedure TXMLValidationResultPackage.Set_StatusCode(Value: Byte);
begin
  ChildNodes['StatusCode'].NodeValue := Value;
end;

function TXMLValidationResultPackage.Get_Message: WideString;
begin
  Result := ChildNodes['Message'].Text;
end;

procedure TXMLValidationResultPackage.Set_Message(Value: WideString);
begin
  ChildNodes['Message'].NodeValue := Value;
end;

end.