unit FormDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.ComCtrls, Vcl.ActnMan, Vcl.ActnColorMaps, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    ColorBox1: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
  private
  function Screens:integer;
  function TrayMessage (Messag, Texts: string):string;
  procedure hot_key(var Message: TMessage); message WM_HOTKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1:TForm1;
  StartX, StartY : integer;
  PensilTol:integer;
  OneZ, rightMouse:boolean;
  MyCursor: TCursor;

implementation

{$R *.dfm}
{$R *.res}
{$R FormDefault.res}
{$R 'QScreenPaint.res'}   // Подключаем ресурс с курсором

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.Left:=0;
Form1.Top:=0;
Form1.Width:=Screen.Width;
Form1.Height:=Screen.Height;
Image1.Width:=Screen.Width;
Image1.Height:=Screen.Height;
Form1.FormStyle:=fsStayOnTop;
Form1.WindowState:=wsMaximized;
//MyCursor:=LoadCursor(HInstance, 'Pensil');
//Image1.Cursor:=LoadCursor(HInstance, 'Pensil');
//Screens;
TrayIcon1.visible:=true;
//Убираем с панели задач
ShowWindow(Handle,SW_HIDE);  // Скрываем программу
ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
SetWindowLong(Application.Handle, GWL_EXSTYLE,
GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
OneZ:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
UnRegisterHotKey(Handle, 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//RegisterHotKey(Handle, 0, MOD_CONTROL, $41); // для команды Ctrl+A
RegisterHotKey(Handle, 0, MOD_SHIFT, VK_OEM_3); // для команды Shift+~ (Shift+Ё)
PensilTol:=4;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
TrayIcon1.Visible:=False;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
ShowWindow(Application.Handle, SW_HIDE);
//Form1.AlphaBlend:=True;
//Form1.AlphaBlendValue:=100;
end;

procedure TForm1.hot_key(var Message: TMessage);
begin
if OneZ=true then
begin
OneZ:=false;
rightMouse:=false;
Screens;
TrayIcon1.Visible:=False;
//TrayIcon1.ShowBalloonHint;
ShowWindow(Handle,SW_RESTORE);
Panel1.Visible:=false;
Form1.Left:=0;
Form1.Top:=0;
Form1.Width:=Screen.Width;
Form1.Height:=Screen.Height;
Image1.Width:=Screen.Width;
Image1.Height:=Screen.Height;
Form1.FormStyle:=fsStayOnTop;
Form1.WindowState:=wsMaximized;
SetForegroundWindow(Handle);
end
  else
  begin
    // rightMouse:=true;
    TrayIcon1.visible:=true;
      //Убираем с панели задач
    ShowWindow(Handle,SW_HIDE);  // Скрываем программу
    ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
    SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
    OneZ:=true;
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (ssRight in Shift) then
Begin
if rightMouse=false then begin
rightMouse:=true;
Label3.Caption:=InttoStr(TrackBar1.Position);
Panel1.Left:=x;
Panel1.Top:=y;
Panel1.Width:=203;
Panel1.Height:=63;
Panel1.Visible:=true;
end
else
begin
rightMouse:=false;
Panel1.Visible:=false;
end;
End
else
begin
rightMouse:=false;
Panel1.Visible:=false;
StartX := X;
StartY := Y;
image1.Canvas.MoveTo(x,y);
Image1.Canvas.Pen.Width:=PensilTol;
Image1.Canvas.Pen.Color:=ColorBox1.Selected;
end;
end;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
//

end;

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
//

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if not (ssLeft in Shift) then
Exit;
Image1.Canvas.Pen.Color:=ColorBox1.Selected;
Image1.Canvas.Pen.Width:=PensilTol;
Image1.Canvas.MoveTo (StartX, StartY);
Image1.Canvas.LineTo(x,y);
StartX := X;
StartY := Y;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TForm1.N1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
OneZ:=false;
Screens;
TrayIcon1.Visible:=False;
//TrayIcon1.ShowBalloonHint;
ShowWindow(Handle,SW_RESTORE);
rightMouse:=false;
Panel1.Visible:=false;
Form1.Left:=0;
Form1.Top:=0;
Form1.Width:=Screen.Width;
Form1.Height:=Screen.Height;
Image1.Width:=Screen.Width;
Image1.Height:=Screen.Height;
Form1.FormStyle:=fsStayOnTop;
Form1.WindowState:=wsMaximized;
SetForegroundWindow(Handle);
end;

function TForm1.Screens: integer;
Var
  BMP1: TBitmap;
  DC:HDC;
  Image:TImage;
begin
BMP1:=TBitmap.Create;
BMP1.Width:=Screen.Width;
BMP1.Height:=Screen.Height;
DC:=GetDC(0);
BitBlt(BMP1.Canvas.Handle,0,0,Screen.Width,Screen.Height,DC,0,0,SRCCOPY);
Form1.Visible:=true;
Image:=TImage.Create(nil);
BMP1.IgnorePalette:=true;
Image.Picture.Assign(BMP1);
BMP1.SaveToFile(ExtractFilePath(Application.ExeName)+'screen.bmp');
Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'screen.bmp');
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
//Close;
TrayIcon1.visible:=true;
//Убираем с панели задач
ShowWindow(Handle,SW_HIDE);  // Скрываем программу
ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
SetWindowLong(Application.Handle, GWL_EXSTYLE,
GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
OneZ:=true;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
Label3.Caption:=InttoStr(TrackBar1.Position);
PensilTol:=TrackBar1.Position;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
if OneZ=false then
begin
TrayIcon1.Visible:=False;
//TrayIcon1.ShowBalloonHint;
ShowWindow(Handle,SW_RESTORE);
rightMouse:=false;
Panel1.Visible:=false;
Form1.Left:=0;
Form1.Top:=0;
Form1.Width:=Screen.Width;
Form1.Height:=Screen.Height;
Image1.Width:=Screen.Width;
Image1.Height:=Screen.Height;
Form1.FormStyle:=fsStayOnTop;
Form1.WindowState:=wsMaximized;
SetForegroundWindow(Handle);
OneZ:=true;
end else
Begin
Screens;
TrayIcon1.Visible:=False;
//TrayIcon1.ShowBalloonHint;
ShowWindow(Handle,SW_RESTORE);
rightMouse:=false;
Panel1.Visible:=false;
Form1.Left:=0;
Form1.Top:=0;
Form1.Width:=Screen.Width;
Form1.Height:=Screen.Height;
Image1.Width:=Screen.Width;
Image1.Height:=Screen.Height;
Form1.FormStyle:=fsStayOnTop;
Form1.WindowState:=wsMaximized;
SetForegroundWindow(Handle);
OneZ:=false;
End;
end;


function TForm1.TrayMessage(Messag, Texts: string): string;
begin
TrayIcon1.visible:=true; // делаем значок в трее видимым
trayicon1.balloontitle:=(Messag);
trayicon1.balloonhint:=(Texts);
trayicon1.showballoonHint;// показываем наше уведомление
end;

end.
