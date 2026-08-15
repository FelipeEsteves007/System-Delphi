program MySystem;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {fmLogin},
  uTables in 'uTables.pas' {Tables: TDataModule},
  uUser in 'uUser.pas' {fmUser},
  uPassword in 'uPassword.pas' {fmPassword},
  uMenu in 'uMenu.pas' {fmMenu},
  uUseful in 'uUseful.pas',
  uCustomer in 'uCustomer.pas' {fmCustomer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTables, Tables);
  Application.CreateForm(TfmLogin, fmLogin);
  Application.Run;
end.
