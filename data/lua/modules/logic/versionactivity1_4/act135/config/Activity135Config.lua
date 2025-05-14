module("modules.logic.versionactivity1_4.act135.config.Activity135Config", package.seeall)

local var_0_0 = class("Activity135Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.rewardDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity135_reward"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_1, arg_3_2)
	end
end

function var_0_0.onactivity135_rewardConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.rewardDict = arg_4_2.configDict
end

function var_0_0.getEpisodeCos(arg_5_0, arg_5_1)
	return arg_5_0.rewardDict[arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
