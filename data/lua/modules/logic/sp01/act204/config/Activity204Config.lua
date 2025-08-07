module("modules.logic.sp01.act204.config.Activity204Config", package.seeall)

local var_0_0 = class("Activity204Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity204_const",
		"actvity204_stage",
		"actvity204_task",
		"actvity204_voice",
		"actvity204_milestone_bonus"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.format("_on%sLoad", arg_2_1)

	if arg_2_0[var_2_0] then
		arg_2_0[var_2_0](arg_2_0, arg_2_2)
	end
end

function var_0_0._onactvity204_stageLoad(arg_3_0, arg_3_1)
	arg_3_0.stageConfig = arg_3_1
end

function var_0_0._onactvity204_milestone_bonusLoad(arg_4_0, arg_4_1)
	arg_4_0.mileStoneConfig = arg_4_1
end

function var_0_0._onactivity204_constLoad(arg_5_0, arg_5_1)
	arg_5_0.constConfig = arg_5_1
end

function var_0_0._onactvity204_taskLoad(arg_6_0, arg_6_1)
	arg_6_0.taskConfig = arg_6_1
end

function var_0_0._onactvity204_voiceLoad(arg_7_0, arg_7_1)
	arg_7_0.voiceConfig = arg_7_1
end

function var_0_0.getStageConfig(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.stageConfig.configDict[arg_8_1]

	return var_8_0 and var_8_0[arg_8_2]
end

function var_0_0.getMileStoneList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.mileStoneConfig.configDict[arg_9_1]
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		table.insert(var_9_1, iter_9_1)
	end

	table.sort(var_9_1, SortUtil.keyLower("coinNum"))

	return var_9_1
end

function var_0_0.getMileStoneConfig(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.mileStoneConfig.configDict[arg_10_1]

	return var_10_0 and var_10_0[arg_10_2]
end

function var_0_0.getVoiceConfig(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.voiceConfig.configList) do
		if iter_11_1.type == arg_11_1 and (not arg_11_2 or arg_11_2(iter_11_1)) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.getTaskConfig(arg_12_0, arg_12_1)
	return arg_12_0.taskConfig.configDict[arg_12_1]
end

function var_0_0.getConstNum(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getConstStr(arg_13_1)

	if string.nilorempty(var_13_0) then
		return 0
	else
		return tonumber(var_13_0)
	end
end

function var_0_0.getConstStr(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.constConfig.configDict[arg_14_1]

	if not var_14_0 then
		return nil
	end

	local var_14_1 = var_14_0.value

	if not string.nilorempty(var_14_1) then
		return var_14_1
	end

	return var_14_0.value2
end

var_0_0.instance = var_0_0.New()

return var_0_0
