unit UHashTableGUI;

interface

uses UInfo, SysUtils,  UHashTable, Classes, StdCtrls, Vcl.ComCtrls, Windows;




  type
    THashTableGUI = class(THashTable)
      private
        FModified : boolean;
      protected
        procedure SetModified (Value : boolean);
      public
        constructor Create();
        destructor Destroy; override;
        procedure Clear; override;
        function IsEmpty: boolean;
        function Add(info : TInfo) : Boolean;  override;
        function Delete(key : TKey) : Boolean; override;
        procedure SaveToFile(FileName : string);  override;
        function LoadFromFile(FileName : string) : Boolean; override;
        function CanClose(var i : integer):Boolean;

        property Modified : boolean read FModified write SetModified;
    end;
implementation

   procedure THashTableGUI.SetModified (Value : boolean);
  begin
    FModified := value;
  end;

  constructor THashTableGUI.Create;
    var i : integer;
    begin
      inherited Create;
      FModified:= false;
    end;    destructor THashTableGUI.Destroy;    begin
      Clear;
      inherited;
    end;

    procedure THashTableGUI.Clear;
    begin
      inherited Clear;
      FModified:= true;
    end;

    function THashTableGUI.IsEmpty: boolean;
    begin
      result:= FCount = 0;
    end;

    function THashTableGUI.Add(info : TInfo) : Boolean;
    begin
      result:= inherited Add(info);
      if result then
        FModified:= true;
    end;

    function THashTableGUI.Delete(key : TKey) : Boolean;
    begin
      result:= inherited Delete(key);
      if result then
        FModified:= true;
    end;

    procedure THashTableGUI.SaveToFile(Filename: string);
    begin
      inherited SaveToFile(Filename);
      FModified:= false;
    end;

    function THashTableGUI.LoadFromFile(FileName : string) : Boolean;
    begin
      inherited LoadFromFile(Filename);
      FModified:= false;
    end;

    function THashTableGUI.CanClose(var i : integer):Boolean;
    begin
       if FModified then
       begin
         i:=messagebox(0,'Сохранить изменения','Подтверждение',3);
         result:=true;
       end
       else
         result:=false;
    end;

end.
