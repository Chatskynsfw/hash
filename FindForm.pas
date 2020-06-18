unit FindForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NumEdit: TEdit;
    SerEdit: TEdit;
    PeformBtn: TButton;
    procedure PeformBtnClick(Sender: TObject);virtual;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
   uses MainForm, UInfo;
{$R *.dfm}

procedure TForm3.PeformBtnClick(Sender: TObject);
var key : Tkey;  info : Tinfo; found : boolean;
begin
   key.number:=StrToInt(NumEdit.Text);
   key.series:=StrToInt(SerEdit.Text);
   found:=false;
   info:= HashTable.Find(key,found);
   if found then
   begin
     ShowMessage('Запись найдена');
     ShowInfo(info,Form1.FindMemo.Lines);
   end
   else
     ShowMessage('Записи с такими данными не существует');
   NumEdit.Text:='';
   SerEdit.Text:='';
   Form3.Close;
end;

end.
