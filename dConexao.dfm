object dtmConexao: TdtmConexao
  OldCreateOrder = False
  Height = 236
  Width = 320
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 32
    Top = 56
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\CRUD\Banco\BANCO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Left = 32
    Top = 8
  end
  object dtsFuncionario: TDataSource
    DataSet = qryConsultaFuncionario
    Left = 232
    Top = 8
  end
  object qryFuncionario: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM FUNCIONARIO')
    Left = 160
    Top = 8
    object qryFuncionarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryFuncionarioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qryFuncionarioENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object qryFuncionarioBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryFuncionarioNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object qryFuncionarioCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 50
    end
    object qryFuncionarioCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object qryFuncionarioCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 15
    end
    object qryFuncionarioCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 15
    end
    object qryFuncionarioRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 10
    end
    object qryFuncionarioTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 15
    end
    object qryFuncionarioDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
      Origin = 'DATA_NASCIMENTO'
    end
    object qryFuncionarioEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object qryFuncionarioSALARIO: TBCDField
      FieldName = 'SALARIO'
      Origin = 'SALARIO'
      Precision = 18
    end
  end
  object qryConsultaFuncionario: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM FUNCIONARIO')
    Left = 160
    Top = 56
    object qryConsultaFuncionarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaFuncionarioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qryConsultaFuncionarioENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object qryConsultaFuncionarioBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryConsultaFuncionarioNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object qryConsultaFuncionarioCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 50
    end
    object qryConsultaFuncionarioCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object qryConsultaFuncionarioCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 15
    end
    object qryConsultaFuncionarioCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 15
    end
    object qryConsultaFuncionarioRG: TStringField
      FieldName = 'RG'
      Origin = 'RG'
      Size = 10
    end
    object qryConsultaFuncionarioTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 15
    end
    object qryConsultaFuncionarioDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
      Origin = 'DATA_NASCIMENTO'
    end
    object qryConsultaFuncionarioEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object qryConsultaFuncionarioSALARIO: TBCDField
      FieldName = 'SALARIO'
      Origin = 'SALARIO'
      Precision = 18
    end
  end
  object qryCidade: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM CIDADE')
    Left = 144
    Top = 120
    object qryCidadeCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCidadeCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object qryCidadeUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
    object qryCidadePAIS: TStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      Size = 50
    end
  end
  object qryConsultaCidade: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM CIDADE')
    Left = 144
    Top = 168
    object qryConsultaCidadeCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryConsultaCidadeCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object qryConsultaCidadeUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
    object qryConsultaCidadePAIS: TStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      Size = 50
    end
  end
  object dtsCidade: TDataSource
    DataSet = qryConsultaCidade
    Left = 216
    Top = 120
  end
end
