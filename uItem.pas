unit uItem;

interface

uses BearLibItems, uCommon, uMap, uPlayer;

type
  TItemType = (itCoin, itPotion, itBlade, itAxe, itSpear, itMace);

type
  TItemBase = record
    Symbol: Char;
    ItemType: TItemType;
    MaxStack: Word;
    MaxDurability: Word;
    Color: Cardinal;
    Deep: TDeepEnum;
  end;

type
  TItemEnum = (
    // All maps
    iGold, iMinHPot, iMinMPot,
    // Dark Wood
    iRustySword, iShortSword, // Blade
    iHatchet, iBattleAxe, // Axe
    iShortSpear, iSpear, // Spear
    iHeavyBranch, iSpikedCudgel, // Mace
    // Gray Cave
    iBroadSword, iLongSword, // Blade
    iMeatAxe, iFleshTearer, // Axe
    iJavelin, iFuscina, // Spear
    iWarhammer, iWarMace, // Mace
    // Deep Cave
    iMoonBlade, iSwordOfTheJackal, // Blade
    iRubyAxe, iDarkAxe, // Axe
    iWarSpear, iHarpoon, // Spear
    iFlangedMace, iWarGavel, // Mace
    // Blood Cave
    iBastardSword, iGreatSword, // Blade
    iBerserkerAxe, iMarauderAxe, // Axe
    iSilvanWhisper, iImpaler, // Spear
    iBarbarousMace, iAdeptHammer, // Mace
    // Dungeon of Doom
    iRuneSword, iTrollSlayer, // Blade
    iChopper, iDemonAxe, // Axe
    iSoulReaver, iKeeperOfEternalFlame, // Spear
    iOgreMorningStar, iBoneOfTheHigher // Mace
    );

