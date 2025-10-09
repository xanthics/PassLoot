local PassLoot = LibStub("AceAddon-3.0"):GetAddon("PassLoot")

--[[
	Remix of Ascension code for the following functions
	-- IsItemBloodforged
	-- IsItemHeroic
	-- IsItemMythic
	-- IsItemAscended
	-- GetItemMythicLevel
]]
local function processItemFlavorText(item)
	local flavor = GetItemFlavorText(item.id)

	item.isBloodforged = flavor:find("Bloodforged", 1, true) ~= nil
	item.isHeroic = flavor:find("Heroic", 1, true) ~= nil
	if not item.isHeroic then
		item.isMythic = flavor:find("Mythic", 1, true) ~= nil
		if not item.isMythic then
			item.isAscended = flavor:find("Ascended", 1, true) ~= nil
		end
	end
	item.isWorldforged = flavor:find("Worldforged", 1, true) ~= nil
	local level
	if item.isMythic then
		level = flavor:match("Mythic (%d*)")
		level = level and tonumber(level)
	end

	item.mythicLevel = level or 0 -- 0 means not a Mythic+ item
end

local function fillItemInfo(item)
	local name, _, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(item.link)
	item.name = name
	item.quality = quality
	item.iLevel = iLevel
	item.reqLevel = reqLevel or 0
	item.class = class
	item.subclass = subclass
	item.maxStack = maxStack
	item.equipSlot = equipSlot
	item.texture = texture
	item.vendorPrice = vendorPrice
	return item
end

function PassLoot:InitItem(link)
	if not link then return end

	local item = {}
	item.link = link
	item.id = GetItemInfoFromHyperlink(link)
	item = fillItemInfo(item)
	processItemFlavorText(item)
	return item
end
