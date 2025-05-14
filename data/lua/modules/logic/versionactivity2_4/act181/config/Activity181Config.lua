module("modules.logic.versionactivity2_4.act181.config.Activity181Config", package.seeall)

local var_0_0 = class("Activity181Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity181_box",
		"activity181_boxlist"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity181_box" then
		arg_3_0.activity181Config = arg_3_2
	elseif arg_3_1 == "activity181_boxlist" then
		arg_3_0.activity181BonusConfig = arg_3_2

		arg_3_0:initBoxListConfig()
	end
end

function var_0_0.getBoxConfig(arg_4_0, arg_4_1)
	if not arg_4_0.activity181Config then
		return nil
	end

	return arg_4_0.activity181Config.configDict[arg_4_1]
end

function var_0_0.initBoxListConfig(arg_5_0)
	arg_5_0._activityBoxListDic = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activity181BonusConfig.configList) do
		local var_5_0 = arg_5_0._activityBoxListDic[iter_5_1.activityId]

		if not var_5_0 then
			var_5_0 = {}
			arg_5_0._activityBoxListDic[iter_5_1.activityId] = var_5_0
		end

		table.insert(var_5_0, iter_5_1.id)
	end
end

function var_0_0.getBoxListConfig(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.activity181BonusConfig.configDict[arg_6_1] then
		return arg_6_0.activity181BonusConfig.configDict[arg_6_1][arg_6_2]
	end

	return nil
end

function var_0_0.getBoxListByActivityId(arg_7_0, arg_7_1)
	return arg_7_0._activityBoxListDic[arg_7_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
