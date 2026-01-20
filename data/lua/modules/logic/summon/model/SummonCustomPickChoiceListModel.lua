-- chunkname: @modules/logic/summon/model/SummonCustomPickChoiceListModel.lua

module("modules.logic.summon.model.SummonCustomPickChoiceListModel", package.seeall)

local SummonCustomPickChoiceListModel = class("SummonCustomPickChoiceListModel", ListScrollModel)

function SummonCustomPickChoiceListModel:onInit()
	self:clear()
end

function SummonCustomPickChoiceListModel:reInit()
	self:clear()
end

function SummonCustomPickChoiceListModel:initDatas(poolId)
	self._poolId = poolId
	self._selectIdList = {}
	self._selectIdMap = {}

	self:initList()
end

SummonCustomPickChoiceListModel.SkillLevel2Order = {
	[0] = 50,
	40,
	30,
	20,
	10,
	60
}

local function sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo ~= nil
	local bHasHero = bHeroMo ~= nil

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	local aSkillLevel = aHeroMo and aHeroMo.exSkillLevel or -1
	local bSkillLevel = bHeroMo and bHeroMo.exSkillLevel or -1

	if aSkillLevel ~= bSkillLevel then
		local aOrder = SummonCustomPickChoiceListModel.SkillLevel2Order[aSkillLevel] or 999
		local bOrder = SummonCustomPickChoiceListModel.SkillLevel2Order[bSkillLevel] or 999

		return aOrder < bOrder
	end

	return a.id > b.id
end

function SummonCustomPickChoiceListModel:initList()
	local charIdList = self:getCharIdList()

	self.noGainList = {}
	self.ownList = {}

	for _, characterId in ipairs(charIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(characterId)

		if mo:hasHero() then
			table.insert(self.ownList, mo)
		else
			table.insert(self.noGainList, mo)
		end
	end

	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	if summonPoolCfg and summonPoolCfg.type ~= SummonEnum.Type.CustomPick then
		table.sort(self.ownList, sortFunc)
		table.sort(self.noGainList, sortFunc)
	end
end

function SummonCustomPickChoiceListModel:setSelectId(heroId)
	if not self._selectIdList then
		return
	end

	if self._selectIdMap[heroId] then
		self._selectIdMap[heroId] = nil

		tabletool.removeValue(self._selectIdList, heroId)
	else
		self._selectIdMap[heroId] = true

		table.insert(self._selectIdList, heroId)
	end
end

function SummonCustomPickChoiceListModel:clearSelectIds()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function SummonCustomPickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function SummonCustomPickChoiceListModel:getMaxSelectCount()
	return SummonCustomPickModel.instance:getMaxSelectCount(self._poolId)
end

function SummonCustomPickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function SummonCustomPickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

function SummonCustomPickChoiceListModel:getPoolId()
	return self._poolId
end

function SummonCustomPickChoiceListModel:getPoolType()
	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	return summonPoolCfg.type or SummonEnum.Type.Normal
end

function SummonCustomPickChoiceListModel:getCharIdList()
	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	if summonPoolCfg.type == SummonEnum.Type.StrongCustomOnePick then
		local summonIdStr = summonPoolCfg.param
		local summonIds = string.splitToNumber(summonIdStr, "#")

		return summonIds
	end

	local rare2Cfg = SummonConfig.instance:getSummon(self._poolId)

	if rare2Cfg then
		local summonIdStr = rare2Cfg[SummonEnum.CustomPickRare].summonId
		local summonIds = string.splitToNumber(summonIdStr, "#")

		return summonIds
	end

	return {}
end

SummonCustomPickChoiceListModel.instance = SummonCustomPickChoiceListModel.New()

return SummonCustomPickChoiceListModel
