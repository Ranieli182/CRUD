unit uFuncionario;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils;

type
  TFuncionario = class
  private
    FCODIGO: integer;
    FNOME: string;
    FENDERECO: string;
    FBAIRRO: string;
    FNUMERO: string;
    FCOMPLEMENTO: string;
    FCIDADE: string;
    FCEP: string;
    FCPF: string;
    FRG: string;
    FTELEFONE: string;
    FDATA_NASCIMENTO: TDate;
    FEMAIL: string;
    FSALARIO: Double;

    class var FObjetoBusca: TFuncionario;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    class function ValidaCPF(pCPF: string): boolean;
    class function ValidaCEP(pCEP: string): boolean;
    class function Existe(pCodigo: integer): boolean;
    function MostraProximoID: integer;

    constructor Create;
    property CODIGO: integer read FCODIGO write FCODIGO;
    property NOME: string read FNOME write FNOME;
    property ENDERECO: string read FENDERECO write FENDERECO;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property NUMERO: string read FNUMERO write FNUMERO;
    property COMPLEMENTO: string read FCOMPLEMENTO write FCOMPLEMENTO;
    property CIDADE: string read FCIDADE write FCIDADE;
    property CEP: string read FCEP write FCEP;
    property CPF: string read FCPF write FCPF;
    property RG: string read FRG write FRG;
    property TELEFONE: string read FTELEFONE write FTELEFONE;
    property DATA_NASCIMENTO: TDate read FDATA_NASCIMENTO
      write FDATA_NASCIMENTO;
    property EMAIL: string read FEMAIL write FEMAIL;
    property SALARIO: double read FSALARIO write FSALARIO;

    class property ObjetoBusca: TFuncionario read FObjetoBusca write FObjetoBusca;
  end;

implementation

{ TCliente }

procedure TFuncionario.Alterar(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' UPDATE FUNCIONARIO SET               ');
    lQuery.sql.Add(' NOME = :NOME                         ');
    lQuery.sql.Add(' ,ENDERECO = :ENDERECO                ');
    lQuery.sql.Add(' ,BAIRRO = :BAIRRO                    ');
    lQuery.sql.Add(' ,NUMERO = :NUMERO                    ');
    lQuery.sql.Add(' ,COMPLEMENTO = :COMPLEMENTO          ');
    lQuery.sql.Add(' ,CIDADE = :CIDADE                    ');
    lQuery.sql.Add(' ,CEP = :CEP                          ');
    lQuery.sql.Add(' ,CPF = :CPF                          ');
    lQuery.sql.Add(' ,RG = :RG                            ');
    lQuery.sql.Add(' ,TELEFONE = :TELEFONE                ');
    lQuery.sql.Add(' ,DATA_NASCIMENTO = :DATA_NASCIMENTO  ');
    lQuery.sql.Add(' ,EMAIL = :EMAIL                      ');
    lQuery.sql.Add(' ,SALARIO = :SALARIO                  ');
    lQuery.sql.Add(' WHERE CODIGO = :CODIGO               ');

    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('ENDERECO').AsString := FENDERECO;
    lQuery.ParamByName('BAIRRO').AsString := FBAIRRO;
    lQuery.ParamByName('NUMERO').AsString := FNUMERO;
    lQuery.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
    lQuery.ParamByName('CEP').AsString := FCEP;
    lQuery.ParamByName('CPF').AsString := FCPF;
    lQuery.ParamByName('RG').AsString := FRG;
    lQuery.ParamByName('TELEFONE').AsString := FTELEFONE;
    lQuery.ParamByName('DATA_NASCIMENTO').AsDate := FDATA_NASCIMENTO;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('SALARIO').AsFloat := FSALARIO;

    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;

  finally
    lQuery.Free;
  end;
end;

