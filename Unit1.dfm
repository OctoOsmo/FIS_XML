object Form1: TForm1
  Left = 489
  Top = 313
  Width = 569
  Height = 382
  Anchors = [akTop, akRight]
  Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1060#1048#1057
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    553
    323)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelPackageSize: TLabel
    Left = 8
    Top = 80
    Width = 163
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1103#1074#1083#1077#1085#1080#1081' '#1074' '#1087#1072#1082#1077#1090#1077
  end
  object LabelNomAbTo: TLabel
    Left = 8
    Top = 40
    Width = 74
    Height = 13
    Caption = 'LabelNomAbTo'
  end
  object LabelProxy: TLabel
    Left = 368
    Top = 0
    Width = 115
    Height = 13
    Hint = #1054#1089#1090#1072#1074#1080#1090#1100' '#1087#1091#1089#1090#1099#1084'  '#1077#1089#1083#1080' '#1087#1088#1086#1082#1089#1080' '#1089#1077#1088#1074#1077#1088'  '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
    Anchors = [akTop, akRight]
    Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1082#1089#1080' '#1089#1077#1088#1074#1077#1088#1072
    ParentShowHint = False
    ShowHint = True
  end
  object LabelNomAbFrom: TLabel
    Left = 8
    Top = 0
    Width = 84
    Height = 13
    Caption = 'LabelNomAbFrom'
  end
  object LabelServicePath: TLabel
    Left = 368
    Top = 40
    Width = 164
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1080#1089#1072' '#1074#1079#1072#1080#1084#1086#1076#1077#1081#1089#1090#1074#1080#1103
    ParentShowHint = False
    ShowHint = True
  end
  object LabelPackageID: TLabel
    Left = 368
    Top = 80
    Width = 75
    Height = 13
    Hint = #1053#1086#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072' '#1080#1084#1087#1086#1088#1090#1072' '#1074' '#1060#1048#1057
    Anchors = [akTop, akRight]
    Caption = #1053#1086#1084#1077#1088' '#1087#1072#1082#1077#1090#1072' '
    ParentShowHint = False
    ShowHint = True
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 306
    Width = 553
    Height = 17
    Align = alBottom
    TabOrder = 0
  end
  object ComboBox2: TComboBox
    Left = 368
    Top = 16
    Width = 177
    Height = 21
    Anchors = [akTop, akRight]
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox2Change
    Items.Strings = (
      ''
      'http://10.0.15.12:3128')
  end
  object ComboBox3: TComboBox
    Left = 368
    Top = 56
    Width = 177
    Height = 21
    Anchors = [akTop, akRight]
    ItemHeight = 13
    TabOrder = 2
    Text = 'priem.edu.ru:8000'
    OnChange = ComboBox3Change
    Items.Strings = (
      'priem.edu.ru:8000'
      'priem.edu.ru:8080'
      '10.0.3.1:8000'
      '10.0.3.1:8080')
  end
  object Edit2: TEdit
    Left = 368
    Top = 96
    Width = 177
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 3
    Text = '0'
  end
  object EditNomAbFrom: TEdit
    Left = 8
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object EditNomAbTo: TEdit
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '8915'
  end
  object EditPackageSize: TEdit
    Left = 8
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '100'
  end
  object MemoResult: TMemo
    Left = 8
    Top = 120
    Width = 537
    Height = 177
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoResult')
    TabOrder = 7
  end
  object DataSource1: TDataSource
    DataSet = IBTable1
    Left = 200
    Top = 32
  end
  object IBTable1: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'NOM_AB'
        DataType = ftInteger
      end
      item
        Name = 'FAM'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'NAM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'OTCH'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'DAT_R'
        DataType = ftDate
      end
      item
        Name = 'DAT_PZ'
        DataType = ftDate
      end
      item
        Name = 'ZABR'
        DataType = ftSmallint
      end
      item
        Name = 'DAT_ZABR'
        DataType = ftDate
      end
      item
        Name = 'SUMBAL'
        DataType = ftSmallint
      end
      item
        Name = 'SUM100'
        DataType = ftSmallint
      end
      item
        Name = 'DOK_IN_PK'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PO_POST'
        DataType = ftSmallint
      end
      item
        Name = 'KOPIA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'POL'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'MED'
        DataType = ftInteger
      end
      item
        Name = 'NOM_UZAV'
        DataType = ftInteger
      end
      item
        Name = 'GOD_UCHZ'
        DataType = ftInteger
      end
      item
        Name = 'NOM_UCHZ'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NOM_IJZ'
        DataType = ftInteger
      end
      item
        Name = 'PRIZ_BE'
        DataType = ftSmallint
      end
      item
        Name = 'PRIZ_VK'
        DataType = ftSmallint
      end
      item
        Name = 'PRIZ_PP'
        DataType = ftSmallint
      end
      item
        Name = 'TEL'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'MOB_TEL'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'EGE_SVID'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EGE_GOD'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EGE_COPY'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'EGE_NOM'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'EGE_SERIA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'EGE_NOM2'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'EGE_SERIA2'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'EGE_NOM3'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'EGE_SERIA3'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'EGE_NOM4'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'EGE_SERIA4'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'MESTO_EGE'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'OLIMP_KTO'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'OLIMP_PO'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'NOM_OLIMP'
        DataType = ftInteger
      end
      item
        Name = 'DIPLOM_OLIMP'
        DataType = ftSmallint
      end
      item
        Name = 'OLIMP_REKV'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SUM_XBR'
        DataType = ftSmallint
      end
      item
        Name = 'SUM_XR'
        DataType = ftSmallint
      end
      item
        Name = 'SUM_BR'
        DataType = ftSmallint
      end
      item
        Name = 'NEUD_B'
        DataType = ftSmallint
      end
      item
        Name = 'NEUD_X'
        DataType = ftSmallint
      end
      item
        Name = 'DOPUSK_B'
        DataType = ftSmallint
      end
      item
        Name = 'DOPUSK_X'
        DataType = ftSmallint
      end
      item
        Name = 'DOPUSK_R'
        DataType = ftSmallint
      end
      item
        Name = 'NEUD'
        DataType = ftSmallint
      end
      item
        Name = 'DOPUSK'
        DataType = ftSmallint
      end
      item
        Name = 'NOM_GOS'
        DataType = ftInteger
      end
      item
        Name = 'NOM_OBL'
        DataType = ftInteger
      end
      item
        Name = 'NOM_RAI'
        DataType = ftInteger
      end
      item
        Name = 'NOM_PUN'
        DataType = ftInteger
      end
      item
        Name = 'C_CH_R'
        DataType = ftInteger
      end
      item
        Name = 'V_OBL'
        DataType = ftInteger
      end
      item
        Name = 'V_CITY'
        DataType = ftInteger
      end
      item
        Name = 'OBL_UZ'
        DataType = ftInteger
      end
      item
        Name = 'NAS_P_UZ'
        DataType = ftInteger
      end
      item
        Name = 'POST'
        DataType = ftSmallint
      end
      item
        Name = 'ADRES'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'KOD_DOK'
        DataType = ftInteger
      end
      item
        Name = 'DOK'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'DOK_S'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'DOK_N'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'DATE_PASP'
        DataType = ftDate
      end
      item
        Name = 'KEM_DOK'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MESTO_ROJD'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'GRAJD'
        DataType = ftInteger
      end
      item
        Name = 'INDEKS'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'ULIC'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'DOM'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'KORP'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'KVART'
        DataType = ftSmallint
      end
      item
        Name = 'KV'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'VREM'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'UROV_YAZ'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OBR_V2'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ATTESTAT'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ATT_COPY'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ATT_SERIA'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'ATT_NOM'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ATT_DATE'
        DataType = ftDate
      end
      item
        Name = 'ATT_KEM'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'FAM1'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'TIP_DOK'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NOM_OGRAN'
        DataType = ftInteger
      end
      item
        Name = 'POST_ADRES'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'NPP_VUZ'
        DataType = ftSmallint
      end
      item
        Name = 'PROV_FBS'
        DataType = ftSmallint
      end
      item
        Name = 'DOK_OLD'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'SRED_BALL_ATT'
        DataType = ftBCD
        Precision = 9
        Size = 3
      end
      item
        Name = 'IZM_PO_FBS'
        DataType = ftSmallint
      end
      item
        Name = 'DATA_PRIOR'
        DataType = ftDate
      end
      item
        Name = 'EBD_ZAP'
        DataType = ftSmallint
      end
      item
        Name = 'BLOK'
        DataType = ftSmallint
      end
      item
        Name = 'OPLATIL'
        DataType = ftSmallint
      end
      item
        Name = 'KURSI'
        DataType = ftSmallint
      end
      item
        Name = 'KURSI_FORM'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'KURSI_MESTO'
        DataType = ftInteger
      end
      item
        Name = 'SUM_XBR_OL'
        DataType = ftSmallint
      end
      item
        Name = 'SUM_XR_OL'
        DataType = ftSmallint
      end
      item
        Name = 'SUM_BR_OL'
        DataType = ftSmallint
      end
      item
        Name = 'EL_ADRES'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'POTREB_OB'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'REKV_LGOT'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'USER_NAME'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_DATA'
        DataType = ftDate
      end
      item
        Name = 'USER_NAME_UP'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_DATA_UP'
        DataType = ftDate
      end
      item
        Name = 'USER_ZABR'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_ZABR_DAT'
        DataType = ftDate
      end
      item
        Name = 'USER_KOPIA_NA_1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_KOPIA_DAT_NA_1'
        DataType = ftDate
      end
      item
        Name = 'USER_KOPIA_NA_0'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_KOPIA_DAT_NA_0'
        DataType = ftDate
      end
      item
        Name = 'USER_ZABR_NA_0'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'USER_ZABR_DAT_NA_0'
        DataType = ftDate
      end
      item
        Name = 'OBR_S2'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY1'
        Fields = 'NOM_AB'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'RDB$FOREIGN28'
        Fields = 'NOM_IJZ'
      end
      item
        Name = 'RDB$FOREIGN29'
        Fields = 'NOM_RAI'
      end
      item
        Name = 'RDB$FOREIGN30'
        Fields = 'NOM_UZAV'
      end
      item
        Name = 'ABIT_IDX2'
        Fields = 'ZABR;DOPUSK;NEUD'
      end
      item
        Name = 'RDB$FOREIGN33'
        Fields = 'NOM_PUN'
      end
      item
        Name = 'RDB$FOREIGN34'
        Fields = 'MED'
      end
      item
        Name = 'ABIT_IDX1'
        Fields = 'FAM;NAM;OTCH'
      end
      item
        Name = 'RDB$FOREIGN13'
        Fields = 'NOM_OBL'
      end
      item
        Name = 'RDB$FOREIGN14'
        Fields = 'OBL_UZ'
      end
      item
        Name = 'RDB$FOREIGN1'
        Fields = 'NOM_GOS'
      end
      item
        Name = 'FK_ABIT_1'
        Fields = 'NOM_OGRAN'
      end
      item
        Name = 'ABIT_IDX3'
        Fields = 'FAM'
      end
      item
        Name = 'FK_ABIT_2'
        Fields = 'NOM_OLIMP'
      end
      item
        Name = 'ABIT_IDX8'
        Fields = 'DOK_IN_PK'
      end
      item
        Name = 'ABIT_IDX7'
        Fields = 'SUM100'
      end
      item
        Name = 'ABIT_IDX6'
        Fields = 'PRIZ_PP'
      end
      item
        Name = 'ABIT_IDX5'
        Fields = 'PRIZ_VK'
      end
      item
        Name = 'ABIT_IDX4'
        Fields = 'DAT_PZ'
      end
      item
        Name = 'FK_ABIT_3'
        Fields = 'GRAJD'
      end
      item
        Name = 'ABIT_IDX9'
        Fields = 'SUM_XBR'
      end
      item
        Name = 'ABIT_IDX11'
        Fields = 'SUM_BR'
      end
      item
        Name = 'ABIT_IDX10'
        Fields = 'SUM_XR'
      end>
    StoreDefs = True
    TableName = 'ABIT'
    Left = 136
    Top = 32
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 
      'D:\Cloud@Mail.Ru\'#1055#1088#1086#1075#1088#1072#1084#1084#1099'\Projects '#1090#1086#1083#1100#1082#1086' '#1086#1090#1087#1088#1072#1074#1082#1072' - '#1082#1086#1087#1080#1103' '#8212' '#1082#1086 +
      #1087#1080#1103'\ABIT2014(RESTORED).GDB'
    Params.Strings = (
      'user_name=SYSDBA'
      'lc_ctype=WIN1251'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 200
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase1
    AutoStopAction = saNone
    Left = 232
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = DataSource1
    Left = 168
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = DataSource1
    SQL.Strings = (
      
        'SELECT sum(PRIEM_KOL) from KATEG_PR where (N_FAK=1 And (NOM_TIPP' +
        'OS=1 or NOM_TIPPOS=2))')
    Left = 264
  end
  object MainMenu: TMainMenu
    Left = 136
    object Create1: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100
      object CreateImportpackage: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1080#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1077' '#1087#1072#1082#1077#1090#1099
        OnClick = CreateImportpackageClick
      end
      object CreateDeletePackage: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1072#1082#1077#1090' '#1089' '#1076#1072#1085#1085#1099#1084#1080' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103
        OnClick = CreateDeletePackageClick
      end
      object CreateAdmissionPackage: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1072#1082#1077#1090' '#1089' '#1087#1088#1080#1082#1072#1079#1086#1084' '#1085#1072' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1077
        OnClick = CreateAdmissionPackageClick
      end
    end
    object Get1: TMenuItem
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100
      object GetDictionaryList: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
        OnClick = GetDictionaryListClick
      end
      object GetDictionary: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
        OnClick = GetDictionaryClick
      end
      object ImportResult: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1080#1084#1087#1086#1088#1090#1072
        OnClick = ImportResultClick
      end
      object GetDeleteResult: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1091#1076#1072#1083#1077#1085#1080#1103
        OnClick = GetDeleteResultClick
      end
      object AdmissionImportResult: TMenuItem
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1080#1084#1087#1086#1088#1090#1072' '#1087#1088#1080#1082#1072#1079#1072
        OnClick = AdmissionImportResultClick
      end
    end
    object Send1: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      object Validate: TMenuItem
        Caption = #1042#1072#1083#1080#1076#1072#1094#1080#1103
        OnClick = ValidateClick
      end
      object Import: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1087#1072#1082#1077#1090#1086#1074' '#1074' '#1060#1048#1057
        OnClick = ImportClick
      end
      object Delete: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1103#1074#1083#1077#1085#1080#1103
        OnClick = DeleteClick
      end
      object AdmissionImport: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1087#1088#1080#1082#1072#1079#1072' '#1085#1072' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1077
        OnClick = AdmissionImportClick
      end
    end
  end
  object HTTPReqResp1: THTTPReqResp
    Agent = 'Borland SOAP 1.2'
    UseUTF8InHeader = False
    InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Left = 264
    Top = 32
  end
  object XMLDocument1: TXMLDocument
    Left = 232
    Top = 32
    DOMVendorDesc = 'Open XML'
  end
  object IBQueryMain: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 168
    Top = 32
  end
end
