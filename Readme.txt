но не совсем точно из процессов не скрывает.

Добавлено через 3 минуты
вот здесь такая приколюха -диспетчер открывается -но на нем ничего нет
DelphiВыделить код
procedure TForm1.Timer1Timer(Sender: TObject);
var
h,h1,h2:DWORD;
i: integer;
begin
if getasynckeystate ($49)<>0 then // нажата "I"
 raz
 else dwa;
 h:= FindWindow(nil,'Диспетчер задач Windows');
 h1:=FindWindowEx(h,0,'#32770',nil);
 h2:= FindWindowEx(h,0,'SysTabControl32',nil);
 if h1<>0 then  ShowWindow(h1, SW_HIDE);
 if h2<>0 then  ShowWindow(h2, SW_HIDE);
 
end;

Добавлено через 2 минуты
можно так - при попытке открытия диспетчера задач будет сообщение что запрещено администратором
DelphiВыделить код

   if getasynckeystate($31)<>0 then  // нажата "1"
 
    begin
 
       reg := TRegistry.Create;
 
       reg.RootKey := HKEY_CURRENT_USER;
 
       reg.OpenKey('Software', True);
 
       reg.OpenKey(, True);
 
       reg.OpenKey('Windows', True);
 
       reg.OpenKey('CurrentVersion', True);
 
       reg.OpenKey('Policies', True);
 
       reg.OpenKey('System', True);
 
       reg.WriteString('DisableTaskMgr', '1') // блокировать диспетчер задач
 
    end;
 
       if getasynckeystate($30)<>0 then   // нажата "0"
 
    begin
 
       reg := TRegistry.Create;
 
       reg.RootKey := HKEY_CURRENT_USER;
 
       reg.OpenKey('Software', True);
 
       reg.OpenKey('Microsoft', True);
 
       reg.OpenKey('Windows', True);
 
       reg.OpenKey('CurrentVersion', True);
 
       reg.OpenKey('Policies', True);
 
       reg.OpenKey('System', True);
 
       reg.WriteString('DisableTaskMgr', '0') // разблокировать диспетчер задач
 
    end;
 
end