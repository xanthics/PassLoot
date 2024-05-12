local PassLoot = LibStub("AceAddon-3.0"):GetAddon("PassLoot")

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
	return item
end
