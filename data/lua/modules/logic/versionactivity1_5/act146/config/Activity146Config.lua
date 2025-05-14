module("modules.logic.versionactivity1_5.act146.config.Activity146Config", package.seeall)

local var_0_0 = class("Activity146Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._configList = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity146"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity146" then
		arg_3_0._configList = arg_3_2.configDict
	end
end

function var_0_0.getEpisodeConfig(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0._configList[arg_4_1][arg_4_2]
end

function var_0_0.getAllEpisodeConfigs(arg_5_0, arg_5_1)
	return arg_5_0._configList and arg_5_0._configList[arg_5_1]
end

function var_0_0.getEpisodeRewardConfig(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._configList and arg_6_0._configList[arg_6_1] and arg_6_0._configList[arg_6_1][arg_6_2] then
		local var_6_0 = arg_6_0._configList[arg_6_1][arg_6_2].bonus

		return (string.split(var_6_0, "|"))
	end
end

function var_0_0.getEpisodeDesc(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._configList and arg_7_0._configList[arg_7_1] and arg_7_0._configList[arg_7_1][arg_7_2] then
		return arg_7_0._configList[arg_7_1][arg_7_2].text
	end
end

function var_0_0.getEpisodeTitle(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._configList and arg_8_0._configList[arg_8_1] and arg_8_0._configList[arg_8_1][arg_8_2] then
		return arg_8_0._configList[arg_8_1][arg_8_2].name
	end
end

function var_0_0.getPreEpisodeConfig(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._configList and arg_9_0._configList[arg_9_1] and arg_9_0._configList[arg_9_1][arg_9_2] then
		local var_9_0 = arg_9_0._configList[arg_9_1][arg_9_2].preId

		return arg_9_0._configList[arg_9_1][var_9_0]
	end
end

function var_0_0.getEpisodePhoto(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._configList and arg_10_0._configList[arg_10_1] and arg_10_0._configList[arg_10_1][arg_10_2] then
		return arg_10_0._configList[arg_10_1][arg_10_2].photo
	end
end

function var_0_0.getEpisodeInteractType(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._configList and arg_11_0._configList[arg_11_1] and arg_11_0._configList[arg_11_1][arg_11_2] then
		return arg_11_0._configList[arg_11_1][arg_11_2].interactType or 1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
