unit UHashTable;

interface

uses UInfo, SysUtils, Classes;

const
 N = 101;

type

 TCellState = (csFree, csFull, csDel);

 TIndex = 0..N-1;

 TCell = record
   info : TInfo;
   state : TCellState;
 end;

 TTable = array[TIndex] of TCell;

 THashTable = class(TObject)
   private
     FTable : TTable;
     FC, FD: integer;
   protected
     FCount : integer;
     function HashF(key : TKey) : TIndex;
     function NextCell (a0 : TIndex; var i : integer) : TIndex;
     function IndexOf(key : TKey; var a : integer) : boolean;
   public
     constructor Create(c:integer=1;d:integer=0);
     destructor Destroy; override;
     procedure Clear; virtual;
     function Add(info : TInfo) : Boolean;  virtual;
     function Delete(key : TKey) : Boolean;  virtual;
     function Find(key: TKey; var found: Boolean): TInfo;
     procedure View(strings : Tstrings);
     procedure SaveToFile(FileName : string); virtual;
     function LoadFromFile(FileName : string) : Boolean; virtual;

     property Count : Integer read FCount;
 end;


  implementation
var hash : THash;
    constructor THashTable.Create;
    var i : integer;
    begin
      inherited Create;
      FCount := 0;
      for i := 0 to N-1 do
        FTable[i].state := csFree;
      FC:= c;
      FD:= d;
    end;

    destructor THashTable.Destroy;
    begin
      Clear;
      inherited;
    end;

    function THashTable.HashF(key: TKey): TIndex;
    begin
      Result := hash.HF(key) mod N;
    end;

    function THashTable.NextCell(a0 : TIndex; var i : integer) : TIndex;
    begin
      Inc(i);
      Result := (a0 + FC * i + FD*i*i) mod N;
    end;

    function THashTable.IndexOf(key : TKey; var a : integer) : boolean;
    var a0 : TIndex; i: Integer; Stop : Boolean; d: Integer;
    begin
      a0 := HashF(key);
      i := 0;
      d := -1;
      Result := False;
      Stop := false;
      a := a0;
      repeat
        case FTable[a].state of
          csFree : Stop := True;
          csDel : begin
                    if d = -1 then
                    d := a;
                    a := NextCell(a0, i);
                  end;
          csFull: if hash.IsEqualKey(key, FTable[a].info.key) then
                    Result := true
                  else
                    a := NextCell(a0, i);
        end;
      until Result or Stop or (i = N);
      if not Result and (d <> -1) then
        a := d;
    end;

    function THashTable.Add(info: TInfo): Boolean;
    var a : integer;
    begin
      result := (FCount < N) and not IndexOf(info.key, a) and (FTable[a].state <> csFull);
      if Result then
      begin
        FTable[a].info := info;
        FTable[a].state := csFull;
        Inc(FCount)
      end;
    end;

    function THashTable.Delete(key: TKey): Boolean;
    var
      a : integer;
    begin
      Result := (FCount > 0) and IndexOf(key,a);
      if Result then
      begin
        FTable[a].state := csDel;
        Dec(FCount);
      end;
    end;

    function THashTable.Find(key: TKey; var found: Boolean): TInfo;
    var
      a : Integer;
    begin
      found := (FCount > 0) and IndexOf(key,a);
      if found then
        result := FTable[a].info;
    end;

    procedure THashTable.View(strings : TStrings);
    var
      i : integer;
    begin
      for i := 0 to N - 1 do
        if FTable[i].state = csFull then
          hash.ShowInfo(FTable[i].info,strings);
    end;

    function THashTable.LoadFromFile(FileName: string): Boolean;
    var
      f : TextFile;
      info : TInfo;
    begin
      Result := true;
      AssignFile(f, FileName);
      Clear;
      Reset(f);
      while not Eof(f) and Result do
        if hash.GetFromFile(f, info) then
          Result := Add(info)
        else
          Result := False;
      CloseFile(f);
      if not Result then
        Clear;
    end;

    procedure THashTable.SaveToFile(FileName: string);
    var
      f : TextFile;
      i : Integer;
    begin
      AssignFile(f, FileName);
      Rewrite(f);
      if FCount>0 then
        for i:= 0 to N-1 do
          if FTable[i].state = csFull then
            hash.AddToFile(f, FTable[i].info);
      CloseFile(f);
    end;

    procedure THashTable.Clear;
    var
      i : integer;
    begin
      for i:= 0 to N-1 do
        FTable[i].state := csFree;
       FCount := 0;
    end;

end.
