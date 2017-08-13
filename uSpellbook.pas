unit uSpellbook;

interface

uses uPlayer;

type
  TSpellEnum = (spHeal, spTownPortal, spCurePoison, spTeleportation, spMagicEye);

type
  TSpellBase = record
    Level: Byte;
    Effects: TEffects;
    Value: Word;
    ManaCost: Byte;
    Price: Word;
  end;

const
  SpellBase: array [TSpellEnum] of TSpellBase = (
  // Heal
  (Level: 1; Effects:[efHeal]; Value: 100; ManaCost: 20; Price: 200;),
  // Town Portal
  (Level: 2; Effects:[efTownPortal]; Value: 0; ManaCost: 24; Price: 500;),
  // Cure Poison
  (Level: 2; Effects:[efCurePoison]; Value: 0; ManaCost: 30; Price: 600;),
  // Teleportation
  (Level: 3; Effects:[efTeleportation]; Value: 7; ManaCost: 40; Price: 750;),
  // Magic Eye
  (Level: 3; Effects:[efMagicEye]; Value: 20; ManaCost: 50; Price: 900;)
  );

type
  TSpell = record
    Enable: Boolean;
    Spell: TSpellBase;
  end;

type
  TSpellbook = class(TObject)
  private
    FSpell: array[TSpellEnum] of TSpell;
  public
    procedure Clear;
    function GetSpellName(ASpellEnum: TSpellEnum): string;
    procedure AddSpell(ASpellEnum: TSpellEnum);
    function GetSpell(ASpellEnum: TSpellEnum): TSpell;
    procedure Start;
    procedure DoSpell(Index: Byte);
  end;

var
  Spellbook: TSpellbook = nil;

implementation

uses Math, SysUtils, GNUGetText, uGame, uMsgLog;

{ TSpellbook }

procedure TSpellbook.AddSpell(ASpellEnum: TSpellEnum);
begin
  FSpell[ASpellEnum].Enable := True;
end;

procedure TSpellbook.Clear;
var
  I: TSpellEnum;
begin
  for I := Low(TSpellEnum) to High(TSpellEnum) do
    FSpell[I].Enable := True;
end;

procedure TSpellbook.DoSpell(Index: Byte);
var
  C: Byte;
  I: TSpellEnum;
begin
  C := 0;
  for I := Low(TSpellEnum) to High(TSpellEnum) do
    if FSpell[I].Enable then
    begin
      if (Index = C) then
      begin
        if (Player.Mana >= FSpell[I].Spell.ManaCost) then
        begin
          Player.SpCast := Player.SpCast + 1;
          Player.Mana := Player.Mana - FSpell[I].Spell.ManaCost;
          Player.DoEffects(FSpell[I].Spell.Effects, FSpell[I].Spell.Value);
        end else begin
          MsgLog.Add(_('You need more mana!'));
          Player.Calc;
          Player.Wait;
        end;
        Exit;
      end;
      Inc(C);
    end;
end;

function TSpellbook.GetSpell(ASpellEnum: TSpellEnum): TSpell;
begin
  Result := FSpell[ASpellEnum];
end;

function TSpellbook.GetSpellName(ASpellEnum: TSpellEnum): string;
begin
  case ASpellEnum of
    spHeal:
      Result := _('Heal');
    spTownPortal:
      Result := _('Town portal');
    spCurePoison:
      Result := _('Cure poison');
    spTeleportation:
      Result := _('Teleportation');
    spMagicEye:
      Result := _('Magic eye');
  end;
end;

procedure TSpellbook.Start;
var
  I: TSpellEnum;
begin
  Self.Clear;
  for I := Low(TSpellEnum) to High(TSpellEnum) do
  with FSpell[I].Spell do
  begin
    Level := SpellBase[I].Level;
    Effects := SpellBase[I].Effects;
    Value := SpellBase[I].Value;
    ManaCost := SpellBase[I].ManaCost;
    Price := SpellBase[I].Price;
  end;
end;

initialization

Spellbook := TSpellbook.Create;

finalization

FreeAndNil(Spellbook);

end.