const
  ItemBase: array [TItemEnum] of TItemBase = (
    // == All maps == //

    // Gold
    (Symbol: '$'; ItemType: itCoin; MaxStack: 1000; MaxDurability: 0;
    Color: clYellow; Deep: deDarkWood;),
    // Life Potion
    (Symbol: '!'; ItemType: itPotion; MaxStack: 10; MaxDurability: 0;
    Color: clRed; Deep: deDarkWood;),
    // Mana potion
    (Symbol: '!'; ItemType: itPotion; MaxStack: 10; MaxDurability: 0;
    Color: clBlue; Deep: deDarkWood;),

    // == Dark Wood == //

    // Rusty Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 30;
    Color: clDarkRed; Deep: deDarkWood;),
    // Short Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 35;
    Color: clWhite; Deep: deDarkWood;),
    // Hatchet
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 30;
    Color: clDarkRed; Deep: deDarkWood;),
    // Battle Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 35;
    Color: clDarkRed; Deep: deDarkWood;),
    // Short Spear
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 30;
    Color: clDarkRed; Deep: deDarkWood;),
    // Spear
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 35;
    Color: clDarkRed; Deep: deDarkWood;),
    // Heavy Branch
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 30;
    Color: clDarkRed; Deep: deDarkWood;),
    // Spiked Cudgel
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 35;
    Color: clDarkRed; Deep: deDarkWood;),

    // == Gray Cave == //

    // Broad Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 40;
    Color: clDarkRed; Deep: deGrayCave;),
    // Long Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 45;
    Color: clDarkRed; Deep: deGrayCave;),
    // Meat Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 40;
    Color: clDarkRed; Deep: deGrayCave;),
    // Flesh Tearer
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 45;
    Color: clDarkRed; Deep: deGrayCave;),
    // Javelin
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 40;
    Color: clDarkRed; Deep: deGrayCave;),
    // Fuscina
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 45;
    Color: clDarkRed; Deep: deGrayCave;),
    // Warhammer
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 40;
    Color: clDarkRed; Deep: deGrayCave;),
    // War Mace
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 45;
    Color: clDarkRed; Deep: deGrayCave;),

    // == Deep Cave == //

    // Moon Blade
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 50;
    Color: clDarkRed; Deep: deDeepCave;),
    // Sword Of The Jackal
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 55;
    Color: clDarkRed; Deep: deDeepCave;),
    // Ruby Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 50;
    Color: clDarkRed; Deep: deDeepCave;),
    // Dark Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 55;
    Color: clDarkRed; Deep: deDeepCave;),
    // War Spear
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 50;
    Color: clDarkRed; Deep: deDeepCave;),
    // Harpoon
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 55;
    Color: clDarkRed; Deep: deDeepCave;),
    // Flanged Mace
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 50;
    Color: clDarkRed; Deep: deDeepCave;),
    // War Gavel
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 55;
    Color: clDarkRed; Deep: deDeepCave;),

    // == Blood Cave == //

    // Bastard Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 60;
    Color: clDarkRed; Deep: deBloodCave;),
    // Great Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 65;
    Color: clDarkRed; Deep: deBloodCave;),
    // Berserker Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 60;
    Color: clDarkRed; Deep: deDeepCave;),
    // Marauder Axe
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 65;
    Color: clDarkRed; Deep: deBloodCave;),
    // Silvan Whisper
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 60;
    Color: clDarkRed; Deep: deBloodCave;),
    // Impaler
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 65;
    Color: clDarkRed; Deep: deBloodCave;),
    // Barbarous Mace
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 60;
    Color: clDarkRed; Deep: deBloodCave;),
    // Adept Hammer
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 65;
    Color: clDarkRed; Deep: deBloodCave;),

    // == Dungeon of Doom == //

    // Rune Sword
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 70;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Troll Slayer,
    (Symbol: '/'; ItemType: itBlade; MaxStack: 1; MaxDurability: 75;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Chopper
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 70;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Demon Axe,
    (Symbol: '('; ItemType: itAxe; MaxStack: 1; MaxDurability: 75;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Soul Reaver
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 70;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Keeper Of Eternal Flame,
    (Symbol: '|'; ItemType: itSpear; MaxStack: 1; MaxDurability: 75;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Ogre Morning Star
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 70;
    Color: clDarkRed; Deep: deDungeonOfDoom;),
    // Bone Of The Higher
    (Symbol: ')'; ItemType: itMace; MaxStack: 1; MaxDurability: 75;
    Color: clDarkRed; Deep: deDungeonOfDoom;)

    );

type
  TItems = class(TObject)
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render(AX, AY: Byte);
    procedure Add(ADeep: TDeepEnum);
    function GetName(AItem: TItemEnum): string;
  end;

var
  Items: TItems = nil;

implementation

uses Math, uTerminal, gnugettext;

{ TItems }

procedure TItems.Add(ADeep: TDeepEnum);
var
  ID, FX, FY: Byte;
  FItem: Item;
  Value: Integer;
begin
  repeat
    ID := Math.RandomRange(0, Ord(High(TItemEnum)) + 1);
    FX := Math.RandomRange(0, High(Byte));
    FY := Math.RandomRange(0, High(Byte));
  until (Map.GetTileEnum(FX, FY, ADeep) in SpawnTiles) and
    ((ItemBase[TItemEnum(ID)].MaxStack > 1) or
    (ItemBase[TItemEnum(ID)].Deep = ADeep));
  FItem.MapID := Ord(ADeep);
  FItem.ItemID := Ord(ID);
  FItem.Amount := 1;
  FItem.X := FX;
  FItem.Y := FY;
  FItem.Stack := ItemBase[TItemEnum(ID)].MaxStack;
  FItem.Durability := ItemBase[TItemEnum(ID)].MaxDurability;
  case ItemBase[TItemEnum(ID)].ItemType of
    itCoin:
      FItem.Amount := (Math.RandomRange(0, 25) + 1) * (Ord(ADeep) + 1);
    itPotion:
      FItem.Amount := (Math.RandomRange(0, 3) + 1);
  end;
  if (FItem.Stack = 1) then
  begin
    Value := ItemBase[TItemEnum(ID)].MaxDurability;
    FItem.Durability := Math.RandomRange(Value div 4, Value) + 1;
  end;
  Items_Dungeon_AppendItem(FItem);
end;

procedure TItems.Render(AX, AY: Byte);
var
  MapID, X, Y: Byte;
  I, Count: Integer;
  Color: Cardinal;
  FItem: Item;
begin
  MapID := Ord(Map.Deep);
  Count := Items_Dungeon_GetMapCount(MapID);
  for I := Count - 1 downto 0 do
  begin
    FItem := Items_Dungeon_GetMapItem(MapID, I);
    if not Map.InView(FItem.X, FItem.Y) or
      (not WizardMode and not Map.GetFOV(FItem.X, FItem.Y)) then
      Continue;
    X := FItem.X - Player.X + AX + View.Left;
    Y := FItem.Y - Player.Y + AY + View.Top;
    if not WizardMode and (GetDist(Player.X, Player.Y, FItem.X, FItem.Y) >
      Player.GetRadius) then
      Color := clFog
    else
      Color := ItemBase[TItemEnum(FItem.ItemID)].Color;
    Terminal.Print(X, Y, ItemBase[TItemEnum(FItem.ItemID)].Symbol, Color);
  end;
end;

constructor TItems.Create;
begin
  Items_Open;
end;

destructor TItems.Destroy;
begin
  Items_Close;
  inherited;
end;

// Broadsword, Hilted Sword, Longsword, Bastard Sword
// Combat Sword, War Sword, Claymore, Ebony Sword
// Rusty Iron Wood-Chopping Axe, Battle Axe,

// Phantom Axe, Dwarven Battle Axe, War Axe
// Feathered Spear, Bronze Spear, Rusted Spear
// Small Dagger, a Rusty Dagger, Flying Dagger
// Sharpened Daggers, Gemmed Dagger, Carving Knife
// Boot Knife, Target Knife, Throwing Spike
// Rapier, Sabre,

// Rusty, Chipped
// Low Quality, Medium Quality, High Quality
// Fine, Double Bladed, Enchanted
// Bronze, Iron, Steel

// Short Bow, Battle Bow, Long Bow, Elven Long Bow
// Hunter's Bow, Ranger's Bow, Elvish Longbow, Compound Bow

// Tunic, Chainmail, Platemail
// Padded clothing, Chitin armor, Bone armor, Light armor,
// Medium armor, Mail hauberk, Brigandine,
// Heavy armor, Plate armor,

function TItems.GetName(AItem: TItemEnum): string;
begin
  case AItem of
    // == All maps == //
    // Gold
    iGold:
      Result := _('Gold');
    // Health Potion
    iMinHPot:
      Result := _('Potion of health');
    // Mana Potion
    iMinMPot:
      Result := _('Potion of mana');

    // == Dark Wood == //

    // Blade
    iRustySword:
      Result := _('Rusty Sword');
    iShortSword:
      Result := _('Short Sword');
    // Axe
    iHatchet:
      Result := _('Hatchet');
    iBattleAxe:
      Result := _('Battle Axe');
    // Spear
    iShortSpear:
      Result := _('Short Spear');
    iSpear:
      Result := _('Spear');
    // Mace
    iHeavyBranch:
      Result := _('Heavy Branch');
    iSpikedCudgel:
      Result := _('Spiked Cudgel');

    // == Gray Cave == //

    // Blade
    iBroadSword:
      Result := _('Broad Sword');
    iLongSword:
      Result := _('Long Sword');
    // Axe
    iMeatAxe:
      Result := _('Meat Axe');
    iFleshTearer:
      Result := _('Flesh Tearer');
    // Spear
    iJavelin:
      Result := _('Javelin');
    iFuscina:
      Result := _('Fuscina');
    // Mace
    iWarhammer:
      Result := _('Warhammer');
    iWarMace:
      Result := _('War Mace');

    // == Deep Cave == //

    // Blade
    iMoonBlade:
      Result := _('Moon Blade');
    iSwordOfTheJackal:
      Result := _('Sword Of The Jackal');
    // Axe
    iRubyAxe:
      Result := _('Ruby Axe');
    iDarkAxe:
      Result := _('Dark Axe');
    // Spear
    iWarSpear:
      Result := _('War Spear');
    iHarpoon:
      Result := _('Harpoon');
    // Mace
    iFlangedMace:
      Result := _('Flanged Mace');
    iWarGavel:
      Result := _('War Gavel');

    // == Blood Cave == //

    // Blade
    iBastardSword:
      Result := _('Bastard Sword');
    iGreatSword:
      Result := _('Great Sword');
    // Axe
    iBerserkerAxe:
      Result := _('Berserker Axe');
    iMarauderAxe:
      Result := _('Marauder Axe');
    // Spear
    iSilvanWhisper:
      Result := _('Silvan Whisper');
    iImpaler:
      Result := _('Impaler');
    // Mace
    iBarbarousMace:
      Result := _('Barbarous Mace');
    iAdeptHammer:
      Result := _('Adept Hammer');

    // == Dungeon of Doom == //

    // Blade
    iRuneSword:
      Result := _('Rune Sword');
    iTrollSlayer:
      Result := _('Troll Slayer');
    // Axe
    iChopper:
      Result := _('Chopper');
    iDemonAxe:
      Result := _('Demon Axe');
    // Spear
    iSoulReaver:
      Result := _('Soul Reaver');
    iKeeperOfEternalFlame:
      Result := _('Keeper Of Eternal Flame');
    // Mace
    iOgreMorningStar:
      Result := _('Ogre Morning Star');
    iBoneOfTheHigher:
      Result := _('Bone Of The Higher');
  end;
end;

initialization

Items := TItems.Create;

finalization

Items.Free;
Items := nil;

end.
