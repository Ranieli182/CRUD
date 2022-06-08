unit fConsultaFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, dConexao, fCadastroFuncionario, uFuncionario;

type
  TfrmConsultaFuncionario = class(TForm)
    Panel1: TPanel;
    dbgConsultaFuncionario: TDBGrid;
    Panel2: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnSair: TButton;
    edtPesquisarFuncionario: TEdit;
    btnVisualizar: TButton;
    cbxFiltroFuncionario: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtPesquisarFuncionarioChange(Sender: TObject);
    procedure cbxFiltroFuncionarioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizarQueryFuncionario;
    procedure BuscarDadosFuncionario;
    procedure ValidaSeUsuarioEstaLiberado(pNivelAcesso: Integer);
  end;

var
  frmConsultaFuncionario: TfrmConsultaFuncionario;

implementation

{$R *.dfm}

procedure TfrmConsultaFuncionario.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaFuncionario.RecordCount > 0 then
  begin
    BuscarDadosFuncionario;
  end
  else
  begin
    ShowMessage('Não há registro selecionado.');
  end;
end;

procedure TfrmConsultaFuncionario.btnExcluirClick(Sender: TObject);
var
  lFuncionario: TFuncionario;
begin
  if dtmConexao.qryConsultaFuncionario.RecordCount > 0 then
  begin
    if Application.MessageBox
      ('Tem certeza que deseja excluir o registro selecionado?', 'Confirmação',
      mb_yesNO + mb_iconQuestion + MB_DEFBUTTON2) = idYes then
    begin

      lFuncionario := TFuncionario.Create;
      try
        lFuncionario.CODIGO := dtmConexao.qryConsultaFuncionarioCODIGO.
          AsInteger;
        lFuncionario.Excluir(true);
        AtualizarQueryFuncionario;
        frmConsultaFuncionario.Refresh;
      finally
        lFuncionario.Free;
      end;

    end;
  end
  else
  begin
    ShowMessage('Não há registro selecionado.');
  end;

end;

procedure TfrmConsultaFuncionario.btnIncluirClick(Sender: TObject);
var
  lFormulario: TfrmCadastroFuncionario;
  lFuncionario: TFuncionario;
begin
  lFormulario := TfrmCadastroFuncionario.Create(nil);
  lFuncionario := TFuncionario.Create;
  try
    lFormulario.Tipo := 'Incluir';
    lFormulario.edtCodigo.Enabled := false;
    lFormulario.edtCodigo.Text := lFuncionario.MostraProximoID.ToString;
    lFormulario.ShowModal;
    AtualizarQueryFuncionario;
  finally
    lFormulario.Free;
    lFuncionario.Free;
  end;
end;

procedure TfrmConsultaFuncionario.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaFuncionario.btnVisualizarClick(Sender: TObject);
var
  lFormulario: TfrmCadastroFuncionario;
  lFuncionario: TFuncionario;
begin
  if dtmConexao.qryConsultaFuncionario.RecordCount > 0 then
  begin
    lFuncionario := TFuncionario.Create;
    lFormulario := TfrmCadastroFuncionario.Create(nil);
    try
      lFuncionario.CODIGO := dtmConexao.qryConsultaFuncionario.FieldByName
        ('CODIGO').AsInteger;
      lFuncionario.Carrega;
      lFormulario.edtCodigo.Text := IntToStr(lFuncionario.CODIGO);
      lFormulario.edtNome.Text := lFuncionario.NOME;
      lFormulario.edtEndereco.Text := lFuncionario.ENDERECO;
      lFormulario.edtBairro.Text := lFuncionario.BAIRRO;
      lFormulario.edtNumero.Text := lFuncionario.NUMERO;
      lFormulario.edtComplemento.Text := lFuncionario.COMPLEMENTO;
      lFormulario.edtCidade.Text := lFuncionario.CIDADE;
      lFormulario.edtCEP.Text := lFuncionario.CEP;
      lFormulario.edtCPF.Text := lFuncionario.CPF;
      lFormulario.edtRG.Text := lFuncionario.RG;
      lFormulario.edtTelefone.Text := lFuncionario.TELEFONE;
      lFormulario.edtData.Date := lFuncionario.DATA_NASCIMENTO;
      lFormulario.edtEMAIL.Text := lFuncionario.EMAIL;
      lFormulario.edtSalario.value := lFuncionario.SALARIO;

      lFormulario.btnSalvar.Enabled := false;
      lFormulario.ShowModal;
      AtualizarQueryFuncionario;
    finally
      lFormulario.Free;
      lFuncionario.Free;
    end;
  end
  else
  begin
    ShowMessage('Não há registro selecionado.');
  end;

