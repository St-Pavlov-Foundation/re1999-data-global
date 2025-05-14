module("modules.logic.endofdream.config.EndOfDreamConfig", package.seeall)

local var_0_0 = class("EndOfDreamConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._levelConfig = nil
	arg_1_0._episodeConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getLevelConfig(arg_4_0, arg_4_1)
	return arg_4_0._levelConfig.configDict[arg_4_1]
end

function var_0_0.getLevelConfigList(arg_5_0)
	return arg_5_0._levelConfig.configList
end

function var_0_0.getLevelConfigByEpisodeId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getLevelConfigList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.episodeId == arg_6_1 then
			return iter_6_1, false
		elseif iter_6_1.hardEpisodeId == arg_6_1 then
			return iter_6_1, true
		end
	end
end

function var_0_0.getFirstLevelConfig(arg_7_0)
	return arg_7_0:getLevelConfigList()[1]
end

function var_0_0.getEpisodeConfig(arg_8_0, arg_8_1)
	return
end

function var_0_0.getEpisodeConfigByLevelId(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getLevelConfig(arg_9_1)

	return var_9_0 and var_9_0.hardEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
