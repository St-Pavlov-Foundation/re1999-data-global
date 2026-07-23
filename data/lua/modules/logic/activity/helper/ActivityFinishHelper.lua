-- chunkname: @modules/logic/activity/helper/ActivityFinishHelper.lua

module("modules.logic.activity.helper.ActivityFinishHelper", package.seeall)

local ActivityFinishHelper = _M

function ActivityFinishHelper.CheckActivity13746Finish(actId)
	if ActivityType101Model.instance:isType101RewardGet(actId, 1) then
		local config = ActivityConfig.instance:getActivityCo(actId)
		local packageId = tonumber(config.patFaceParam)
		local storeGoodsMo = StoreModel.instance:getGoodsMO(packageId)

		if storeGoodsMo and storeGoodsMo:isSoldOut() then
			return true
		end
	end

	return false
end

function ActivityFinishHelper.CheckActivity138517Finish(actId)
	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	if not activityConfig then
		return true
	end

	if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
		return false
	end

	local linkGiftList = string.splitToNumber(activityConfig.patFaceParam, "#")

	if not linkGiftList or next(linkGiftList) == nil then
		return true
	end

	for _, linkGiftId in ipairs(linkGiftList) do
		local chargeGoodsMO = StoreModel.instance:getGoodsMO(linkGiftId)

		if not chargeGoodsMO or not chargeGoodsMO:isSoldOut() then
			return false
		end

		local config = StoreConfig.instance:getChargeGoodsConfig(linkGiftId)

		if config.taskid and config.taskid ~= 0 and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(linkGiftId) then
			return false
		end
	end

	return true
end

return ActivityFinishHelper
