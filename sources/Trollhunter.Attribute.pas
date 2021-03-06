﻿unit Trollhunter.Attribute;

interface

uses
  Trollhunter.Types;

const
  AttribMax = 100;

type
  TAttribEnum = (atDef, atMinDamage, atMaxDamage, atPV, atDV, atStr, atDex, atWil, atPer, atLife, atMana, atMaxLife, atMaxMana, atExtraGold, atVision,
    atSat, atLev, atReLife, atReMana, atLifeAfEachKill, atManaAfEachKill, atExp, atSkillpoint, atMaxMap);

const
  AttrLow = atReLife;
  AttrHigh = atManaAfEachKill;

type
  TAttrib = record
    Value: UInt;
    Prm: UInt;
  end;

type
  TAttribArray<T> = array [TAttribEnum] of T;

type
  TBaseAttribArray<T> = array [atStr .. atMana] of T;

type
  TAttributes = class(TObject)
  private
    FAttrib: TAttribArray<TAttrib>;
    function GetAttrib(I: TAttribEnum): TAttrib;
    procedure SetAttrib(I: TAttribEnum; const Value: TAttrib);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Attrib[I: TAttribEnum]: TAttrib read GetAttrib write SetAttrib;
    procedure Modify(const I: TAttribEnum; const AValue: Int = 1; const APrm: Int = 0);
    procedure SetValue(const I: TAttribEnum; const AValue: Int); overload;
    procedure SetPrm(const I: TAttribEnum; const APrm: Int);
    procedure SetValue(const I, J: TAttribEnum); overload;
  end;

implementation

uses
  Trollhunter.Helpers;

{ TAttributes }

procedure TAttributes.Clear;
var
  I: TAttribEnum;
begin
  for I := Low(FAttrib) to High(FAttrib) do
  begin
    FAttrib[I].Value := 0;
    FAttrib[I].Prm := 0;
  end;
end;

constructor TAttributes.Create;
begin
  Self.Clear;
end;

destructor TAttributes.Destroy;
begin

  inherited;
end;

function TAttributes.GetAttrib(I: TAttribEnum): TAttrib;
begin
  Result := FAttrib[I];
end;

procedure TAttributes.Modify(const I: TAttribEnum; const AValue, APrm: Int);
var
  V: Int;
begin
  V := FAttrib[I].Value + AValue;
  if (V < 0) then
    V := 0;
  FAttrib[I].Value := V;
  FAttrib[I].Prm := FAttrib[I].Prm + APrm;
  case I of
    atLife:
      SetValue(I, FAttrib[I].Value.InRange(FAttrib[atMaxLife].Value));
    atMana:
      SetValue(I, FAttrib[I].Value.InRange(FAttrib[atMaxMana].Value));
  end;
end;

procedure TAttributes.SetAttrib(I: TAttribEnum; const Value: TAttrib);
begin
  FAttrib[I] := Value;
end;

procedure TAttributes.SetPrm(const I: TAttribEnum; const APrm: Int);
begin
  FAttrib[I].Prm := APrm;
end;

procedure TAttributes.SetValue(const I, J: TAttribEnum);
begin
  FAttrib[I].Value := FAttrib[J].Value;
end;

procedure TAttributes.SetValue(const I: TAttribEnum; const AValue: Int);
begin
  FAttrib[I].Value := AValue;
end;

end.