procedure TFuncionario.Carrega;
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' SELECT * FROM FUNCIONARIO ');
    lQuery.sql.Add(' WHERE CODIGO = :CODIGO        ');
    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FNOME := lQuery.FieldByName('NOME').AsString;
      FENDERECO := lQuery.FieldByName('ENDERECO').AsString;
      FBAIRRO := lQuery.FieldByName('BAIRRO').AsString;
      FNUMERO := lQuery.FieldByName('NUMERO').AsString;
      FCOMPLEMENTO := lQuery.FieldByName('COMPLEMENTO').AsString;
      FCIDADE := lQuery.FieldByName('CIDADE').AsString;
      FCEP := lQuery.FieldByName('CEP').AsString;
      FCPF := lQuery.FieldByName('CPF').AsString;
      FRG := lQuery.FieldByName('RG').AsString;
      FTELEFONE := lQuery.FieldByName('TELEFONE').AsString;
      FDATA_NASCIMENTO := lQuery.FieldByName('DATA_NASCIMENTO').AsDateTime;
      FEMAIL := lQuery.FieldByName('EMAIL').AsString;
      FSALARIO := lQuery.FieldByName('SALARIO').AsFloat;
    end;

  finally
    lQuery.Free;
  end;
end;

constructor TFuncionario.Create;
begin
  Inicializar;
end;

destructor TFuncionario.Destroy;
begin

  inherited;
end;

procedure TFuncionario.Excluir(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add('DELETE FROM FUNCIONARIO WHERE CODIGO = :CODIGO ');
    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TFuncionario.Existe(pCodigo: integer): boolean;
var
  lQuery: Tfdquery;
begin
  Result := false;
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add('SELECT * FROM FUNCIONARIO WHERE CODIGO = :CODIGO');
    lQuery.ParamByName('CODIGO').AsInteger := pCodigo;
    lQuery.Open;
    if (lQuery.RecordCount > 0) then
    begin
      Result := true;
      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TFuncionario.Create;
      end;
      FObjetoBusca.CODIGO := pCodigo;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TFuncionario.Incluir(pEfetuarCommit: boolean);
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' INSERT INTO FUNCIONARIO(       ');
    lQuery.sql.Add(' CODIGO                         ');
    lQuery.sql.Add(' ,NOME                          ');
    lQuery.sql.Add(' ,ENDERECO                      ');
    lQuery.sql.Add(' ,BAIRRO                        ');
    lQuery.sql.Add(' ,NUMERO                        ');
    lQuery.sql.Add(' ,COMPLEMENTO                   ');
    lQuery.sql.Add(' ,CIDADE                        ');
    lQuery.sql.Add(' ,CEP                           ');
    lQuery.sql.Add(' ,CPF                           ');
    lQuery.sql.Add(' ,RG                            ');
    lQuery.sql.Add(' ,TELEFONE                      ');
    lQuery.sql.Add(' ,DATA_NASCIMENTO               ');
    lQuery.sql.Add(' ,EMAIL                         ');
    lQuery.sql.Add(' ,SALARIO                       ');
    lQuery.sql.Add(' )VALUES(                       ');
    lQuery.sql.Add(' :CODIGO                        ');
    lQuery.sql.Add(' ,:NOME                         ');
    lQuery.sql.Add(' ,:ENDERECO                     ');
    lQuery.sql.Add(' ,:BAIRRO                       ');
    lQuery.sql.Add(' ,:NUMERO                       ');
    lQuery.sql.Add(' ,:COMPLEMENTO                  ');
    lQuery.sql.Add(' ,:CIDADE                       ');
    lQuery.sql.Add(' ,:CEP                          ');
    lQuery.sql.Add(' ,:CPF                          ');
    lQuery.sql.Add(' ,:RG                           ');
    lQuery.sql.Add(' ,:TELEFONE                     ');
    lQuery.sql.Add(' ,:DATA_NASCIMENTO              ');
    lQuery.sql.Add(' ,:EMAIL                        ');
    lQuery.sql.Add(' ,:SALARIO                     )');

    lQuery.ParamByName('CODIGO').AsInteger := FCODIGO;
    lQuery.ParamByName('NOME').AsString := FNOME;
    lQuery.ParamByName('ENDERECO').AsString := FENDERECO;
    lQuery.ParamByName('BAIRRO').AsString := FBAIRRO;
    lQuery.ParamByName('NUMERO').AsString := FNUMERO;
    lQuery.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
    lQuery.ParamByName('CIDADE').AsString := FCIDADE;
    lQuery.ParamByName('CEP').AsString := FCEP;
    lQuery.ParamByName('CPF').AsString := FCPF;
    lQuery.ParamByName('RG').AsString := FRG;
    lQuery.ParamByName('TELEFONE').AsString := FTELEFONE;
    lQuery.ParamByName('DATA_NASCIMENTO').AsDate := FDATA_NASCIMENTO;
    lQuery.ParamByName('EMAIL').AsString := FEMAIL;
    lQuery.ParamByName('SALARIO').AsFloat := FSALARIO;
    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmconexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;

