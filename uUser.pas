unit uUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TfmUser = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeUSUARIO: TDBEdit;
    dbeSENHA: TDBEdit;
    dbeCODIGO: TDBEdit;
    pnRodape: TPanel;
    sbNew: TSpeedButton;
    sbRecord: TSpeedButton;
    sbCReg: TSpeedButton;
    sbDelete: TSpeedButton;
    sbLeft: TSpeedButton;
    sbClose: TSpeedButton;
    sbRight: TSpeedButton;
    Panel2: TPanel;
    cbADM: TDBCheckBox;
    cbUSER: TDBCheckBox;
    cbGUEST: TDBCheckBox;
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmUser: TfmUser;

implementation

{$R *.dfm}

procedure TfmUser.sbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
