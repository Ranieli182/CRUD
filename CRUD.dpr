program CRUD;

uses
  Vcl.Forms,
  fMenuPrincipal in 'Forms\fMenuPrincipal.pas' {frmMenuPrincipal},
  uFuncionario in 'Classes\uFuncionario.pas',
  dConexao in 'dConexao.pas' {dtmConexao: TDataModule},
  fCadastroFuncionario in 'Forms\fCadastroFuncionario.pas' {frmCadastroFuncionario},
  fConsultaFuncionario in 'Forms\fConsultaFuncionario.pas' {frmConsultaFuncionario},
  fConsultaCidade in 'Forms\fConsultaCidade.pas' {frmConsultaCidade},
  uCidade in 'Classes\uCidade.pas',
  fCadastroCidade in 'Forms\fCadastroCidade.pas' {frmCadastroCidade};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.CreateForm(TfrmCadastroFuncionario, frmCadastroFuncionario);
  Application.CreateForm(TfrmConsultaFuncionario, frmConsultaFuncionario);
  Application.CreateForm(TfrmConsultaCidade, frmConsultaCidade);
  Application.CreateForm(TfrmCadastroCidade, frmCadastroCidade);
  Application.Run;
end.
