-- chunkname: @modules/logic/activitywelfare/model/VersionActivity3_8SelfSelectSixModel.lua

module("modules.logic.activitywelfare.model.VersionActivity3_8SelfSelectSixModel", package.seeall)

local VersionActivity3_8SelfSelectSixModel = class("VersionActivity3_8SelfSelectSixModel", BaseModel)

function VersionActivity3_8SelfSelectSixModel:onInit()
	self:reInit()
end

function VersionActivity3_8SelfSelectSixModel:reInit()
	self._curSelectHeroId = 0
	self._curPreviewHeroId = 0
end

VersionActivity3_8SelfSelectSixModel.ItemId = 642802

function VersionActivity3_8SelfSelectSixModel:getAllPreviewHeroList()
	local itemCo = ItemConfig.instance:getItemCo(VersionActivity3_8SelfSelectSixModel.ItemId)

	if not itemCo or string.nilorempty(itemCo.effect) then
		return {}
	end

	local effArr = string.split(itemCo.effect, "|")

	if not effArr or #effArr < 3 then
		return
	end

	local heroList = {}
	local heroArr = string.splitToNumber(effArr[3], "#")

	for _, heroId in ipairs(heroArr) do
		table.insert(heroList, heroId)
	end

	return heroList
end

function VersionActivity3_8SelfSelectSixModel:isIgnoreDestiny(destinyId)
	local itemCo = ItemConfig.instance:getItemCo(VersionActivity3_8SelfSelectSixModel.ItemId)

	if not itemCo or string.nilorempty(itemCo.effect) then
		return false
	end

	local effArr = string.split(itemCo.effect, "|")

	if not effArr or #effArr < 2 then
		return false
	end

	local destinyArr = string.splitToNumber(effArr[2], "#")

	for _, id in ipairs(destinyArr) do
		if id == destinyId then
			return true
		end
	end

	return false
end

function VersionActivity3_8SelfSelectSixModel:getHeroDestinys(heroId)
	local destinyCfg = CharacterDestinyConfig.instance:getHeroDestiny(heroId)

	if not destinyCfg or string.nilorempty(destinyCfg.facetsId) then
		return {}
	end

	local resultDestinyIds = {}
	local destinyIds = string.splitToNumber(destinyCfg.facetsId, "#")

	for _, destinyId in ipairs(destinyIds) do
		local isIgnore = self:isIgnoreDestiny(destinyId)
		local exSkillLvCos = true

		if not isIgnore and exSkillLvCos then
			table.insert(resultDestinyIds, destinyId)
		end
	end

	return resultDestinyIds
end

function VersionActivity3_8SelfSelectSixModel:getAllChoiceHeroDestinyList()
	local list = {}
	local heroList = self:getAllPreviewHeroList()

	for _, heroId in pairs(heroList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)
		local isOpen = self:isHeroOpenDestinyStone(heroId)
		local isIgnore = self:isIgnoreAllDestinyStone(heroId)

		if heroMo and isOpen and not isIgnore and not heroMo.destinyStoneMo:checkAllUnlock() then
			table.insert(list, heroMo)
		end
	end

	return list
end

function VersionActivity3_8SelfSelectSixModel:isAllHasHeroDestinyLvMaxed()
	local heroList = self:getAllChoiceHeroDestinyList()

	for _, heroMo in pairs(heroList) do
		local isSlotMaxLevel = heroMo.destinyStoneMo and heroMo.destinyStoneMo:isSlotMaxLevel()
		local stoneList = heroMo.destinyStoneMo and heroMo.destinyStoneMo:getStoneMoList()
		local ignoreIds = self:getIgnoreIds()

		if not isSlotMaxLevel then
			return false
		else
			for _, stoneMo in pairs(stoneList) do
				local isIgnore = LuaUtil.tableContains(ignoreIds, stoneMo.stoneId)

				if not stoneMo.isUnlock and not isIgnore then
					return false
				end
			end
		end
	end

	return true
end

function VersionActivity3_8SelfSelectSixModel:isAllHeroDestinyLvMaxed()
	local heroList = self:getAllPreviewHeroList()

	for _, heroId in pairs(heroList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if not heroMo then
			return false
		end

		local isSlotMaxLevel = heroMo.destinyStoneMo and heroMo.destinyStoneMo:isSlotMaxLevel()
		local stoneList = heroMo.destinyStoneMo and heroMo.destinyStoneMo:getStoneMoList()
		local ignoreIds = self:getIgnoreIds()

		if not isSlotMaxLevel then
			return false
		else
			for _, stoneMo in pairs(stoneList) do
				local isIgnore = LuaUtil.tableContains(ignoreIds, stoneMo.stoneId)

				if not stoneMo.isUnlock and not isIgnore then
					return false
				end
			end
		end
	end

	return true
end

function VersionActivity3_8SelfSelectSixModel:isHeroOpenDestinyStone(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo or not heroMo:isHasDestinySystem() then
		return false
	end

	local rare = heroMo.config.rare or 5
	local constId = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[rare]
	local openLevel = CommonConfig.instance:getConstStr(constId)

	if heroMo.level >= tonumber(openLevel) then
		return true
	end

	return false
end

function VersionActivity3_8SelfSelectSixModel:getIgnoreIds()
	local materialId = VersionActivity3_8SelfSelectSixModel.ItemId
	local itemConfig = ItemConfig.instance:getItemCo(materialId)
	local effect = itemConfig.effect
	local ignoreIds = {}

	if not string.nilorempty(effect) then
		local _split = GameUtil.splitString2(effect, true)

		if _split[2] then
			ignoreIds = _split[2]
		end
	end

	return ignoreIds
end

function VersionActivity3_8SelfSelectSixModel:isIgnoreAllDestinyStone(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return false
	end

	local destinyStoneMo = heroMo.destinyStoneMo
	local stoneMoList = destinyStoneMo:getStoneMoList()
	local ignoreIds = self:getIgnoreIds()

	for _, stoneMo in pairs(stoneMoList) do
		if not LuaUtil.tableContains(ignoreIds, stoneMo.stoneId) then
			return false
		end
	end

	return true
end

VersionActivity3_8SelfSelectSixModel.instance = VersionActivity3_8SelfSelectSixModel.New()

return VersionActivity3_8SelfSelectSixModel
