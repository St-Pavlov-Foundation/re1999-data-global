-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/model/DecalogPresentModel.lua

module("modules.logic.versionactivity1_6.decalogpresent.model.DecalogPresentModel", package.seeall)

local DecalogPresentModel = class("DecalogPresentModel", BaseModel)

DecalogPresentModel.REWARD_INDEX = 1

function DecalogPresentModel:getDecalogPresentActId()
	return ActivityEnum.Activity.V2a8_DecaLogPresent
end

function DecalogPresentModel:isDecalogPresentOpen()
	local result = false
	local actId = self:getDecalogPresentActId()

	if ActivityType101Model.instance:isOpen(actId) then
		result = true
	end

	return result
end

function DecalogPresentModel:isShowRedDot()
	local result = false
	local actId = self:getDecalogPresentActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if isOpen then
		result = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
	end

	return result
end

DecalogPresentModel.instance = DecalogPresentModel.New()

return DecalogPresentModel
