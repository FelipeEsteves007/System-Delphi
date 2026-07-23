unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TfmMenu = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure sbCloseClick(Sender: TObject);
    procedure sbCRegClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMenu: TfmMenu;

implementation

{$R *.dfm}

uses uTables;

procedure TfmMenu.sbCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmMenu.sbCRegClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmMenu.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
