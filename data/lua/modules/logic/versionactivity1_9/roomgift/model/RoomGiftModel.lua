module("modules.logic.versionactivity1_9.roomgift.model.RoomGiftModel", package.seeall)

local var_0_0 = class("RoomGiftModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:setActivityInfo()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getActId(arg_3_0)
	return ActivityEnum.Activity.RoomGift
end

function var_0_0.setActivityInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 or {}

	arg_4_0:setCurDay(var_4_0.currentDay)
	arg_4_0:setHasGotBonus(var_4_0.hasGetBonus)
end

function var_0_0.setCurDay(arg_5_0, arg_5_1)
	arg_5_0._curDay = arg_5_1
end

function var_0_0.setHasGotBonus(arg_6_0, arg_6_1)
	arg_6_0._hasGotBonus = arg_6_1
end

function var_0_0.getHasGotBonus(arg_7_0)
	return arg_7_0._hasGotBonus
end

function var_0_0.isActOnLine(arg_8_0, arg_8_1)
	local var_8_0 = false
	local var_8_1 = arg_8_0:getActId()
	local var_8_2, var_8_3, var_8_4 = ActivityHelper.getActivityStatusAndToast(var_8_1, true)

	if var_8_2 == ActivityEnum.ActivityStatus.Normal then
		var_8_0 = true
	elseif arg_8_1 and var_8_3 then
		GameFacade.showToastWithTableParam(var_8_3, var_8_4)
	end

	return var_8_0
end

function var_0_0.isCanGetBonus(arg_9_0)
	local var_9_0 = false

	if arg_9_0:isActOnLine() then
		local var_9_1 = arg_9_0:getActId()

		if RoomGiftConfig.instance:getRoomGiftBonus(var_9_1, arg_9_0._curDay) then
			local var_9_2 = arg_9_0:getHasGotBonus()

			if var_9_2 ~= nil then
				var_9_0 = not var_9_2
			end
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
