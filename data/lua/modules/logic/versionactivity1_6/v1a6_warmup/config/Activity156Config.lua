module("modules.logic.versionactivity1_6.v1a6_warmup.config.Activity156Config", package.seeall)

local var_0_0 = class("Activity156Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._configTab = nil
	arg_1_0._channelValueList = {}
	arg_1_0._episodeCount = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity125"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity125" then
		arg_3_0._configTab = arg_3_2.configDict[ActivityEnum.Activity.Activity1_6WarmUp]
	end
end

function var_0_0.getActConfig(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 and arg_4_2 and arg_4_0._configTab and arg_4_0._configTab[arg_4_1] then
		return arg_4_0._configTab[arg_4_1][arg_4_2]
	end

	return nil
end

function var_0_0.getAct156Config(arg_5_0)
	return arg_5_0._configTab
end

function var_0_0.getEpisodeDesc(arg_6_0, arg_6_1)
	if arg_6_0._configTab and arg_6_0._configTab[arg_6_1] then
		return arg_6_0._configTab[arg_6_1].text
	end
end

function var_0_0.getEpisodeConfig(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._configTab) do
		if iter_7_1.id == arg_7_1 then
			return iter_7_1
		end
	end
end

function var_0_0.getEpisodeOpenDay(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getEpisodeConfig(arg_8_1)

	if var_8_0 then
		return var_8_0.openDay
	end
end

function var_0_0.getEpisodeRewardConfig(arg_9_0, arg_9_1)
	if arg_9_0._configTab and arg_9_0._configTab and arg_9_0._configTab[arg_9_1] then
		local var_9_0 = arg_9_0._configTab[arg_9_1].bonus

		return (string.split(var_9_0, "|"))
	end
end

function var_0_0.getPreEpisodeConfig(arg_10_0, arg_10_1)
	if arg_10_0._configTab and arg_10_0._configTab[arg_10_1] then
		local var_10_0 = arg_10_0._configTab[arg_10_1].preId

		return arg_10_0._configTab[var_10_0]
	end
end

function var_0_0.getEpisodeCount(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._episodeCount or tabletool.len(arg_11_0:getAct156Config(arg_11_1))

	arg_11_0._episodeCount = var_11_0

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
