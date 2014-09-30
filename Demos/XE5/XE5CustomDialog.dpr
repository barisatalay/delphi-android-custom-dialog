program XE5CustomDialog;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Main in 'Units\Main.pas' {Form26};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm26, Form26);
  Application.Run;
end.
