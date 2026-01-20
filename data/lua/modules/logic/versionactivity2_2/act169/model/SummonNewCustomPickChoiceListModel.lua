-- chunkname: @modules/logic/versionactivity2_2/act169/model/SummonNewCustomPickChoiceListModel.lua

module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickChoiceListModel", package.seeall)

local SummonNewCustomPickChoiceListModel = class("SummonNewCustomPickChoiceListModel", ListScrollModel)

function SummonNewCustomPickChoiceListModel:onInit()
	self:clear()
end

function SummonNewCustomPickChoiceListModel:reInit()
	self:clear()
end

function SummonNewCustomPickChoiceListModel:initDatas(actId)
	self._actId = actId
	self._selectIdList = {}
	self._selectIdMap = {}

	self:initList()
end

SummonNewCustomPickChoiceListModel.SkillLevel2Order = {
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
		local aOrder = SummonNewCustomPickChoiceListModel.SkillLevel2Order[aSkillLevel] or 999
		local bOrder = SummonNewCustomPickChoiceListModel.SkillLevel2Order[bSkillLevel] or 999

		return aOrder < bOrder
	end

	return a.id < b.id
end

function SummonNewCustomPickChoiceListModel:initList()
	local charIdList = self:getCharIdList()

	self.ownList = {}
	self.noGainList = {}

	for _, characterId in ipairs(charIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(characterId)

		if mo:hasHero() then
			table.insert(self.ownList, mo)
		else
			table.insert(self.noGainList, mo)
		end
	end

	table.sort(self.ownList, sortFunc)
	table.sort(self.noGainList, sortFunc)
end

function SummonNewCustomPickChoiceListModel:haveAllRole()
	return self._actId and self.noGainList and #self.noGainList <= 0
end

function SummonNewCustomPickChoiceListModel:setSelectId(heroId)
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

	SummonNewCustomPickChoiceController.instance:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function SummonNewCustomPickChoiceListModel:clearSelectIds()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function SummonNewCustomPickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function SummonNewCustomPickChoiceListModel:getMaxSelectCount()
	return SummonNewCustomPickViewModel.instance:getMaxSelectCount(self._actId)
end

function SummonNewCustomPickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function SummonNewCustomPickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

function SummonNewCustomPickChoiceListModel:getActivityId()
	return self._actId
end

function SummonNewCustomPickChoiceListModel:getCharIdList()
	local summonConfig = SummonNewCustomPickViewConfig.instance:getSummonConfigById(self._actId)

	if summonConfig then
		local summonIdStr = summonConfig.heroIds
		local summonIds = string.splitToNumber(summonIdStr, "#")

		return summonIds
	end

	return {}
end

SummonNewCustomPickChoiceListModel.instance = SummonNewCustomPickChoiceListModel.New()

return SummonNewCustomPickChoiceListModel
