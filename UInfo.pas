unit UInfo;
interface

uses System.Sysutils, Classes;

 type

   TKey = record
     number,series : integer;
   end;

   TAdress = record
     house : integer;
     street : string;
   end;

   TInfo = record
     key : TKey;
     FIO : string;
     Adress : TAdress;
   end;

 function IsEqualKey (k1, k2 : TKey) : boolean;
 procedure AddToFile(var f : TextFile; info: TInfo);
 function GetFromFile(var f : TextFile; var info : TInfo) : boolean;
 procedure ShowInfo(info : TInfo; Row : TStrings);
 Function HF(key:TKey):integer;

implementation

   function IsEqualKey(k1, k2 : TKey)  : boolean;
   begin
     result:= (k1.number = k2.number) and (k1.series = k2.series);
   end;

   procedure AddToFile(var f : TextFile; info: TInfo);
   begin
     writeln(f,info.key.number,' ',info.key.series);
     writeln(f,info.FIO);
     writeln(f,info.Adress.house,' ',info.Adress.street);
   end;

   function GetFromFile(var f : TextFile; var info : TInfo) : boolean;
   var c:char;
   begin
     readln(f,info.key.number,info.key.series);
     readln(f,info.FIO);
     readln(f,info.adress.house,c,info.adress.street);
     result:= (info.key.number<>0) and (info.key.series<>0) and (info.FIO<>'') and (info.adress.street<>'') and (info.adress.house<>0);
   end;

   Function HF(key:TKey):integer;
   var i:integer; str:string;
   begin
     result:=0;
     str:=IntToStr(key.number+key.series);
     for i := 1 to length(str) do
       result:=result + ord(str[i])*i;
   end;

   procedure ShowInfo(info : TInfo; Row : TStrings);
   begin
     with info do
     begin
       Row.Add('Паспортные данные: '+IntToStr(Key.number)+' '+IntToStr(Key.series));
       Row.Add('ФИО: '+FIO);
       Row.Add('Адрес: улица '+Adress.street+' дом '+IntToStr(adress.house));
       Row.Add('');
     end;
   end;

end.