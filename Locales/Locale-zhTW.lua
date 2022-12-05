local L = LibStub("AceLocale-3.0"):NewLocale("PassLoot", "zhTW", false);
if not L then return end
-- L["Active Filters"] = "Active Filters"
--[==[ L["Active Filters_Desc"] = [=[Select a filter to modify, or shift-right-click to remove this filter
(Each filter must have at least one match)]=] ]==]
L["Add"] = "新增" -- Needs review
L["Add a new rule."] = "新增一個規則組" -- Needs review
-- L["Add this filter."] = "Add this filter."
-- L["Allow Multiple Confirm Popups"] = "Allow Multiple Confirm Popups"
-- L["Available Filters"] = "Available Filters"
--[==[ L["Available Filters_Desc"] = [=[Select a filter to use.
(Each filter must have at least one match)]=] ]==]
-- L["Change the exception status of this filter."] = "Change the exception status of this filter."
-- L["Checking this will disable the exclusive bit to allow multiple confirmation of loot roll popups"] = "Checking this will disable the exclusive bit to allow multiple confirmation of loot roll popups"
L["Checking this will prevent extra details from being displayed."] = "選擇該項可以阻止額外的細節資訊顯示。" -- Needs review
L["Click to select and edit this rule."] = "點擊選擇並編輯這條規則" -- Needs review
L["Default"] = "默認" -- Needs review
L["Description"] = "描述" -- Needs review
L["Description_Desc"] = [=[規則的描述
(只有按下回車後才會保存)]=] -- Needs review
-- L["Disenchant"] = "DE"
-- L["Disenchant_Desc"] = "If an enchanter is present, will roll disenchant on all loot matching this rule."
L["Down"] = "下移" -- Needs review
-- L["Enabled"] = "Enabled"
-- L["Enable / Disable this module."] = "Enable / Disable this module."
L["Enable Mod"] = "啟用插件" -- Needs review
L["Enable or disable this mod."] = "開啟或者關閉本插件" -- Needs review
-- L["Exception"] = "Exception"
-- L["EXCEPTION_PREFIX"] = "! "
-- L["General Options"] = "General Options"
L["Greed"] = "貪婪" -- Needs review
L["Ignoring %item% (%rule%)"] = "忽略 %item% (%rule%)"
-- L["Menu"] = "Menu"
-- L["Module"] = "Module"
-- L["Modules"] = "Modules"
L["Move selected rule down in priority."] = "降低選定的規則優先權" -- Needs review
L["Move selected rule up in priority."] = "提高選定的規則優先權" -- Needs review
L["Need"] = "需求" -- Needs review
-- L["No rules matched."] = "No rules matched."
-- L["Opens the PassLoot Menu."] = "Opens the PassLoot Menu."
-- L["Options"] = "Options"
-- L["Output"] = "Output"
L["Pass"] = "棄權" -- Needs review
-- L["PassLoot"] = "PassLoot"
-- L["PASSLOOT_SLASH_COMMAND"] = "passloot"
-- L["Profiles"] = "Profiles"
L["Quiet"] = "安靜" -- Needs review
L["Remove"] = "移除" -- Needs review
L["Remove selected rule."] = "移除選定的規則組" -- Needs review
-- L["Remove this filter."] = "Remove this filter."
-- L["Rolling disenchant on %item% (%rule%)"] = "Rolling disenchant on %item% (%rule%)"
-- L["Rolling greed on %item% (%rule%)"] = "Rolling greed on %item% (%rule%)"
-- L["Rolling is tried from left to right"] = "Rolling is tried from left to right"
-- L["Rolling need on %item% (%rule%)"] = "Rolling need on %item% (%rule%)"
-- L["Rolling pass on %item% (%rule%)"] = "Rolling pass on %item% (%rule%)"
L["Rule List"] = "規則列表" -- Needs review
L["Temp Description"] = "臨時描述"
-- L["Test"] = "Test"
-- L["Test an item link to see how we would roll"] = "Test an item link to see how we would roll"
L["Up"] = "上移" -- Needs review
L["Will pass on all loot matching this rule."] = "所有符合本規則的Loot都棄權" -- Needs review
L["Will roll greed on all loot matching this rule."] = "所有符合本規則的Loot都貪婪" -- Needs review
L["Will roll need on all loot matching this rule."] = "所有符合本規則的Loot都需求" -- Needs review

