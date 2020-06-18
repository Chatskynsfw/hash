program Project2;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  UHashTable in 'UHashTable.pas',
  UInfo in 'UInfo.pas',
  AddForm in 'AddForm.pas' {Form2},
  FindForm in 'FindForm.pas' {Form3},
  DelForm in 'DelForm.pas' {Form4},
  UHashTableGUI in 'UHashTableGUI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
