local L = LibStub("AceLocale-3.0"):NewLocale("PassLoot", "deDE", false)
if not L then return end
L["Active Filters"] = "Aktive Filter" -- Needs review
L["Active Filters_Desc"] = [=[Wähle einen Filter aus, um ihn zu bearbeiten oder Umschalt-Rechtsklick, um ihn zu löschen.
(Jeder Filter muss mindestens ein passendes Kriterium haben)]=] -- Needs review
L["Add"] = "Hinzufügen" -- Needs review
L["Add a new rule."] = "Hinzufügen einer neuen Regel." -- Needs review
L["Add this filter."] = "Filter hinzufügen." -- Needs review
L["Allow Multiple Confirm Popups"] = "Erlaube mehrere Bestätigungsfenster"
L["Available Filters"] = "Verfügbare Filter" -- Needs review
L["Available Filters_Desc"] = [=[Filter zum Benutzen auswählen
(Jeder Filter muss mindestens ein passendes Kriterium haben)]=] -- Needs review
L["Change the exception status of this filter."] = "Ändere den Ausnahme-Status dieses Filters."
-- L["Checking this will disable the exclusive bit to allow multiple confirmation of loot roll popups"] = "Checking this will disable the exclusive bit to allow multiple confirmation of loot roll popups"
L["Checking this will prevent extra details from being displayed."] = "Weitere Details werden nicht angezeigt." -- Needs review
-- L["Clean Rules"] = "Clean Rules"
--[==[ L["CLEAN RULES DESC"] = [=[Are you sure?

It is recommended that you activate all modules used in rules.
]=] ]==]
L["Click to select and edit this rule."] = [=[Klicken, um Regel auszuwählen und zu bearbeiten.
Rechts klicken, um Regel zu kopieren oder zu exportieren.]=] -- Needs review
-- L["Create Copy"] = "Create Copy"
L["Default"] = "Standard"
L["Description"] = "Beschreibung" -- Needs review
L["Description_Desc"] = [=[Beschreibung für diese Regel
(Speichert bei Druck auf Enter)]=]
L["Disenchant"] = "DE"
-- L["Disenchant_Desc"] = "If an enchanter is present, will roll disenchant on all loot matching this rule."
L["Display a warning when a rule is skipped."] = "Zeigt eine Warnung wenn eine Regel übersprungen wird." -- Needs review
-- L["Displays disabled or unknown filter variables."] = "Displays disabled or unknown filter variables."
L["Down"] = "Abwärts" -- Needs review
L["Enabled"] = "Eingeschaltet"
L["Enable / Disable this module."] = "Aktiviere / Deaktiviere dieses Modul."
L["Enable Mod"] = "Aktiviere Mod" -- Needs review
L["Enable or disable this mod."] = "Aktiviere oder deaktiviere Mod." -- Needs review
--[==[ L["Enter the text displayed when rolling."] = [=[Enter the text displayed when rolling.
Use '%item%' for item being rolled on.
Use '%rule%' for rule that was matched.
]=] ]==]
L["Exception"] = "Ausnahme"
L["EXCEPTION_PREFIX"] = "!" -- Needs review
-- L["Export To"] = "Export To"
L["Found some rules that will be skipped."] = "Es wurden Regeln gefunden die übersprungen wurden." -- Needs review
L["General Options"] = "Hauptoptionen"
L["Greed"] = "Gier"
-- L["Ignored"] = "Ignored"
L["Ignoring %item% (%rule%)"] = "Ignoriere %item% (%rule%)"
L["Menu"] = "Menu"
L["Messages"] = "Nachrichten" -- Needs review
L["Module"] = "Modul" -- Needs review
L["Modules"] = "Module" -- Needs review
L["Move selected rule down in priority."] = "Regel in Priorität herabsetzen." -- Needs review
L["Move selected rule up in priority."] = "Regel in Priorität heraufsetzen." -- Needs review
L["Need"] = "Bedarf"
L["No rules matched."] = "Keine Regel passt."
L["Opens the PassLoot Menu."] = "Öffnet das PassLoot-Menü."
L["Options"] = "Optionen"
L["Output"] = "Ausgabe"
L["Pass"] = "Passen"
L["PassLoot"] = "PassLoot"
L["PASSLOOT_SLASH_COMMAND"] = "passloot"
L["Profiles"] = "Profile"
L["Quiet"] = "Leise"
L["Remove"] = "Entfernen" -- Needs review
-- L["Removes disabled or unknown filters from current rules."] = "Removes disabled or unknown filters from current rules."
L["Remove selected rule."] = "Entfernt die ausgewählte Regel." -- Needs review
L["Remove this filter."] = "Filter entfernen." -- Needs review
L["Rolling disenchant on %item% (%rule%)"] = "Würfel entzaubern auf %item% (%rule%)"
L["Rolling greed on %item% (%rule%)"] = "Würfel Gier auf %item% (%rule%)"
L["Rolling is tried from left to right"] = "Es wird versucht von links nach rechts zu würfeln." -- Needs review
L["Rolling need on %item% (%rule%)"] = "Würfel Bedarf auf %item% (%rule%)"
L["Rolling pass on %item% (%rule%)"] = "Passe auf %item% (%rule%)"
L["Rule List"] = "Regelliste" -- Needs review
L["Skipping %rule%"] = "Überspringe %rule%" -- Needs review
L["Skip Rules"] = "Übersprungene Regeln" -- Needs review
L["Skip rules that have disabled or unknown filters."] = "Überspringe Regeln die deaktivierte oder unbekannte Filter haben." -- Needs review
L["Skip Warning"] = "Überspringe Warnung" -- Needs review
L["Temp Description"] = "Temporäre Beschreibung"
L["Test"] = "Test"
L["Test an item link to see how we would roll"] = "Teste einen Gegenstandslink, um zu prüfen, wie gewürfelt wird."
-- L["Unable to copy rule"] = "Unable to copy rule"
L["Unknown Filters"] = "Unbekannte Filter" -- Needs review
L["Up"] = "Nach oben" -- Needs review
L["Will pass on all loot matching this rule."] = "Es wird auf jeden Gegenstand gepasst, der dieser Regel entspricht." -- Needs review
L["Will roll greed on all loot matching this rule."] = "Es wird Gier auf jeden Gegenstand gewürfelt, der dieser Regel entspricht."
L["Will roll need on all loot matching this rule."] = "Es wird Bedarf auf jeden Gegenstand gewürfelt, der dieser Regel entspricht."

