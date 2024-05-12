local VERSION = "1.0"
PassLoot = LibStub("AceAddon-3.0"):NewAddon("PassLoot", "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0", "LibSink-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("PassLoot")
local LDB = LibStub:GetLibrary("LibDataBroker-1.1")
-- local LDBIcon = LibStub("LibDBIcon-1.0")
local AceTimer = LibStub('AceTimer-3.0')
function AceTimer:delay_rollOnLoot(RollID, RollMethod) RollOnLoot(RollID, RollMethod) end

local defaults = {
	["profile"] = {
		["Quiet"] = false,
		["AllowMultipleConfirmPopups"] = false,
		["Rules"] = {},
		["Modules"] = {},
		["SinkOptions"] = {},
		["SkipRules"] = false,
		["SkipWarning"] = true,
		["DisplayUnknownVars"] = true,
		["CacheExpires"] = 900,
		["MessageText"] = {
			["need"] = L["Rolling need on %item% (%rule%)"],
			["greed"] = L["Rolling greed on %item% (%rule%)"],
			["de"] = L["Rolling disenchant on %item% (%rule%)"],
			["pass"] = L["Rolling pass on %item% (%rule%)"],
			["ignore"] = L["Ignoring %item% (%rule%)"],
		},
	},
}

local function handleMouseover(cmdname)
	local name, link = GameTooltip:GetItem()
	if GameTooltip:IsShown() and link then
		if cmdname == "IDRule" then
			local item = PassLoot:InitItem(link)
			return tostring(item.id)
		else
			return name:lower()
		end
	end
	PassLoot:Pour("No valid item tooltip found.")
end

local function dupcheck(a, b)
	if #a == 2 then
		for i = 1, #a do
			if (a[i][2] == "Exact") and a[i][1]:lower() == b then return true end
		end
	else
		for i = 1, #a do
			if a[i][1] == b then return true end
		end
	end
	return false
end

local function slash_feedback(flag, idx, command)
	PassLoot:Pour("Completed: " ..
		flag .. " '" .. command .. "' to rule #" .. idx .. " '" .. PassLoot.db.profile.Rules[idx].Desc .. "'")
end

local function compare_name(a, b)
	local atest = a[1]:lower()
	local btext = b[1]:lower()
	return (atest < btext) or (atest == btext and a[2] < b[2])
end

local function compare_id(a, b)
	return a[1]:lower() < b[1]:lower()
end

local function handleAddRemove(value, cmdname, dbkey, example)
	local idx, flag, command = value:match("(%d-) (%S*) (.*)")
	if command and idx and flag then
		flag = flag:lower()
		idx = tonumber(idx)
	end
	if not command or not idx or (flag ~= "add" and flag ~= "remove") or not PassLoot.db.profile.Rules[idx] then
		PassLoot:Pour(
			"This command requires a valid Rule Number, the operation 'add' or 'remove', and either the value to add or 'mouseover' to use the current tooltip.")
		PassLoot:Pour("Example: /PassLoot " .. cmdname .. " 1 add " .. example)
		PassLoot:Pour("Example: /PassLoot " .. cmdname .. " 1 remove mouseover")
		return
	end
	if command == "mouseover" then
		command = handleMouseover(cmdname)
	end
	if command then
		if flag == "add" then
			PassLoot.db.profile.Rules[idx][dbkey] = PassLoot.db.profile.Rules[idx][dbkey] or {}
			-- check if already in rule
			if not dupcheck(PassLoot.db.profile.Rules[idx][dbkey], command) then
				if cmdname == "IDRule" then
					table.insert(PassLoot.db.profile.Rules[idx][dbkey], { command, false })
					if PassLoot.db.profile.Rules[idx][dbkey]["ItemIDs"] then
						table.sort(PassLoot.db.profile.Rules[idx][dbkey]["ItemIDs"], compare_id)
					end
				else
					table.insert(PassLoot.db.profile.Rules[idx][dbkey], { command, "Exact", false })
					if PassLoot.db.profile.Rules[idx][dbkey]["Items"] then
						table.sort(PassLoot.db.profile.Rules[idx][dbkey]["Items"], compare_name)
					end
				end
				slash_feedback(flag, idx, command)
			else
				PassLoot:Pour("Item already present in Rule, skipping.")
			end
		elseif PassLoot.db.profile.Rules[idx][dbkey] then
			local found = false
			for i, v in pairs(PassLoot.db.profile.Rules[idx][dbkey]) do
				if v[1]:lower() == command then
					found = true
					table.remove(PassLoot.db.profile.Rules[idx][dbkey], i)
					slash_feedback(flag, idx, command)
					break
				end
			end
			if not found then PassLoot:Pour("Item not found in Rule.") end
		end
	end
end

PassLoot.OptionsTable = {
	["type"] = "group",
	["handler"] = PassLoot,
	["get"] = "OptionsGet",
	["set"] = "OptionsSet",
	["args"] = {
		["Menu"] = {
			["name"] = L["Menu"],
			["order"] = 0,
			["desc"] = L["Opens the PassLoot Menu."],
			["type"] = "execute",
			["func"] = function()
				InterfaceOptionsFrame_OpenToCategory(L["PassLoot"])
			end,
		},
		["Test"] = {
			["name"] = L["Test"],
			["order"] = 30,
			["desc"] = L["Test an item link to see how we would roll"],
			["type"] = "input",
			["get"] = function() end,
			["set"] = function(info, value)
				local _, link = GetItemInfo(value)
				if PassLoot.EvalCache[link] then
					PassLoot.TestLink = PassLoot.EvalCache[link]["itemObj"]
				else
					PassLoot.TestLink = PassLoot:InitItem(link)
				end
				if (PassLoot.TestLink) then
					PassLoot.TestCanNeed, PassLoot.TestCanGreed, PassLoot.TestCanDisenchant = true, true, true
					PassLoot:START_LOOT_ROLL()
				else
					PassLoot.TestLink = nil -- to make sure
				end
			end,
		},
		["NameRule"] = {
			["name"] = L["NameRule"],
			["order"] = 60,
			["desc"] = L["(Add) or (remove) an item by name to an existing rule."],
			["type"] = "input",
			["get"] = function() end,
			["set"] = function(info, value)
				handleAddRemove(value, "NameRule", "Items", "Turtle Meat")
				PassLoot:ResetCache()
			end,
		},
		["IDRule"] = {
			["name"] = L["IDRule"],
			["order"] = 50,
			["desc"] = L["(Add) or (remove) an item by id to an existing rule"],
			["type"] = "input",
			["get"] = function() end,
			["set"] = function(info, value)
				handleAddRemove(value, "IDRule", "ItemIDs", "3712")
				PassLoot:ResetCache()
			end,
		},
		["Options"] = {
			["name"] = L["Options"],
			["order"] = 20,
			["desc"] = L["General Options"],
			["type"] = "group",
			["args"] = {
				["Enable"] = {
					["name"] = L["Enable Mod"],
					["desc"] = L["Enable or disable this mod."],
					["type"] = "toggle",
					["order"] = 0,
					["get"] = "IsEnabled",
					["set"] = function(info, v)
						if (v) then
							PassLoot:Enable()
						else
							PassLoot:Disable()
						end
					end,
				},
				["Messages"] = {
					["name"] = L["Messages"],
					["type"] = "group",
					["order"] = 10,
					["inline"] = true,
					["args"] = {
						["Quiet"] = {
							["name"] = L["Quiet"],
							["desc"] = L["Checking this will prevent extra details from being displayed."],
							["type"] = "toggle",
							["order"] = 0,
							["arg"] = { "Quiet" },
						},
						["RollNeed"] = {
							["name"] = NEED,
							["desc"] = L["Enter the text displayed when rolling."],
							["type"] = "input",
							["order"] = 10,
							["arg"] = { "MessageText", "need" },
						},
						["RollGreed"] = {
							["name"] = GREED,
							["desc"] = L["Enter the text displayed when rolling."],
							["type"] = "input",
							["order"] = 20,
							["arg"] = { "MessageText", "greed" },
						},
						["RollDisenchant"] = {
							["name"] = ROLL_DISENCHANT,
							["desc"] = L["Enter the text displayed when rolling."],
							["type"] = "input",
							["order"] = 30,
							["arg"] = { "MessageText", "de" },
						},
						["RollPass"] = {
							["name"] = PASS,
							["desc"] = L["Enter the text displayed when rolling."],
							["type"] = "input",
							["order"] = 40,
							["arg"] = { "MessageText", "pass" },
						},
						["Ignore"] = {
							["name"] = IGNORE,
							["desc"] = L["Enter the text displayed when rolling."],
							["type"] = "input",
							["order"] = 50,
							["arg"] = { "MessageText", "ignore" },
						},
					},
				},
				["AllowMultipleConfirmPopups"] = {
					["name"] = L["Allow Multiple Confirm Popups"],
					["desc"] = L
						["Checking this will disable the exclusive bit to allow multiple confirmation of loot roll popups"],
					["type"] = "toggle",
					["order"] = 20,
					["arg"] = { "AllowMultipleConfirmPopups" },
					["set"] = function(info, value)
						PassLoot:OptionsSet(info, value)
						PassLoot:SetExclusiveConfirmPopupBit()
					end,
					["width"] = "full",
					["disabled"] = function(info, value) return not StaticPopupDialogs.CONFIRM_LOOT_ROLL end, -- Some versions of WoW (or addons that remove) don't have CONFIRM_LOOT_ROLL
				},
				["SkipRules"] = {
					["name"] = L["Skip Rules"],
					["desc"] = L["Skip rules that have disabled or unknown filters."],
					["type"] = "toggle",
					["order"] = 30,
					["arg"] = { "SkipRules" },
				},
				["SkipWarning"] = {
					["name"] = L["Skip Warning"],
					["desc"] = L["Display a warning when a rule is skipped."],
					["type"] = "toggle",
					["order"] = 40,
					["arg"] = { "SkipWarning" },
				},
				["DisplayUnknownVars"] = {
					["name"] = L["Unknown Filters"],
					["desc"] = L["Displays disabled or unknown filter variables."],
					["type"] = "toggle",
					["order"] = 50,
					["arg"] = { "DisplayUnknownVars" },
					["set"] = function(info, value)
						PassLoot:OptionsSet(info, value)
						PassLoot:Rules_ActiveFilters_OnScroll()
					end,
				},
				["CleanRules"] = {
					["name"] = L["Clean Rules"],
					["desc"] = L["Removes disabled or unknown filters from current rules."],
					["type"] = "execute",
					["order"] = 60,
					["func"] = "CleanRules",
					["confirm"] = true,
					["confirmText"] = L["CLEAN RULES DESC"],
				},
			},
		},
		["Modules"] = {
			["name"] = L["Modules"],
			["order"] = 10,
			["type"] = "group",
			["args"] = {},
		},
		["Profiles"] = nil, -- Reserved for profile options
		["Output"] = nil, -- Reserved for sink output options
	},
}

-- A list of variables that are used in the DefaultTemplate (this is a quick lookup table of what variables are used)
PassLoot.DefaultVars = {
	-- [VariableName] = true,
}

function PassLoot:OptionsSet(Info, Value)
	local Table = self.db.profile
	for Key = 1, (#Info.arg - 1) do
		if (not Table[Info.arg[Key]]) then
			Table[Info.arg[Key]] = {}
		end
		Table = Table[Info.arg[Key]]
	end
	Table[Info.arg[#Info.arg]] = Value
end

function PassLoot:OptionsGet(Info)
	local Table = self.db.profile
	for Key = 1, (#Info.arg - 1) do
		if (not Table[Info.arg[Key]]) then
			Table[Info.arg[Key]] = {}
		end
		Table = Table[Info.arg[Key]]
	end
	return Table[Info.arg[#Info.arg]]
end

function PassLoot:SetExclusiveConfirmPopupBit()
	if (StaticPopupDialogs and StaticPopupDialogs.CONFIRM_LOOT_ROLL) then -- Some versions of WoW (or addons that remove) don't have CONFIRM_LOOT_ROLL
		if (self.db.profile.AllowMultipleConfirmPopups) then
			StaticPopupDialogs.CONFIRM_LOOT_ROLL.exclusive = nil
			StaticPopupDialogs.CONFIRM_LOOT_ROLL.multiple = 1
		else
			if (not StaticPopupDialogs.CONFIRM_LOOT_ROLL.exclusive) then -- Only modify this if we touched it.
				StaticPopupDialogs.CONFIRM_LOOT_ROLL.exclusive = 1
				StaticPopupDialogs.CONFIRM_LOOT_ROLL.multiple = nil
			end
		end
	end
end

function PassLoot:OnInitialize()
	-- Called when the addon is loaded
	-- LibStub("AceConsole-3.0"):RegisterChatCommand(L["PASSLOOT_SLASH_COMMAND"], function() InterfaceOptionsFrame_OpenToCategory(L["PassLoot"]) end)
	self.db = LibStub("AceDB-3.0"):New("PassLootDB", defaults, L["Default"])
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	-- self.db.RegisterCallback(self, "OnProfileDeleted", "OnProfileNewOrDelete")
	-- self.db.RegisterCallback(self, "OnNewProfile", "OnProfileNewOrDelete")
	self:SetSinkStorage(self.db.profile.SinkOptions)

	self.OptionsTable.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	self.OptionsTable.args.Output = self:GetSinkAce3OptionsDataTable()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(L["PassLoot"], self.OptionsTable, { L["PASSLOOT_SLASH_COMMAND"] })
	-- Ability_Racial_PackHobgoblin
	-- INV_Misc_Bag_10
	-- INV_Misc_Coin_02
	-- Racial_Dwarf_FindTreasure
	self.LDB = LDB:NewDataObject("PassLoot", {
		["type"] = "launcher",
		["icon"] = "Interface\\Icons\\INV_Misc_Coin_02.blp",
		["OnClick"] = function()
			InterfaceOptionsFrame_OpenToCategory(L["PassLoot"])
		end,
		["OnTooltipShow"] = function(tooltip)
			if (tooltip and tooltip.AddLine) then
				tooltip:SetText(L["PassLoot"])
				for Key, Value in ipairs(self.LastRolls) do
					tooltip:AddLine(Value)
				end
				tooltip:Show()
			end
		end,
	})

	-- self.MainFrame = self:Create_MainFrame()
	self.RulesFrame = self:Create_RulesFrame()
	InterfaceOptions_AddCategory(self.RulesFrame)
	self.Tooltip = self:Create_PassLootTooltip()
	-- self.BlizOptionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PassLoot", L["PassLoot"])
	self.BlizOptionsFrames = {
		["Modules"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["PassLoot"], L["Modules"], L["PassLoot"],
			"Modules"),
		["GeneralOptions"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["PassLoot"], L["Options"], L["PassLoot"],
			"Options"),
		["Profiles"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["PassLoot"], L["Profiles"], L["PassLoot"],
			"Profiles"),
		["Output"] = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(L["PassLoot"], L["Output"], L["PassLoot"], "Output"),
	}

	-- PanelTemplates_SetNumTabs(PassLoot_TabbedMenuContainer, 2)  -- 2 because there are 2 tabs total.
	-- PanelTemplates_SetTab(PassLoot_TabbedMenuContainer, 1)      -- 1 because we want tab 1 selected.
	-- PanelTemplates_UpdateTabs(PassLoot_TabbedMenuContainer)
	self.DropDownFrame = CreateFrame("Frame", "PassLoot_DropDownMenu", nil, "UIDropDownMenuTemplate")
end

local BUCKET_BAG_UPDATE, BUCKET_PLAYER_LEVEL_UP
function PassLoot:OnEnable()
	-- events that may fire multiple times in quick succession and require a cache update, but don't require information from the event
	BUCKET_BAG_UPDATE = self:RegisterBucketEvent("BAG_UPDATE", 1, "UpdateBags")
	BUCKET_PLAYER_LEVEL_UP = self:RegisterBucketEvent("PLAYER_LEVEL_UP", 1, "ClearItemCache")
	-- events that only fire occassionally
	self:RegisterEvent("START_LOOT_ROLL")
	self:RegisterEvent("ASCENSION_STORE_COLLECTION_ITEM_LEARNED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ClearItemCache")
	-- events that require the event details and also fire with BAG_UPDATE
	C_Hook:Register(self, "BAG_ITEM_REMOVED, BAG_ITEM_COUNT_CHANGED")

	self:SetupModulesOptionsTables() -- Creates Module header frames and lays them out in the scroll frame
	self:OnProfileChanged()
	self.LastRolls = {}           -- Last 10 rolls.
end

function PassLoot:OnDisable()
	-- events that may fire multiple times in quick succession and require a cache update, but don't require information from the event
	self:UnregisterBucket(BUCKET_BAG_UPDATE)
	self:UnregisterBucket(BUCKET_PLAYER_LEVEL_UP)
	-- events that only fire occassionally
	self:UnregisterEvent("START_LOOT_ROLL")
	self:UnregisterEvent("ASCENSION_STORE_COLLECTION_ITEM_LEARNED")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	-- events that require the event details and also fire a BAG_UPDATE
	C_Hook:Unregister(self, "BAG_ITEM_REMOVED, BAG_ITEM_COUNT_CHANGED")
	self:UnregisterEvent("START_LOOT_ROLL")
end

function PassLoot:OnProfileChanged()
	-- this is called every time your profile changes (after the change)
	self:SetExclusiveConfirmPopupBit()
	self.CurrentRule = 0
	self.CurrentRuleUnknownVars = {}
	self.CurrentOptionFilter = { nil, 0 } -- Frame, line #
	self:LoadModules()
	self:SendMessage("PassLoot_OnProfileChanged")
	-- Now we check our rules to see if all variables are set.
	-- We could check profile variables, but some modules need more than just setting defaults, they need to act on them.
	self:CheckRuleTables()
	self:Rules_RuleList_OnScroll()
	self:DisplayCurrentRule()
	self:ResetCache()
	-- self:OnProfileNewOrDelete()
end

-- function PassLoot:OnProfileNewOrDelete()
-- end

function PassLoot:LoadModules()
	local Module
	for ModuleKey, ModuleValue in self:IterateModules() do
		Module = ModuleValue:GetName()
		self.db.profile.Modules[Module] = self.db.profile.Modules[Module] or {}
		if (self.db.profile.Modules[Module].Status == nil) then
			self.db.profile.Modules[Module].Status = true
		end
		if (self.db.profile.Modules[Module].Status ~= ModuleValue.enabledState) then
			if (self.db.profile.Modules[Module].Status) then
				ModuleValue:Enable()
			else
				ModuleValue:Disable()
			end
		end
	end
end

local CanRoll = {
	["need"] = nil,
	["greed"] = nil,
	["de"] = nil,
	["pass"] = true,
}

local RollMethodLookup = {
	[1] = L["Need"],
	[2] = L["Greed"],
	[3] = L["Disenchant"],
	[0] = L["Pass"],
}

local QueueOperations = {
	["reset"] = false,
	["IDs"] = {}, -- set of IDs to invalidate matching caches
}

-- Bucket Event to handle updating the item cache
function PassLoot:UpdateBags(...)
	local currentTime = GetTime()
	-- if we are resetting the cache, only do that since any updates or single item deletes will be useless
	if QueueOperations["reset"] then
		PassLoot:ResetCache()
		-- forget items based on item id
	elseif type(next(QueueOperations["IDs"])) ~= "nil" then
		for k, v in pairs(PassLoot.EvalCache) do
			if QueueOperations["IDs"][v["itemObj"].id] then
				PassLoot.EvalCache[k] = nil
			end
		end
	end
	-- TODO: forget any expired cache items
	-- we processed the update, reset the queue
	QueueOperations = { ["reset"] = false, ["IDs"] = {} }
	-- remove any cache that expired
	for k, v in pairs(PassLoot.EvalCache) do
		if PassLoot.EvalCache[k]["expiresAt"] < currentTime then
			PassLoot.EvalCache[k] = nil
		end
	end
end

function PassLoot:ClearItemCache(...)
	QueueOperations["reset"] = true
end

function PassLoot:ASCENSION_STORE_COLLECTION_ITEM_LEARNED(Event, ID, ...)
	QueueOperations["IDs"][ID] = true
end

function PassLoot:BAG_ITEM_REMOVED(Bag, Slot, ID, StackCount, ...)
	QueueOperations["IDs"][ID] = true
end

function PassLoot:BAG_ITEM_COUNT_CHANGED(Bag, Slot, ID, NewStackNum, Change, ...)
	QueueOperations["IDs"][ID] = true
	--	QueueOperations["BagSlots_Count"][Bag][Slot] = NewStackNum
end

function PassLoot:AddLastRoll(RollMethod, itemObj, RuleID)
	-- Add to LastRolls
	local TextLine, Method
	if (RollMethod) then
		Method = RollMethodLookup[RollMethod]
	else
		Method = L["Ignored"]
	end
	TextLine = string.format("|T%s:0|t %s - %s -> %s", itemObj.texture, itemObj.link, Method, PassLoot.db.profile.Rules[RuleID].Desc)
	if (#self.LastRolls == 10) then
		table.remove(self.LastRolls, 1)
	end
	table.insert(self.LastRolls, TextLine)
end

-- Texture, Name, Count, Quality, BindOnPickup, CanNeed, CanGreed, CanDisenchant = GetLootRollItemInfo(rollID)
-- RollOnLoot(RollID, #)  0 = pass, 1 = need, 2 = greed, 3 = de
function PassLoot:START_LOOT_ROLL(Event, RollID, ...)
	local ItemLink, Name
	-- Might need to remove the CanDisenchant lines here if Blizz doesn't care if a DE'er is present or not?
	if (self.TestLink) then
		RollID = -1
		ItemLink = self.TestLink.link
		CanRoll.need, CanRoll.greed, CanRoll.de = self.TestCanNeed, self.TestCanGreed, self.TestCanDisenchant
	else
		ItemLink = GetLootRollItemLink(RollID)
		_, _, _, _, _, CanRoll.need, CanRoll.greed, CanRoll.de = GetLootRollItemInfo(RollID)
	end
	if (not ItemLink) then
		self:Print("A roll for an item started, but could not get an item link!")
		return
	end
	local itemObj
	if PassLoot.EvalCache[ItemLink] then
		itemObj = PassLoot.EvalCache[ItemLink]["itemObj"]
	else
		itemObj = PassLoot:InitItem(ItemLink)
	end
	local RollMethod, RuleID = PassLoot:GetItemEvaluation(itemObj, RollID)
	if RollMethod ~= nil then
		PassLoot:AddLastRoll(RollMethod, itemObj, RuleID)
	end
	if not self.TestLink and RollMethod and RollMethod ~= nil and RollID > -1 then
		AceTimer:ScheduleTimer("delay_rollOnLoot", 0.1, RollID, RollMethod)
	end
end

function PassLoot:EvaluateItem(itemObj, RollID)
	if not itemObj or not itemObj.link then return end
	local Name = itemObj.name
	PastLootTT:ClearLines()
	PastLootTT:SetHyperlink(itemObj.link)
	for WidgetKey, WidgetValue in ipairs(self.RuleWidgets) do
		WidgetValue:SetMatch(itemObj, PassLootTT, RollID or -1)
	end
	local MatchedRule, NumFilters
	local IsMatch, IsException, NormalMatch, ExceptionMatch, HadNoNormal
	local NormalMatchText, ExceptionMatchText = "", ""
	for RuleKey, RuleValue in ipairs(self.db.profile.Rules) do
		self:Debug("Checking rule " .. RuleKey .. " " .. RuleValue.Desc)
		if (self.db.profile.SkipRules and self.SkipRules[RuleKey]) then
			if (self.db.profile.SkipWarning) then
				self:Pour("|cff33ff99" ..
					L["PastLoot"] .. "|r: " .. string.gsub(L["Skipping %rule%"], "%%rule%%", RuleValue.Desc))
			end
		else
			MatchedRule = true
			for WidgetKey, WidgetValue in ipairs(self.RuleWidgets) do
				NumFilters = WidgetValue:GetNumFilters(RuleKey) or 0
				if (NumFilters > 0) then
					NormalMatchText, ExceptionMatchText = "", ""
					self:Debug("Checking filter " .. WidgetValue.Info[1] .. " (" .. NumFilters .. " NumFilters)")
					-- I can not simply OR normal ones and AND NOT the exception ones.. example: for a 1hd mace
					-- Filter1: OR Armor
					-- Filter2: AND NOT 1hd mace
					-- Filter3: OR Weapon
					-- Will evaluate true, when it should have evaluated false.
					-- It should have been (Armor OR Weapon) AND NOT (1hd mace)
					NormalMatch = false
					ExceptionMatch = false
					HadNoNormal = true
					for Index = 1, NumFilters do
						IsMatch = WidgetValue:GetMatch(RuleKey, Index)
						if (IsMatch) then
							IsMatch = true
						else
							IsMatch = false
						end
						IsException = WidgetValue:IsException(RuleKey, Index)
						if (IsException) then
							ExceptionMatch = ExceptionMatch or IsMatch
							ExceptionMatchText = ExceptionMatchText .. Index .. "-" .. tostring(IsMatch) .. " OR "
							if (IsMatch) then -- don't have to go any further, one single true in the exception = a false in the entire filter.
								break
							end
						else
							NormalMatch = NormalMatch or IsMatch
							HadNoNormal = false
							NormalMatchText = NormalMatchText .. Index .. "-" .. tostring(IsMatch) .. " OR "
						end
					end -- Each Filter
					if ((NormalMatch or HadNoNormal) and not ExceptionMatch) then
						self:Debug("Filter matched: (" ..
							NormalMatchText .. tostring(HadNoNormal) .. ") AND NOT (" .. ExceptionMatchText .. " false)")
					else
						self:Debug("Filter did not match: (" ..
							NormalMatchText .. tostring(HadNoNormal) .. ") AND NOT (" .. ExceptionMatchText .. " false)")
						MatchedRule = false
						break
					end
				end -- NumFilters > 0
			end -- Each Widget

			if (MatchedRule) then
				self:Debug("Matched rule")
				local StatusMsg, RollMethod
				StatusMsg = self.db.profile.MessageText.ignore
				-- To make absolutely sure I roll according to RollOrder
				local WantToRoll = {}
				for LootKey, LootValue in pairs(RuleValue.Loot) do
					WantToRoll[LootValue] = true
				end
				for RollOrderKey, RollOrderValue in ipairs(self.RollOrder) do
					if (WantToRoll[RollOrderValue] and CanRoll[RollOrderValue]) then
						RollMethod = self.RollMethod[RollOrderValue]
						StatusMsg = self.db.profile.MessageText[RollOrderValue]
						break
					end
				end
				-- for LootKey, LootValue in ipairs(RuleValue.Loot) do
				-- if ( CanRoll[LootValue] ) then
				-- RollMethod = self.RollMethod[LootValue]
				-- StatusMsg = self.db.profile.MessageText[LootValue]
				-- break
				-- end
				-- end
				self:SendMessage("PassLoot_OnRoll", itemObj.link, RuleKey, RollID, RollMethod) -- Maybe change this to OnRuleMatched
				if (not self.TestLink) then
					if (RollMethod) then
						-- RollOnLoot(RollID, RollMethod)
						return RollMethod, RuleKey
					end
				end
				-- Send StatusMsg
				if (self.db.profile.Quiet == false) then
					-- Workaround for LibSink.  It can handle |c and |r color stuff, but not full ItemLinks
					local ItemText
					if (self.db.profile.SinkOptions.sink20OutputSink == "Channel") then
						ItemText = itemObj.name
					else
						ItemText = itemObj.link
					end
					StatusMsg = string.gsub(StatusMsg, "%%item%%", ItemText)
					StatusMsg = string.gsub(StatusMsg, "%%rule%%", RuleValue.Desc)
					self:Pour("|cff33ff99" .. L["PassLoot"] .. "|r: " .. StatusMsg)
				end
				--We found the item, and rolled on it, so go ahead and quit.
				self.TestLink, CanRoll.greed, CanRoll.need, CanRoll.de = nil, nil, nil, nil
				return
			end --MatchedRule
		end -- SkipRules
		self:Debug("Rule not matched, trying another")
	end --RuleKey, RuleValue
	self:Debug("Ran out of rules, ignoring")
	if (self.TestLink) then
		self:Pour(itemObj.link .. ": " .. L["No rules matched."])
	end
	self.TestLink, CanRoll.greed, CanRoll.need, CanRoll.de = nil, nil, nil, nil
end

function PassLoot:CleanRules()
	-- local DefaultVars = {}
	-- for DefaultKey, DefaultValue in pairs(self.DefaultTemplate) do
	-- DefaultVars[DefaultValue[1]] = true
	-- end
	for RuleKey, RuleValue in pairs(self.db.profile.Rules) do
		for VarKey, VarValue in pairs(RuleValue) do
			if (not self.DefaultVars[VarKey]) then
				self.db.profile.Rules[RuleKey][VarKey] = nil
			end
		end
	end
	self.SkipRules = {}
end

-- We make sure each rule has a default value
-- Update the DefaultVars lookup table.
-- Based on DefaultVars, create a list of rules to skip  (A rule has a module variable set, but no module is loaded to check it)
function PassLoot:CheckRuleTables()
	for Key, Value in pairs(self.DefaultVars) do
		self.DefaultVars[Key] = nil
	end
	for DefaultKey, DefaultValue in pairs(self.DefaultTemplate) do
		self.DefaultVars[DefaultValue[1]] = true
	end
	self.SkipRules = {}
	local RulesSkipped = false
	self.db.profile.Rules = self.db.profile.Rules or {}
	for RuleKey, RuleValue in pairs(self.db.profile.Rules) do
		for DefaultKey, DefaultValue in ipairs(self.DefaultTemplate) do
			-- Check if the rule does not have a variable but the default template says we should.
			if (not RuleValue[DefaultValue[1]] and DefaultValue[2]) then
				self.db.profile.Rules[RuleKey][DefaultValue[1]] = self:CopyTable(DefaultValue[2])
			end
		end
		-- Check each variable to see if it's listed in the DefaultTemplate
		for VarKey, VarValue in pairs(RuleValue) do
			if (not self.DefaultVars[VarKey]) then
				self:Debug("Could not find some variables in rule " .. RuleValue.Desc)
				self.SkipRules[RuleKey] = true
				RulesSkipped = true
				break
			end
		end
	end
	if (RulesSkipped and self.db.profile.SkipRules) then
		self:Pour("|cff33ff99" .. L["PassLoot"] .. "|r: " .. L["Found some rules that will be skipped."])
	end
end

function PassLoot:Debug(...)
	local DebugLine, Counter
	if (self.DebugVar == true) then
		DebugLine = ""
		for Counter = 1, select("#", ...) do
			DebugLine = DebugLine .. select(Counter, ...)
		end
		self:Print(DebugLine)
	end
end

function PassLoot:IterateRules(CallbackFunc, ...)
	if (PassLootDB and PassLootDB.profiles) then
		for ProfileKey, ProfileValue in pairs(PassLootDB.profiles) do
			if (ProfileValue.Rules) then
				for RuleKey, RuleValue in ipairs(ProfileValue.Rules) do
					if (type(CallbackFunc) == "string") then
						self[CallbackFunc](self, RuleValue, ...)
					elseif (type(CallbackFunc) == "function") then
						CallbackFunc(RuleValue, ...)
					end
				end -- RuleKey, RuleValue
			end -- if ProfileValue.Rules
		end -- ProfileKey, ProfileValue
	elseif (self.db and self.db.profile and self.db.profile.Rules) then
		for RuleKey, RuleValue in ipairs(self.db.profile.Rules) do
			if (type(CallbackFunc) == "string") then
				self[CallbackFunc](self, RuleValue, ...)
			elseif (type(CallbackFunc) == "function") then
				CallbackFunc(RuleValue, ...)
			end
		end -- RuleKey, RuleValue
	end
end

-- ####### Structures ########
-- ## Main PassLoot DB structure ##
-- DB Version 12 structure:
-- PassLoot Global = {
-- ["Modules"] = {
-- ["ModuleName"] = {
-- ["Version"] = 1,
-- },
-- },
-- }
-- PassLoot Profile = {
-- ["Quiet"] = false,
-- ["Rules"] = {
-- {
-- ["Desc"] = "Description",
-- ["ModuleVar"] = ModuleValue,
-- ["ModuleVar"] = ModuleValue,
-- },
-- },
-- ["Modules"] = {
-- ["ModuleName"] = {
-- ["Status"] = true/false,
-- ["ProfileVars"] = {},
-- },
-- },
-- }

-- ## Table format of Default Template when creating a new rule ##
-- # Also the format for registering the variables
-- PassLoot.DefaultTemplate = {
-- { VariableName, Default },
-- { VariableName, Default },
-- }

-- ## Plugin Lookup Table ##
-- This is a lookup only table, we do not delete entries from this table generated
-- # RuleVariables are created when a module uses RegisterDefaultVariables()
-- Used as verification, as the only variables our module can access with GetConfigOption() and SetConfigOption()
-- Also used in CheckDBVersion, as a list of variables to upgrade with the Callback function.
-- # RuleWidgets are created when a module uses AddWidget()
-- Used as a list of widgets to remove from the PassLoot.RuleWidgets table.
-- (PassLoot.RuleWidgets is a sorted table of all widgets to display)
-- PassLoot.PluginInfo = {
-- [ModuleName] = {
-- ["RuleVariables"] = {
-- VariableName = true,
-- VariableName = true,
-- },
-- ["RuleWidgets"] = {
-- [1] = WidgetA,
-- [2] = WidgetB,
-- },
-- },
-- }

-- ## Main table of SORTED (Alphabetical > preferred priority) rule widgets to display ##
-- PassLoot.RuleWidgets = {
-- WidgetA,
-- WidgetB,
-- }

-- ## Module List in a SORTED order.  Actual headers in self.PluginInfo.ProfileHeader ##
-- PassLoot.ModuleHeaders = {
-- "ModuleA",
-- "ModuleB",
-- }

-- Widget.Info = {
-- [1] = "Text to display in filter list",
-- [2] = "Tooltip description",
-- [3] = "Module name this belongs to",
-- }
