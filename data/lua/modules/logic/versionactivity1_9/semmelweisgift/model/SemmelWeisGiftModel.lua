-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/model/SemmelWeisGiftModel.lua

module("modules.logic.versionactivity1_9.semmelweisgift.model.SemmelWeisGiftModel", package.seeall)

local SemmelWeisGiftModel = class("SemmelWeisGiftModel", BaseModel)

SemmelWeisGiftModel.REWARD_INDEX = 1

function SemmelWeisGiftModel:getSemmelWeisGiftActId()
	return ActivityEnum.Activity.V1a9_SemmelWeisGift
end

function SemmelWeisGiftModel:isSemmelWeisGiftOpen()
	local result = false
	local actId = self:getSemmelWeisGiftActId()

	if ActivityType101Model.instance:isOpen(actId) then
		result = true
	end

	return result
end

function SemmelWeisGiftModel:isShowRedDot()
	local result = false
	local actId = self:getSemmelWeisGiftActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if isOpen then
		result = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
	end

	return result
end

SemmelWeisGiftModel.instance = SemmelWeisGiftModel.New()

return SemmelWeisGiftModel
