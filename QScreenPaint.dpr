program QScreenPaint;

{$R *.dres}


uses
  Vcl.Forms,
  FormDefault in 'FormDefault.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.Title := 'QScreenPaint';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
