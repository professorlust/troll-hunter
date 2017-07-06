unit uShop;

interface

uses
  BeaRLibItems, uPlayer, uItem;

type
  TShopEnum = (shPotions, shScrolls, shHealer, shMana, shSmith, shArmors,
    shWeapons, shFoods, shTavern, shShields, shHelms);

type
  TItemsStore = array [0 .. ItemMax - 1] of Item;

type
  TShop = class
  private
    FItemsStore: TItemsStore;
    FCount: Byte;
  public
    constructor Create;
    procedure Clear;
    property Count: Byte read FCount;
    procedure Add(const AItem: Item);
    function GetItem(const Index: Byte): Item;
  end;

type
  TShops = class
    FCurrent: TShopEnum;
    FShop: array [TShopEnum] of TShop;
    function GetShop(I: TShopEnum): TShop;
    procedure SetShop(I: TShopEnum; const Value: TShop);
  public
    constructor Create;
    destructor Destroy; override;
    procedure New;
    procedure Clear;
    procedure Render;
    function Count: Byte;
    property Current: TShopEnum read FCurrent write FCurrent;
    property Shop[I: TShopEnum]: TShop read GetShop write SetShop;
  end;

var
  Shops: TShops;

implementation

uses
  SysUtils, Math, uMap;

const
  ManaPotionsItems = [iPotionOfMana1, iPotionOfMana2, iPotionOfMana3,
    iPotionOfFullMana];
  HealItems = [iPotionOfHealing1, iPotionOfHealing2, iPotionOfHealing3,
    iPotionOfFullHealing, iPotionOfRejuvenation1, iPotionOfRejuvenation2,
    iPotionOfRejuvenation3, iPotionOfFullRejuvenation, iScrollOfHealing1,
    iScrollOfHealing2, iScrollOfHealing3, iScrollOfFullHealing];
  TavernItems = [iKey, iScrollOfHunger];

  { TShop }

procedure TShop.Add(const AItem: Item);
begin
  FItemsStore[FCount] := AItem;
  Inc(FCount);
end;

procedure TShop.Clear;
var
  I: Byte;
begin
  for I := Low(FItemsStore) to High(FItemsStore) do
    Items_Clear_Item(FItemsStore[I]);
  FCount := 0;
end;

constructor TShop.Create;
begin
  Self.Clear;
end;

function TShop.GetItem(const Index: Byte): Item;
begin
  Result := FItemsStore[EnsureRange(Index, 0, ItemMax)];
end;

{ TShops }

procedure TShops.Clear;
var
  Shop: TShopEnum;
begin
  for Shop := Low(TShopEnum) to High(TShopEnum) do
    FShop[Shop].Clear;
end;

function TShops.Count: Byte;
begin
  Result := Length(FShop);
end;

constructor TShops.Create;
var
  Shop: TShopEnum;
begin
  for Shop := Low(TShopEnum) to High(TShopEnum) do
    FShop[Shop] := TShop.Create;
end;

destructor TShops.Destroy;
var
  Shop: TShopEnum;
begin
  for Shop := Low(TShopEnum) to High(TShopEnum) do
    FreeAndNil(FShop[Shop]);
  inherited;
end;

function TShops.GetShop(I: TShopEnum): TShop;
begin
  Result := FShop[I];
end;

procedure TShops.New;
var
  FItem: Item;
  I, Max: Byte;
  ID: TItemEnum;
  Shop: TShopEnum;

  function GetItemID(): TItemEnum;
  begin
    Result := TItemEnum(Math.RandomRange(Ord(Low(TItemEnum)),
      Ord(High(TItemEnum)) + 1));
  end;

  function Check: Boolean;
  begin
    ID := GetItemID();
    case Shop of
      shTavern:
        Result := ID in TavernItems;
      shHealer:
        Result := ID in HealItems;
      shMana:
        Result := ID in ManaPotionsItems;
      shPotions:
        Result := ItemBase[ID].ItemType in PotionTypeItems;
      shScrolls:
        Result := ItemBase[ID].ItemType in ScrollTypeItems;
      shArmors:
        Result := ItemBase[ID].ItemType in ArmorTypeItems;
      shHelms:
        Result := ItemBase[ID].ItemType in HelmTypeItems;
      shShields:
        Result := ItemBase[ID].ItemType in ShieldTypeItems;
      shWeapons:
        Result := ItemBase[ID].ItemType in WeaponTypeItems;
      shSmith:
        Result := ItemBase[ID].ItemType in SmithTypeItems;
      shFoods:
        Result := ItemBase[ID].ItemType in FoodTypeItems;
    else
      Result := False;
    end;
  end;

begin
  for Shop := Low(TShopEnum) to High(TShopEnum) do
  begin
    Shops.Shop[Shop].Clear;
    Max := EnsureRange(Player.Level * 4, 4, ItemMax);
    for I := 0 to Max - 1 do
    begin
      repeat
        repeat
        until Check;
      until (TMapEnum(Player.MaxMap) in ItemBase[TItemEnum(ID)].Deep);
      Items.Make(Ord(ID), FItem);
      Shops.Shop[Shop].Add(FItem);
    end;
  end;
end;

procedure TShops.Render;
var
  I, C: Integer;
begin
  C := EnsureRange(Shops.Shop[Shops.Current].Count, 0, ItemMax);
  for I := 0 to C - 1 do
    Items.RenderInvItem(5, 2, I, Shops.Shop[Shops.Current].GetItem(I), True,
      True, ptBuy);
end;

procedure TShops.SetShop(I: TShopEnum; const Value: TShop);
begin
  FShop[I] := Value;
end;

initialization

Shops := TShops.Create;
Shops.Current := shPotions;

finalization

FreeAndNil(Shops);

end.