-- chunkname: @modules/logic/versionactivity1_4/act136/model/Activity136ChoiceViewListModel.lua

module("modules.logic.versionactivity1_4.act136.model.Activity136ChoiceViewListModel", package.seeall)

local Activity136ChoiceViewListModel = class("Activity136ChoiceViewListModel", ListScrollModel)

function Activity136ChoiceViewListModel:onInit()
	self:clear()
end

function Activity136ChoiceViewListModel:reInit()
	self:clear()
end

local function _sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo and true or false
	local bHasHero = bHeroMo and true or false

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	local aSkillLevel = aHeroMo and aHeroMo.exSkillLevel or -1
	local bSkillLevel = bHeroMo and bHeroMo.exSkillLevel or -1

	if aSkillLevel ~= bSkillLevel then
		return aSkillLevel < bSkillLevel
	end

	return a.id < b.id
end

function Activity136ChoiceViewListModel:setSelfSelectedCharacterList()
	local actId = Activity136Controller.instance:actId()
	local selfSelectedCharacterList = Activity136Config.instance:getSelfSelectCharacterIdList(actId)
	local list = {}

	for _, characterId in ipairs(selfSelectedCharacterList) do
		local mo = {}

		mo.id = characterId

		table.insert(list, mo)
	end

	table.sort(list, _sortFunc)
	self:setList(list)
end

Activity136ChoiceViewListModel.instance = Activity136ChoiceViewListModel.New()

return Activity136ChoiceViewListModel