local LM = LibStub("AceLocale-3.0"):NewLocale("PassLoot_Modules", "deDE", false)
LM["10 Man Raid"] = "10 Mann Schlachtzug"
LM["25 Man Raid"] = "25 Mann Schlachtzug"
LM["Accessories"] = "Zubehör" -- Needs review
LM["Account"] = "Account"
LM["Any"] = "Alles"
LM["Armor"] = "Rüstung"
LM["Bind On"] = "Gebunden beim"
LM["Binds On"] = "Bindet"
-- LM["By adding the Confirm DE filter you will not get any confirmations when rolling disenchant.  This might get you into trouble with your group, are you sure?"] = "By adding the Confirm DE filter you will not get any confirmations when rolling disenchant.  This might get you into trouble with your group, are you sure?"
LM["Can I Roll"] = "Kann ich würfeln" -- Needs review
LM["%class% - %spec%"] = "%class% - %spec%"
-- LM["Class Spec"] = "Class Spec"
LM["Confirm BoP"] = "Bestätige BoP"
LM["Confirm DE"] = "Bestätige Entzauberung"
-- LM["current"] = "current"
-- LM["Current Spec: %spec%"] = "Current Spec: %spec%"
LM["Equal to"] = "Gleich" -- Needs review
LM["Equal to %num%"] = "gleich zu %num%"
LM["Equip"] = "Anlegen" -- Needs review
LM["Equipable"] = "Ausrüstbar"
LM["Equip Slot"] = "Ausrüstungsslot"
LM["Exact"] = "Genau"
LM["Exact_Desc"] = [=[Ausgewählt: Gegenstand muss genau Passen.
Abgewählt: Gegenstand muss diesen Teil besitzen.]=]
LM["Greater than"] = "Größer als" -- Needs review
LM["Greater than %num%"] = "Größer als %num%"
LM["Group"] = "Gruppe" -- Needs review
LM["Group / Raid"] = "Gruppe / Schlachtzug"
LM["Guild Group"] = "Gildengruppe"
-- LM["Guild Group_Desc"] = "Selected rule will match when the group has this percentage of guild mates."
LM["Heroic"] = "Heroisch"
LM["Hybrid"] = "Hybrid"
LM["Inventory"] = "Inventar"
LM["Item Level"] = "Gegenstandslevel"
--[==[ LM["ItemLevel_DropDownTooltipDesc"] = [=[Selected rule will only match items when comparing the item level to this.
(use 'current' for your currently equipped item level)]=] ]==]
LM["Item Name"] = "Gegenstandsname"
LM["Item Price"] = "Gegenstandspreis"
LM["Later"] = "Später"
LM["Learned"] = "erlernt" -- Needs review
LM["Learned Item"] = "erlernter Gegenstand" -- Needs review
LM["Less than"] = "Kleiner als"
LM["Less than %num%"] = "Kleiner als %num%"
LM["level"] = "level"
LM["Loot Won"] = "Wurf gewonnen"
-- LM["Loot Won Comparison"] = "Loot Won Comparison"
LM["Loot Won Counter"] = "Anzahl gewonnener Würfe"
--[==[ LM["Loot Won Counter_Desc"] = [=[Set how many times we have won loot on this rule
(Saves when you press enter)]=] ]==]
LM["None"] = "Nichts"
LM["Normal"] = "Normal" -- Needs review
LM["Not"] = "Nicht"
LM["Not Equal to"] = "Ungleich" -- Needs review
LM["Not Equal to %num%"] = "Ungleich zu %num%"
LM["Now"] = "Jetzt"
LM["Outside"] = "Außen" -- Needs review
LM["Pickup"] = "Aufheben"
LM["Player Name"] = "Spielername"
LM["Quality"] = "Qualität"
LM["Raid"] = "Schlachtzug"
LM["Required Level"] = "Benötigtes Level"
--[==[ LM["RequiredLevel_DropDownTooltipDesc"] = [=[Selected rule will only match items when comparing the required level to this.
(Use 'level' for your current level)]=] ]==]
LM["Reset Counters On Join"] = "Resetet Zähler beim Beitreten" -- Needs review
--[==[ LM["Reset Counters On Join_Desc"] = [=[Checking this will reset counters on joining a group or raid.
Shift-click to reset all current counters.]=] ]==]
LM["Selected rule will match on item names."] = "Die ausgewählte Regel gilt nur für Gegenstände mit diesen Namen."
LM["Selected rule will match on player names."] = "Die ausgewählte Regel wird aktiv bei Spielernamen." -- Needs review
LM["Selected rule will only match if you are in a group or raid."] = "Die ausgewählte Regel gilt nur für für die aktive Gruppe oder Schlachtzug."
LM["Selected rule will only match if you can roll this."] = "Die ausgewählte Regel wird aktiv wenn man darauf würfeln kann." -- Needs review
LM["Selected rule will only match items that are equipable."] = "Die ausgewählte Regel trifft zu, wenn der Gegenstand anlegbar ist." -- Needs review
LM["Selected rule will only match items when compared to vendor value."] = "Regel trifft nur zu, wenn Händlerverkaufswert verglichen wird"
-- LM["Selected rule will only match items when comparing already aquired inventory to this."] = "Selected rule will only match items when comparing already aquired inventory to this."
LM["Selected rule will only match items when comparing the item level to this."] = "Regel trifft nur zu, wenn die Gegenstandsstufe verglichen wird"
-- LM["Selected rule will only match items when comparing the loot won counter to this."] = "Selected rule will only match items when comparing the loot won counter to this."
-- LM["Selected rule will only match items when comparing the required level to this."] = "Selected rule will only match items when comparing the required level to this."
-- LM["Selected rule will only match items when you are in this type of zone."] = "Selected rule will only match items when you are in this type of zone."
-- LM["Selected rule will only match items when you are this class and spec."] = "Selected rule will only match items when you are this class and spec."
LM["Selected rule will only match items with this equip slot."] = "Die ausgewählte Regel gilt nur für diesen Aurüstungsplatz."
-- LM["Selected rule will only match items with this type and subtype."] = "Selected rule will only match items with this type and subtype."
LM["Selected rule will only match these items."] = "Die ausgewähle Regel gilt nur für diese Items."
-- LM["Selected rule will only match this quality of items."] = "Selected rule will only match this quality of items."
-- LM["Selected rule will only match usable items."] = "Selected rule will only match usable items."
LM["Temp Item Name"] = "Temporärer Gegenstandsname"
LM["Temp Name"] = "Temp Name" -- Needs review
LM["Temp Zone Name"] = "Temporärer Zonenname"
LM["%type% - %subtype%"] = "%type% - %subtype%"
LM["Type / SubType"] = "Gegenstandstyp / Untertyp" -- Needs review
LM["Unique"] = "Einzigartig"
--[==[ LM["Unique_Desc"] = [=[Selected rule will only match items that are unique.
This includes items which have a unique stack higher than 1, such as battleground tokens, as well as items which are Unique-Equip.]=] ]==]
LM["Unlearned"] = "erlerntbar" -- Needs review
LM["Unusable"] = "Unbenutzbar"
LM["Usable"] = "Benutzbar"
LM["Use"] = "Benutzen"
LM["Use RegEx for partial"] = "Benutze RegEx für Teilangaben" -- Needs review
-- LM["Uses regular expressions when using partial matches."] = "Uses regular expressions when using partial matches."
LM["Weapons"] = "Waffen"
LM["Will click yes on BoP dialogues."] = "Auto-Klick auf 'Ja' bei BoP-Dialogen" -- Needs review
LM["Will click yes on Disenchant dialogues."] = "Auto-Klick auf 'Ja' bei Entzaubern-Dialogen." -- Needs review
-- LM["Will confirm bind!"] = "Will confirm bind!"
-- LM["Will confirm disenchant!"] = "Will confirm disenchant!"
LM["Zone Name"] = "Zonenname"
--[==[ LM["Zone Name_Desc"] = [=[Zone name to match selected rule to, leave empty to match any zone.
(Saves when you press enter)
Shift-right-click to fill with current zone name]=] ]==]
LM["Zone Type"] = "Zonentyp"
LM["%zonetype% - %instancedifficulty%"] = "%zonetype% - %instancedifficulty%"

