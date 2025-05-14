module("modules.logic.versionactivity1_3.va3chess.config.Va3ChessConfig", package.seeall)

local var_0_0 = class("Va3ChessConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0._registerConfigIns(arg_4_0)
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Config.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Config.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Config.instance
	}
end

function var_0_0._getConfigIns(arg_5_0, arg_5_1)
	if not arg_5_0._configMap then
		arg_5_0._configMap = arg_5_0:_registerConfigIns()

		local var_5_0 = {
			"getInteractObjectCo",
			"getMapCo",
			"getEpisodeCo"
		}

		for iter_5_0, iter_5_1 in pairs(arg_5_0._configMap) do
			for iter_5_2, iter_5_3 in ipairs(var_5_0) do
				if not iter_5_1[iter_5_3] or type(iter_5_1[iter_5_3]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", iter_5_1.__cname, iter_5_3))
				end
			end
		end
	end

	if not arg_5_0._configMap[arg_5_1] then
		logError(string.format("version activity Id[%s] 没注册", arg_5_1))
	end

	return arg_5_0._configMap[arg_5_1]
end

function var_0_0.getInteractObjectCo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:_getConfigIns(arg_6_1)

	if var_6_0 then
		if var_6_0.getInteractObjectCo then
			return var_6_0:getInteractObjectCo(arg_6_1, arg_6_2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getInteractObjectCo接口", arg_6_1, var_6_0.__cname))
		end
	end

	return nil
end

function var_0_0.getMapCo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:_getConfigIns(arg_7_1)

	if var_7_0 then
		if var_7_0.getMapCo then
			return var_7_0:getMapCo(arg_7_1, arg_7_2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", arg_7_1, var_7_0.__cname))
		end
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:_getConfigIns(arg_8_1)

	if var_8_0 then
		if var_8_0.getEpisodeCo then
			return var_8_0:getEpisodeCo(arg_8_1, arg_8_2)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getMapCo接口", arg_8_1, var_8_0.__cname))
		end
	end

	return nil
end

function var_0_0.isStoryEpisode(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:_getConfigIns(arg_9_1)

	if var_9_0 and var_9_0.isStoryEpisode then
		return var_9_0:isStoryEpisode(arg_9_1, arg_9_2)
	end

	return false
end

function var_0_0.getTipsCfg(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:_getConfigIns(arg_10_1)

	if var_10_0 and var_10_0.getTipsCfg then
		return var_10_0:getTipsCfg(arg_10_1, arg_10_2)
	end

	return nil
end

function var_0_0.getChapterEpisodeId(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:_getConfigIns(arg_11_1)

	if var_11_0 then
		if var_11_0.getChapterEpisodeId then
			return var_11_0:getChapterEpisodeId(arg_11_1)
		else
			logError(string.format("version activity Id[%s]注册类[%s]无 getChapterEpisodeId 接口", arg_11_1, var_11_0.__cname))
		end
	end

	return nil
end

function var_0_0.getEffectCo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:_getConfigIns(arg_12_1)

	if var_12_0 and var_12_0.getEffectCo then
		return var_12_0:getEffectCo(arg_12_1, arg_12_2)
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
