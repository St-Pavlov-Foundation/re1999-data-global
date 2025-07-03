module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6InfoMo", package.seeall)

local var_0_0 = pureTable("LengZhou6InfoMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.actId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.isFinish = arg_1_3

	local var_1_0 = LengZhou6Config.instance:getEpisodeConfig(arg_1_0.actId, arg_1_0.episodeId)

	if var_1_0 == nil then
		logError("config is nil" .. arg_1_2)

		return
	end

	arg_1_0._config = var_1_0
	arg_1_0.preEpisodeId = var_1_0.preEpisodeId
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0:updateIsFinish(arg_2_1.isFinished)

	arg_2_0.progress = arg_2_1.progress
end

function var_0_0.updateIsFinish(arg_3_0, arg_3_1)
	arg_3_0.isFinish = arg_3_1
end

function var_0_0.updateProgress(arg_4_0, arg_4_1)
	arg_4_0.progress = arg_4_1
end

function var_0_0.isEndlessEpisode(arg_5_0)
	return LengZhou6Model.instance:getEpisodeIsEndLess(arg_5_0._config)
end

function var_0_0.getEpisodeName(arg_6_0)
	return arg_6_0._config.name
end

function var_0_0.haveEliminate(arg_7_0)
	return arg_7_0._config.eliminateLevelId ~= 0
end

function var_0_0.isDown(arg_8_0)
	return arg_8_0.episodeId % 2 ~= 0
end

function var_0_0.canShowItem(arg_9_0)
	if arg_9_0:isEndlessEpisode() then
		return arg_9_0:unLock()
	end

	return true
end

function var_0_0.unLock(arg_10_0)
	local var_10_0 = arg_10_0.preEpisodeId

	return var_10_0 == 0 or LengZhou6Model.instance:isEpisodeFinish(var_10_0)
end

function var_0_0.getLevel(arg_11_0)
	if not string.nilorempty(arg_11_0.progress) then
		return cjson.decode(arg_11_0.progress).endLessLayer or LengZhou6Enum.DefaultEndLessBeginRound
	end

	return LengZhou6Enum.DefaultEndLessBeginRound
end

function var_0_0.getEndLessBattleProgress(arg_12_0)
	if not string.nilorempty(arg_12_0.progress) then
		return cjson.decode(arg_12_0.progress).endLessBattleProgress
	end

	return nil
end

function var_0_0.setProgress(arg_13_0, arg_13_1)
	arg_13_0.progress = arg_13_1
end

return var_0_0