local LM = LibStub("AceLocale-3.0"):NewLocale("PassLoot_Modules", "zhTW", false);
-- LM["10 Man Raid"] = "10 Man Raid"
-- LM["25 Man Raid"] = "25 Man Raid"
LM["Accessories"] = "附件" -- Needs review
-- LM["Account"] = "Account"
LM["Any"] = "任何" -- Needs review
LM["Armor"] = "護甲" -- Needs review
LM["Bind On"] = "綁定於" -- Needs review
-- LM["Binds On"] = "Binds On"
-- LM["By adding the Confirm DE filter you will not get any confirmations when rolling disenchant.  This might get you into trouble with your group, are you sure?"] = "By adding the Confirm DE filter you will not get any confirmations when rolling disenchant.  This might get you into trouble with your group, are you sure?"
-- LM["%class% - %spec%"] = "%class% - %spec%"
-- LM["Class Spec"] = "Class Spec"
-- LM["Confirm BoP"] = "Confirm BoP"
-- LM["Confirm DE"] = "Confirm DE"
-- LM["Current Spec: %spec%"] = "Current Spec: %spec%"
-- LM["Equal to"] = "Equal to"
-- LM["Equal to %num%"] = "Equal to %num%"
LM["Equip"] = "裝備" -- Needs review
LM["Equip Slot"] = "裝備位置" -- Needs review
LM["Exact"] = "精確" -- Needs review
LM["Exact_Desc"] = [=[勾選: 物品必須完全符合
不選: 物品必須包含這個文字]=] -- Needs review
-- LM["Greater than"] = "Greater than"
-- LM["Greater than %num%"] = "Greater than %num%"
-- LM["Group"] = "Group"
-- LM["Group / Raid"] = "Group / Raid"
-- LM["Heroic"] = "Heroic"
-- LM["Hybrid"] = "Hybrid"
-- LM["Inventory"] = "Inventory"
-- LM["Item Level"] = "Item Level"
-- LM["Item Name"] = "Item Name"
-- LM["Item Price"] = "Item Price"
-- LM["Learned"] = "Learned"
-- LM["Learned Item"] = "Learned Item"
-- LM["Less than"] = "Less than"
-- LM["Less than %num%"] = "Less than %num%"
-- LM["level"] = "level"
-- LM["Loot Won"] = "Loot Won"
-- LM["Loot Won Comparison"] = "Loot Won Comparison"
-- LM["Loot Won Counter"] = "Loot Won Counter"
--[==[ LM["Loot Won Counter_Desc"] = [=[Set how many times we have won loot on this rule
(Saves when you press enter)]=] ]==]
LM["None"] = "無" -- Needs review
-- LM["Normal"] = "Normal"
LM["Not"] = "非" -- Needs review
-- LM["Not Equal to"] = "Not Equal to"
-- LM["Not Equal to %num%"] = "Not Equal to %num%"
-- LM["Outside"] = "Outside"
LM["Pickup"] = "拾取" -- Needs review
-- LM["Player Name"] = "Player Name"
LM["Quality"] = "品質" -- Needs review
-- LM["Raid"] = "Raid"
-- LM["Required Level"] = "Required Level"
--[==[ LM["RequiredLevel_DropDownTooltipDesc"] = [=[Selected rule will only match items when comparing the required level to this.
(Use level for your current level)]=] ]==]
-- LM["Reset Counters On Join"] = "Reset Counters On Join"
--[==[ LM["Reset Counters On Join_Desc"] = [=[Checking this will reset counters on joining a group or raid.
Shift-click to reset all current counters.]=] ]==]
-- LM["Selected rule will match on item names."] = "Selected rule will match on item names."
-- LM["Selected rule will match on player names."] = "Selected rule will match on player names."
-- LM["Selected rule will only match if you are in a group or raid."] = "Selected rule will only match if you are in a group or raid."
-- LM["Selected rule will only match items when compared to vendor value."] = "Selected rule will only match items when compared to vendor value."
-- LM["Selected rule will only match items when comparing already aquired inventory to this."] = "Selected rule will only match items when comparing already aquired inventory to this."
-- LM["Selected rule will only match items when comparing the item level to this."] = "Selected rule will only match items when comparing the item level to this."
-- LM["Selected rule will only match items when comparing the loot won counter to this."] = "Selected rule will only match items when comparing the loot won counter to this."
-- LM["Selected rule will only match items when comparing the required level to this."] = "Selected rule will only match items when comparing the required level to this."
-- LM["Selected rule will only match items when you are in this type of zone."] = "Selected rule will only match items when you are in this type of zone."
-- LM["Selected rule will only match items when you are this class and spec."] = "Selected rule will only match items when you are this class and spec."
LM["Selected rule will only match items with this equip slot."] = "選定的規則將只匹配符合這個裝備位置的物品。" -- Needs review
LM["Selected rule will only match items with this type and subtype."] = "選定的規則將只匹配符合這個類型的物品。" -- Needs review
LM["Selected rule will only match these items."] = "選定的規則將只匹配於這些物品" -- Needs review
LM["Selected rule will only match this quality of items."] = "選定的規則將只匹配符合該品質的物品" -- Needs review
-- LM["Selected rule will only match usable items."] = "Selected rule will only match usable items."
LM["Temp Item Name"] = "臨時物品名"
-- LM["Temp Name"] = "Temp Name"
-- LM["Temp Zone Name"] = "Temp Zone Name"
LM["%type% - %subtype%"] = "%type% - %subtype%" -- Needs review
LM["Type / SubType"] = "類型" -- Needs review
LM["Unique"] = "唯一" -- Needs review
LM["Unique_Desc"] = [=[選定的規則將只匹配標有唯一的物品。
這也包含了唯一數量大於1的物品，例如戰場獎章，還包括了裝備唯一的物品。]=] -- Needs review
-- LM["Unlearned"] = "Unlearned"
-- LM["Unusable"] = "Unusable"
-- LM["Usable"] = "Usable"
LM["Use"] = "使用" -- Needs review
LM["Weapons"] = "武器" -- Needs review
-- LM["Will click yes on BoP dialogues."] = "Will click yes on BoP dialogues."
-- LM["Will click yes on Disenchant dialogues."] = "Will click yes on Disenchant dialogues."
-- LM["Will confirm bind!"] = "Will confirm bind!"
-- LM["Will confirm disenchant!"] = "Will confirm disenchant!"
LM["Zone Name"] = "區域" -- Needs review
LM["Zone Name_Desc"] = [=[選定規則所匹配的區域，留空將匹配所有區域
(只有按下回車後才會保存)]=] -- Needs review
-- LM["Zone Type"] = "Zone Type"
LM["%zonetype% - %instancedifficulty%"] = "%zonetype% - %instancedifficulty%" -- Needs review

