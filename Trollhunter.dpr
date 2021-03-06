﻿program Trollhunter;

uses
  SysUtils,
  uBearLibItemsCommon in 'sources\Third-Party\BearLibItems\uBearLibItemsCommon.pas',
  uBearLibItemsDungeon in 'sources\Third-Party\BearLibItems\uBearLibItemsDungeon.pas',
  uBearLibItemsInventory in 'sources\Third-Party\BearLibItems\uBearLibItemsInventory.pas',
  BearLibTerminal in 'sources\Third-Party\BearLibTerminal\BearLibTerminal.pas',
  EnumHelper in 'sources\Third-Party\Enums\EnumHelper.pas',
  Generics.Tuples in 'sources\Third-Party\Tuples\Generics.Tuples.pas',
  Trollhunter.Types in 'Sources\Trollhunter.Types.pas',
  Trollhunter.Game in 'Sources\Trollhunter.Game.pas',
  Trollhunter.Language in 'Sources\Trollhunter.Language.pas',
  Trollhunter.Terminal in 'Sources\Trollhunter.Terminal.pas',
  Trollhunter.Scenes in 'Sources\Trollhunter.Scenes.pas',
  Trollhunter.Player in 'Sources\Trollhunter.Player.pas',
  Trollhunter.Map in 'Sources\Trollhunter.Map.pas',
  Trollhunter.Item in 'Sources\Trollhunter.Item.pas',
  Trollhunter.Mob in 'Sources\Trollhunter.Mob.pas',
  Trollhunter.UI.Log in 'Sources\Trollhunter.UI.Log.pas',
  Trollhunter.Corpse in 'Sources\Trollhunter.Corpse.pas',
  Trollhunter.Entity in 'Sources\Trollhunter.Entity.pas',
  Trollhunter.Calendar in 'Sources\Trollhunter.Calendar.pas',
  Trollhunter.Item.Shop in 'Sources\Trollhunter.Item.Shop.pas',
  Trollhunter.Player.Spellbook in 'Sources\Trollhunter.Player.Spellbook.pas',
  Trollhunter.Ability in 'Sources\Trollhunter.Ability.pas',
  Trollhunter.Player.Skills in 'Sources\Trollhunter.Player.Skills.pas',
  Trollhunter.UI.Logo in 'Sources\Trollhunter.UI.Logo.pas',
  Trollhunter.Statistic in 'sources\Trollhunter.Statistic.pas',
  Trollhunter.Item.Affixes in 'Sources\Trollhunter.Item.Affixes.pas',
  Trollhunter.Creature in 'Sources\Trollhunter.Creature.pas',
  Trollhunter.Attribute in 'Sources\Trollhunter.Attribute.pas',
  Trollhunter.UI in 'Sources\Trollhunter.UI.pas',
  Trollhunter.PathFind in 'Sources\Trollhunter.PathFind.pas',
  Trollhunter.Player.Quest in 'Sources\Trollhunter.Player.Quest.pas',
  Trollhunter.Helpers in 'Sources\Trollhunter.Helpers.pas',
  Trollhunter.Weather in 'sources\Trollhunter.Weather.pas',
  Trollhunter.Player.Races in 'sources\Trollhunter.Player.Races.pas',
  Trollhunter.Player.Classes in 'sources\Trollhunter.Player.Classes.pas',
  Trollhunter.Scene.Enchant in 'sources\Trollhunter.Scene.Enchant.pas',
  Trollhunter.Scene.Name in 'sources\Trollhunter.Scene.Name.pas',
  Trollhunter.Scene.Rest in 'sources\Trollhunter.Scene.Rest.pas',
  Trollhunter.Scene.Races in 'sources\Trollhunter.Scene.Races.pas',
  Trollhunter.Scene.Quest in 'sources\Trollhunter.Scene.Quest.pas',
  Trollhunter.Utils in 'sources\Trollhunter.Utils.pas',
  Trollhunter.Scene.Background in 'sources\Trollhunter.Scene.Background.pas',
  Trollhunter.Item.Types in 'sources\Trollhunter.Item.Types.pas',
  Trollhunter.Player.Types in 'sources\Trollhunter.Player.Types.pas',
  Trollhunter.Scene.Statistics in 'sources\Trollhunter.Scene.Statistics.pas',
  Trollhunter.Scene.Options in 'sources\Trollhunter.Scene.Options.pas',
  Trollhunter.Player.Helpers in 'sources\Trollhunter.Player.Helpers.pas',
  Trollhunter.Scene.Help in 'sources\Trollhunter.Scene.Help.pas',
  Trollhunter.Scene.Title in 'sources\Trollhunter.Scene.Title.pas',
  Trollhunter.Item.Base in 'sources\Trollhunter.Item.Base.pas',
  Trollhunter.Scene.Classes in 'sources\Trollhunter.Scene.Classes.pas',
  Trollhunter.Item.Helpers in 'sources\Trollhunter.Item.Helpers.pas',
  Trollhunter.Scene.Difficulty in 'sources\Trollhunter.Scene.Difficulty.pas',
  Trollhunter.Scene.Load in 'sources\Trollhunter.Scene.Load.pas',
  Trollhunter.Scene.Player in 'sources\Trollhunter.Scene.Player.pas',
  Trollhunter.Scene.Game in 'sources\Trollhunter.Scene.Game.pas',
  Trollhunter.Scene.Identification in 'sources\Trollhunter.Scene.Identification.pas',
  Trollhunter.Scene.Spellbook in 'sources\Trollhunter.Scene.Spellbook.pas',
  Trollhunter.Scene.Inventory in 'sources\Trollhunter.Scene.Inventory.pas',
  Trollhunter.Scene.Messages in 'sources\Trollhunter.Scene.Messages.pas',
  Trollhunter.Scene.Calendar in 'sources\Trollhunter.Scene.Calendar.pas',
  Trollhunter.Scene.Item.Amount in 'sources\Trollhunter.Scene.Item.Amount.pas',
  Trollhunter.Scene.Items in 'sources\Trollhunter.Scene.Items.pas',
  Trollhunter.Scene.Item.Drop in 'sources\Trollhunter.Scene.Item.Drop.pas',
  Trollhunter.Scene.Item.Repair in 'sources\Trollhunter.Scene.Item.Repair.pas',
  Trollhunter.Dialog in 'sources\Trollhunter.Dialog.pas',
  Trollhunter.Scene.Item.Information in 'sources\Trollhunter.Scene.Item.Information.pas',
  Trollhunter.Scene.Final in 'sources\Trollhunter.Scene.Final.pas',
  Trollhunter.Scene.Buy in 'sources\Trollhunter.Scene.Buy.pas',
  Trollhunter.Scene.Sell in 'sources\Trollhunter.Scene.Sell.pas',
  Trollhunter.Mob.Base in 'sources\Trollhunter.Mob.Base.pas',
  Trollhunter.Mob.Types in 'sources\Trollhunter.Mob.Types.pas';

var
  Key: UInt;
  IsRender: Boolean = True;

begin
  ReportMemoryLeaksOnShutdown := True;
  Randomize();
{$IFDEF FPC}
{$IFDEF Windows}
{$IFDEF DEBUG}
{$APPTYPE CONSOLE}
  Mode.Wizard := True;
  WriteLn('TROLLHUNTER [WIZARD MODE]');
{$ELSE}
{$APPTYPE GUI}
{$ENDIF}
{$ENDIF}
{$ELSE}
{$IFDEF DEBUG}
{$APPTYPE CONSOLE}
  Mode.Wizard := True;
  WriteLn('TROLLHUNTER [WIZARD MODE]');
{$ENDIF}
{$ENDIF}
  Game.LoadConfig();
  repeat
    if (Game.Timer > 0) then
    begin
      Game.Timer := Game.Timer - 1;
      if (Game.Timer = 0) then
        IsRender := True;
    end;
    if IsRender then
    begin
      Scenes.Render();
      Terminal.Refresh();
    end;
    if terminal_has_input() then
    begin
      Key := terminal_read();
      Scenes.Update(Key);
      IsRender := True;
      Continue;
    end;
    terminal_delay(10);
    IsRender := False;
  until Game.CanClose;

end.
