module("modules.logic.versionactivity2_8.act196.model.Activity196Model", package.seeall)

local var_0_0 = class("Activity196Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.setActInfo(arg_2_0, arg_2_1)
	arg_2_0._rewardIdList = nil

	if arg_2_1 and #arg_2_1 > 0 then
		arg_2_0._rewardIdList = arg_2_1
	end
end

function var_0_0.updateRewardIdList(arg_3_0, arg_3_1)
	arg_3_0._rewardIdList = arg_3_0._rewardIdList or {}

	table.insert(arg_3_0._rewardIdList, arg_3_1)
end

function var_0_0.checkRewardReceied(arg_4_0, arg_4_1)
	if arg_4_0._rewardIdList and #arg_4_0._rewardIdList > 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._rewardIdList) do
			if iter_4_1 == arg_4_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkGetAllReward(arg_5_0)
	if not arg_5_0._rewardIdList then
		return false
	end

	local var_5_0 = Activity2ndConfig.instance:getRewardCount()

	if #arg_5_0._rewardIdList == var_5_0 then
		return true
	end

	return false
end

function var_0_0.reInit(arg_6_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
