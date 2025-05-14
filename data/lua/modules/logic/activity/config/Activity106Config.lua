module("modules.logic.activity.config.Activity106Config", package.seeall)

local var_0_0 = class("Activity106Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act106Task = nil
	arg_1_0._act106Order = nil
	arg_1_0._act106MiniGame = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity106_task" then
		arg_3_0._act106Task = arg_3_2
	elseif arg_3_1 == "activity106_order" then
		arg_3_0._act106Order = arg_3_2
	elseif arg_3_1 == "activity106_minigame" then
		arg_3_0._act106MiniGame = arg_3_2
	end
end

function var_0_0.getActivityWarmUpTaskCo(arg_4_0, arg_4_1)
	return arg_4_0._act106Task.configDict[arg_4_1]
end

function var_0_0.getTaskByActId(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._act106Task.configList) do
		if iter_5_1.activityId == arg_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.getActivityWarmUpAllOrderCo(arg_6_0, arg_6_1)
	return arg_6_0._act106Order.configDict[arg_6_1]
end

function var_0_0.getActivityWarmUpOrderCo(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._act106Order.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getMiniGameSettings(arg_8_0, arg_8_1)
	return arg_8_0._act106MiniGame.configDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
