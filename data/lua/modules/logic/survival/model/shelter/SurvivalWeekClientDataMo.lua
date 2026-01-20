-- chunkname: @modules/logic/survival/model/shelter/SurvivalWeekClientDataMo.lua

module("modules.logic.survival.model.shelter.SurvivalWeekClientDataMo", package.seeall)

local SurvivalWeekClientDataMo = pureTable("SurvivalWeekClientDataMo")

function SurvivalWeekClientDataMo:init(data, weekMo)
	local dict = {}

	if not string.nilorempty(data) then
		dict = cjson.decode(data)
	end

	if dict.ver and dict.ver ~= self:getCurVersion() then
		dict = {}
	end

	dict.ver = dict.ver or self:getCurVersion()

	local isChange = false

	if not dict.nowUnlockMapsCount then
		dict.nowUnlockMapsCount = #weekMo.mapInfos
		isChange = true
	end

	dict.shopLevelUI = dict.shopLevelUI or {}
	dict.shopHUDLevelUI = dict.shopHUDLevelUI or {}
	dict.decodingItemNum = dict.decodingItemNum or 0
	dict.isBossWeak = dict.isBossWeak or false
	dict.bossRepress = dict.bossRepress or {}
	dict.bossRepressProgress = dict.bossRepressProgress or 0.089
	self.data = dict

	if isChange and weekMo.day > 0 then
		self.isDirty = true

		self:saveDataToServer()
	end
end

function SurvivalWeekClientDataMo:getCurVersion()
	return 1
end

function SurvivalWeekClientDataMo:setHeroCount(value)
	self.data.npcCount = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setNpcCount(value)
	self.data.heroCount = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setIsBossWeak(value)
	self.data.isBossWeak = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:setDecodingItemNum(value)
	self.data.decodingItemNum = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:getReputationShopUILevel(shopId)
	local key = tostring(shopId)

	if self.data.shopLevelUI[key] then
		return self.data.shopLevelUI[key]
	end

	return 0
end

function SurvivalWeekClientDataMo:setReputationShopUILevel(shopId, level)
	if self:getReputationShopUILevel(shopId) ~= level then
		local key = tostring(shopId)

		self.data.shopLevelUI[key] = level
		self.isDirty = true
	end
end

function SurvivalWeekClientDataMo:getReputationShopHUDUILevel(shopId)
	local key = tostring(shopId)

	if self.data.shopHUDLevelUI[key] then
		return self.data.shopHUDLevelUI[key]
	end

	return 0
end

function SurvivalWeekClientDataMo:setReputationShopHUDUILevel(shopId, level)
	if self:getReputationShopHUDUILevel(shopId) ~= level then
		local key = tostring(shopId)

		self.data.shopHUDLevelUI[key] = level
		self.isDirty = true
	end
end

function SurvivalWeekClientDataMo:getBossRepress(fightId, id)
	local key = string.format("%s_%s", fightId, id)

	if self.data.bossRepress[key] then
		return self.data.bossRepress[key]
	end

	return 0
end

function SurvivalWeekClientDataMo:setBossRepress(fightId, id)
	local key = string.format("%s_%s", fightId, id)

	self.data.bossRepress[key] = true
	self.isDirty = true
end

function SurvivalWeekClientDataMo:getBossRepressProgress(fightId)
	local key = tostring(fightId)

	if self.data.bossRepressProgress[key] then
		return self.data.bossRepressProgress[key]
	end

	return 0.089
end

function SurvivalWeekClientDataMo:setBossRepressProgress(value)
	self.data.bossRepressProgress = value
	self.isDirty = true
end

function SurvivalWeekClientDataMo:saveDataToServer(force)
	if SurvivalModel.instance:getSurvivalSettleInfo() then
		return
	end

	if force or self.isDirty then
		SurvivalWeekRpc.instance:sendSurvivalSurvivalWeekClientData(cjson.encode(self.data))

		self.isDirty = false
	end
end

return SurvivalWeekClientDataMo