end;

procedure TfrmConsultaFuncionario.BuscarDadosFuncionario;
var
  lFormulario: TfrmCadastroFuncionario;
  lFuncionario: TFuncionario;
begin
  lFuncionario := TFuncionario.Create;
  lFormulario := TfrmCadastroFuncionario.Create(nil);
  try
    lFormulario.Tipo := 'Alterar';
    lFormulario.CodigoFuncionario := 0;
    lFuncionario.CODIGO := dtmConexao.qryConsultaFuncionario.FieldByName
      ('CODIGO').AsInteger;
    lFormulario.CodigoFuncionario := lFuncionario.CODIGO;
    lFuncionario.Carrega;
    lFormulario.edtCodigo.Text := IntToStr(lFuncionario.CODIGO);
    lFormulario.edtNome.Text := lFuncionario.NOME;
    lFormulario.edtEndereco.Text := lFuncionario.ENDERECO;
    lFormulario.edtBairro.Text := lFuncionario.BAIRRO;
    lFormulario.edtNumero.Text := lFuncionario.NUMERO;
    lFormulario.edtComplemento.Text := lFuncionario.COMPLEMENTO;
    lFormulario.edtCidade.Text := lFuncionario.CIDADE;
    lFormulario.edtCEP.Text := lFuncionario.CEP;
    lFormulario.edtCPF.Text := lFuncionario.CPF;
    lFormulario.edtRG.Text := lFuncionario.RG;
    lFormulario.edtTelefone.Text := lFuncionario.TELEFONE;
    lFormulario.edtData.Date := lFuncionario.DATA_NASCIMENTO;
    lFormulario.edtEMAIL.Text := lFuncionario.EMAIL;
    lFormulario.edtSalario.value := lFuncionario.SALARIO;

    lFormulario.edtCodigo.Enabled := false;
    lFormulario.ShowModal;
    AtualizarQueryFuncionario;
  finally
    lFormulario.Free;
    lFuncionario.Free;
  end;

end;

procedure TfrmConsultaFuncionario.cbxFiltroFuncionarioChange(Sender: TObject);
begin
  case cbxFiltroFuncionario.ItemIndex of
    0:
      begin
        edtPesquisarFuncionario.NumbersOnly := true;
        edtPesquisarFuncionario.Clear;
      end;
    1:
      begin
        edtPesquisarFuncionario.NumbersOnly := false;
        edtPesquisarFuncionario.Clear;
      end;
  end;
end;

procedure TfrmConsultaFuncionario.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  edtPesquisarFuncionario.SetFocus;
  AtualizarQueryFuncionario;
end;

procedure TfrmConsultaFuncionario.ValidaSeUsuarioEstaLiberado
  (pNivelAcesso: Integer);
begin
  if pNivelAcesso < 90 then
  begin
    btnIncluir.Enabled := false;
    btnExcluir.Enabled := false;
    btnAlterar.Enabled := false;
  end;
end;

procedure TfrmConsultaFuncionario.AtualizarQueryFuncionario;
begin
  dtmConexao.qryConsultaFuncionario.close;
  dtmConexao.qryConsultaFuncionario.SQL.Clear;
  dtmConexao.qryConsultaFuncionario.SQL.add('SELECT * FROM FUNCIONARIO');
  if edtPesquisarFuncionario.Text <> emptyStr then
  begin
    case cbxFiltroFuncionario.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaFuncionario.SQL.add('WHERE CODIGO LIKE ' +
            QuotedStr('%' + edtPesquisarFuncionario.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaFuncionario.SQL.add
            ('WHERE NOME LIKE ' +
            QuotedStr('%' + edtPesquisarFuncionario.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaFuncionario.Open;

end;

procedure TfrmConsultaFuncionario.edtPesquisarFuncionarioChange
  (Sender: TObject);
begin
  AtualizarQueryFuncionario;
end;

end.
