-- chunkname: @modules/logic/pickassist/model/PickAssistListModel.lua

module("modules.logic.pickassist.model.PickAssistListModel", package.seeall)

local PickAssistListModel = class("PickAssistListModel", ListScrollModel)
local DEFAULT_CAREER = CharacterEnum.CareerType.Yan
local ActId2PickAssistViewName = {}
local assistType2PickAssistViewName = {
	[PickAssistEnum.Type.Rouge] = "RougePickAssistView",
	[PickAssistEnum.Type.Survival] = "SurvivalPickAssistView"
}

local function createPickAssistHeroMO(dungeonAssistHeroMo)
	if not dungeonAssistHeroMo then
		return
	end

	local heroInfo = dungeonAssistHeroMo:getHeroInfo()
	local mo = PickAssistHeroMO.New()

	mo:init(heroInfo)

	return mo
end

function PickAssistListModel:onInit()
	self:clearData()
end

function PickAssistListModel:reInit()
	self:onInit()
end

function PickAssistListModel:clearData()
	self.activityId = nil
	self.career = nil
	self.selectMO = nil
end

function PickAssistListModel:onCloseView()
	self:clear()
	self:clearData()
end

function PickAssistListModel:init(actId, assistType, selectedHeroUid)
	self.activityId = actId
	self._assistType = assistType

	if not self.career then
		self:setCareer(DEFAULT_CAREER)
	end

	self:initSelectedMO(selectedHeroUid)
	self:updateDatas()
end

function PickAssistListModel:initSelectedMO(selectedHeroUid)
	self:setHeroSelect()

	local assistType = self:getAssistType()
	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(assistType)

	if not dungeonAssistList then
		return
	end

	for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
		local assistUid = dungeonAssistHeroMo:getHeroUid()

		if assistUid == selectedHeroUid then
			local mo = createPickAssistHeroMO(dungeonAssistHeroMo)

			self:setHeroSelect(mo, true)

			break
		end
	end
end

function PickAssistListModel:updateDatas()
	if not self.activityId or not self.career then
		return
	end

	self:setListByCareer()
end

function PickAssistListModel:setListByCareer()
	local list = {}
	local lastSelectMO = self:getSelectedMO()

	self:setHeroSelect()

	local assistType = self:getAssistType()
	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(assistType, self.career)

	if dungeonAssistList then
		for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
			local mo = createPickAssistHeroMO(dungeonAssistHeroMo)
			local career = mo and mo:getCareer()

			if mo and career == self.career then
				table.insert(list, mo)

				if lastSelectMO and lastSelectMO:isSameHero(mo) then
					self:setHeroSelect(mo, true)
				end
			end
		end
	end

	self:setList(list)
	PickAssistController.instance:dispatchEvent(PickAssistEvent.SetCareer)
end

function PickAssistListModel:getPickAssistViewName()
	local result = ViewName.PickAssistView

	result = self.activityId and ActId2PickAssistViewName[self.activityId] or result
	result = self._assistType and assistType2PickAssistViewName[self._assistType] or result

	return result
end

function PickAssistListModel:getCareer()
	return self.career
end

function PickAssistListModel:getSelectedMO()
	return self.selectMO
end

function PickAssistListModel:isHeroSelected(assistMO)
	local result = false
	local selectMO = self:getSelectedMO()

	if selectMO then
		result = selectMO:isSameHero(assistMO)
	end

	return result
end

function PickAssistListModel:isHasAssistList()
	local isHasAssists = false
	local assistList = self:getList()

	if assistList then
		isHasAssists = #assistList > 0
	end

	return isHasAssists
end

function PickAssistListModel:getAssistType()
	if not self._assistType then
		logError("PickAssistListModel:getAssistType error, not set assistType")
	end

	return self._assistType
end

function PickAssistListModel:setCareer(career)
	if self.career ~= career then
		self.career = career

		self:updateDatas()
	end
end

function PickAssistListModel:setHeroSelect(assistMO, value)
	if value then
		self.selectMO = assistMO
	else
		self.selectMO = nil
	end

	PickAssistController.instance:dispatchEvent(PickAssistEvent.RefreshSelectAssistHero)
end

PickAssistListModel.instance = PickAssistListModel.New()

return PickAssistListModel
