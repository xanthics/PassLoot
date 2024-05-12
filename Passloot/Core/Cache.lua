local PassLoot = LibStub("AceAddon-3.0"):GetAddon("PassLoot")

function PassLoot:ResetCache()
	PassLoot.EvalCache = {}
	PassLoot.TooltipCache = { tt = "", Left = {}, Right = {} }
end

local function initCache()
	if not PassLoot.EvalCache or not PassLoot.TooltipCache then
		PassLoot:ResetCache()
	end
end

local function ColorCheck(Red, Green, Blue, Alpha)
	Red = math.floor(Red * 255 + 0.5)
	Green = math.floor(Green * 255 + 0.5)
	Blue = math.floor(Blue * 255 + 0.5)
	Alpha = math.floor(Alpha * 255 + 0.5)
	return (Red == 255 and Green == 32 and Blue == 32 and Alpha == 255)
end

local function getLine(Line)
	if Line then
		local text = Line:GetText()
		local Red, Green, Blue, Alpha = Line:GetTextColor()
		if ColorCheck(Red, Green, Blue, Alpha) then
			PassLoot.TooltipCache.usable = false
		end
		return text and text or ""
	else
		return ""
	end
end

function PassLoot:BuildTooltipCache(item)
	initCache()
	if not item or not item.link then return end
	local cache = PassLoot.TooltipCache
	if item.link == cache.link then return end
	cache.Left, cache.Right = {}, {}
	cache.link = item.link
	cache.usable = true

	PassLootTT:ClearLines()
	PassLootTT:SetHyperlink(item.link)
	local ttName = PassLootTT:GetName()
	for Index = 1, PassLootTT:NumLines() do
		cache.Left[Index]  = getLine(_G[ttName .. "TextLeft" .. Index])
		cache.Right[Index] = getLine(_G[ttName .. "TextRight" .. Index])
	end
end

function PassLoot:GetItemEvaluation(item)
	initCache()
	if not item or not item.link then return end
	local cache = PassLoot.EvalCache
	if not (cache[item.link] and cache[item.link]["expiresAt"] >= GetTime()) then
		if PassLoot:ValidateItemObj(item) then
			local r, m = PassLoot:EvaluateItem(item)
			cache[item.link] = { ["itemObj"] = item, ["result"] = r, ["match"] = m, ["expiresAt"] = GetTime() +
			self.db.profile.CacheExpires }
		else
			cache[item.link] = { ["itemObj"] = item, ["result"] = 1, ["match"] = -1, ["expiresAt"] = GetTime() + 5 }
		end
	end
	return { cache[item.link]["result"], cache[item.link]["match"] }
end

function PassLoot:ValidateItemObj(itemObj)
	return itemObj.name and itemObj.count and itemObj.id and itemObj.link
end
