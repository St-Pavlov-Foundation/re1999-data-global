module("modules.logic.main.controller.work.Activity101SignSpRewardPatFaceWork", package.seeall)

local var_0_0 = class("Activity101SignSpRewardPatFaceWork", Activity101SignPatFaceWork)

function var_0_0.isType101RewardCouldGetAnyOne(arg_1_0)
	if var_0_0.super.isType101RewardCouldGetAnyOne(arg_1_0) then
		return true
	end

	local var_1_0 = arg_1_0:_actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(var_1_0)
end

return var_0_0