end;

procedure TFuncionario.Inicializar;
begin
  FNOME := '';
  FENDERECO := '';
  FBAIRRO := '';
  FNUMERO := '';
  FCOMPLEMENTO := '';
  FCIDADE := '';
  FCEP := '';
  FCPF := '';
  FRG := '';
  FTELEFONE := '';
  FDATA_NASCIMENTO := 0;
  FEMAIL := '';
  FSALARIO := 0;
end;

function TFuncionario.MostraProximoID: integer;
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    lQuery.Connection := dtmconexao.FDConnection;
    lQuery.Close;
    lQuery.sql.Clear;
    lQuery.sql.Add(' SELECT gen_id(GEN_FUNCIONARIO_ID, 0)+1 codigo from FUNCIONARIO');
    lQuery.Open;
    Result := lQuery.FieldByName('codigo').AsInteger;
  finally
    lQuery.Free;
  end;
end;

class function TFuncionario.ValidaCEP(pCEP: string): boolean;
var
  lQuery: Tfdquery;
begin
  lQuery := Tfdquery.Create(nil);
  try
    if Length(pCEP) < 8 then
    begin
      Result := false;
    end
    else
    begin
      Result := true;
    end;

  finally
    lQuery.Free;
  end;
end;

class function TFuncionario.ValidaCPF(pCPF: string): boolean;
var
  i, a, NUMERO, Resto: Byte;
  DV1, DV2: Byte;
  Total, Soma: integer;
  res: string;

  lQuery: Tfdquery;

begin
  lQuery := Tfdquery.Create(nil);
  try
    Result := false;
    if Length(trim(pCPF)) = 11 then
    begin

      // Não digitar 11 numeros iguais
      for a := 0 to 9 do // percorre os nr iguais
      begin
        res := '';
        for i := 1 to 11 do // repete o nr para formar o CPF igual
          res := res + IntToStr(a);
        if pCPF = res then // se o CPF for igual os nr repetido cai fora
        begin
          Result := false;
          Exit;
        end;
      end;
      // fim não digitar nr iguais

      Total := 0;
      Soma := 0;
      for i := 1 to 9 do
      begin
        try
          NUMERO := StrToInt(pCPF[i]);
        except
          NUMERO := 0;
        end;
        Total := Total + (NUMERO * (11 - i));
        Soma := Soma + NUMERO;
      end;
      Resto := Total mod 11;
      if Resto > 1 then
        DV1 := 11 - Resto
      else
        DV1 := 0;
      Total := Total + Soma + 2 * DV1;
      Resto := Total mod 11;
      if Resto > 1 then
        DV2 := 11 - Resto
      else
        DV2 := 0;
      if (IntToStr(DV1) = pCPF[10]) and (IntToStr(DV2) = pCPF[11]) then
        Result := true;
    end;

  finally
    lQuery.Free;
  end;

end;

end.
