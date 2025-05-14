module("modules.logic.versionactivity1_7.lantern.config.LanternFestivalConfig", package.seeall)

local var_0_0 = class("LanternFestivalConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity154",
		"activity154_options"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._actCfgDict = nil
	arg_2_0._actOptions = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity154" then
		arg_3_0._actCfgDict = arg_3_2.configDict
	elseif arg_3_1 == "activity154_options" then
		arg_3_0._actOptions = arg_3_2.configDict
	end
end

function var_0_0.getAct154Co(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or ActivityEnum.Activity.LanternFestival

	return arg_4_0._actCfgDict[arg_4_1][arg_4_2]
end

function var_0_0.getPuzzleCo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._actCfgDict[ActivityEnum.Activity.LanternFestival]) do
		if iter_5_1.puzzleId == arg_5_1 then
			return iter_5_1
		end
	end

	return nil
end

function var_0_0.getAct154Cos(arg_6_0)
	return arg_6_0._actCfgDict[ActivityEnum.Activity.LanternFestival]
end

function var_0_0.getAct154Options(arg_7_0, arg_7_1)
	return arg_7_0._actOptions[arg_7_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
