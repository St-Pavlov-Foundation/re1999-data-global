module("modules.logic.versionactivity1_7.doubledrop.config.DoubleDropConfig", package.seeall)

local var_0_0 = class("DoubleDropConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity153",
		"activity153_extra_bonus"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._actCfgDict = {}
	arg_2_0._actEpisodeDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.onactivity153ConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._actCfgDict = arg_4_1.configDict
end

function var_0_0.onactivity153_extra_bonusConfigLoaded(arg_5_0, arg_5_1)
	arg_5_0._actEpisodeDict = arg_5_1.configDict
end

function var_0_0.getAct153Co(arg_6_0, arg_6_1)
	return arg_6_0._actCfgDict[arg_6_1]
end

function var_0_0.getAct153ExtraBonus(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._actEpisodeDict[arg_7_1] and arg_7_0._actEpisodeDict[arg_7_1][arg_7_2]

	return var_7_0 and var_7_0.extraBonus
end

function var_0_0.getAct153ActEpisodes(arg_8_0, arg_8_1)
	return arg_8_0._actEpisodeDict[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
