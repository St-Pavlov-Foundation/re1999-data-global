-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/model/V2a8_WuErLiXiGiftModel.lua

module("modules.logic.versionactivity2_8.wuerlixigift.model.V2a8_WuErLiXiGiftModel", package.seeall)

local V2a8_WuErLiXiGiftModel = class("V2a8_WuErLiXiGiftModel", BaseModel)

V2a8_WuErLiXiGiftModel.REWARD_INDEX = 1

function V2a8_WuErLiXiGiftModel:getV2a8_WuErLiXiGiftActId()
	return ActivityEnum.Activity.V2a8_WuErLiXiGift
end

function V2a8_WuErLiXiGiftModel:isV2a8_WuErLiXiGiftOpen()
	local result = false
	local actId = self:getV2a8_WuErLiXiGiftActId()

	if ActivityType101Model.instance:isOpen(actId) then
		result = true
	end

	return result
end

function V2a8_WuErLiXiGiftModel:isShowRedDot()
	local result = false
	local actId = self:getV2a8_WuErLiXiGiftActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if isOpen then
		result = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
	end

	return result
end

V2a8_WuErLiXiGiftModel.instance = V2a8_WuErLiXiGiftModel.New()

return V2a8_WuErLiXiGiftModel
