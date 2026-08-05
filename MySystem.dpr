program MySystem;

uses
  Vcl.Forms,
  Controls,
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

  fmLogin := TfmLogin.Create(nil);
  try
    if fmLogin.ShowModal = mrOk then
    begin
      Application.CreateForm(TfmMenu, fmMenu);
      Application.Run;
    end;
  finally
    fmLogin.Free;
  end;
end.
