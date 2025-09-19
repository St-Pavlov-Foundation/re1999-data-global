module("modules.logic.versionactivity2_8.molideer.controller.MoLiDeErController", package.seeall)

local var_0_0 = class("MoLiDeErController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.enterEpisode(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = MoLiDeErConfig.instance:getEpisodeConfig(arg_5_1, arg_5_2)

	if var_5_0 == nil then
		logError("莫莉德尔活动 关卡不存在 actId:" .. arg_5_1 .. "关卡id" .. arg_5_2)

		return
	end

	MoLiDeErModel.instance:setCurEpisodeData(arg_5_1, arg_5_2, var_5_0)

	local var_5_1 = MoLiDeErModel.instance:haveEpisodeProgress(arg_5_1, arg_5_2)

	if arg_5_0:_checkStory(var_5_0.beforeStory) and not var_5_1 then
		arg_5_0:_playStory(var_5_0.beforeStory, arg_5_0.beforeStoryFinish, arg_5_0)
	else
		arg_5_0:beforeStoryFinish()
	end
end

function var_0_0.enterLevelView(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._openEpisodeId = arg_6_2

	MoLiDeErRpc.instance:sendAct194GetInfosRequest(arg_6_1, arg_6_0.onReceiveInfo, arg_6_0)
end

function var_0_0.onReceiveInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == 0 then
		ViewMgr.instance:openView(ViewName.MoLiDeErLevelView, {
			episodeId = arg_7_0._openEpisodeId
		})
	end

	arg_7_0._openEpisodeId = nil
end

function var_0_0.onReceiveEpisodeInfo(arg_8_0, arg_8_1, arg_8_2)
	MoLiDeErModel.instance:onEpisodeRecordsPush(arg_8_1, arg_8_2)
end

function var_0_0.beforeStoryFinish(arg_9_0)
	local var_9_0 = MoLiDeErModel.instance:getCurEpisode()

	if not var_9_0 then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	if arg_9_0:_checkGame(var_9_0.gameId) then
		local var_9_1 = MoLiDeErModel.instance:getCurActId()

		if MoLiDeErModel.instance:getEpisodeInfoMo(var_9_1, var_9_0.episodeId):isInProgress() then
			MoLiDeErGameController.instance:resumeGame(var_9_1, var_9_0.episodeId)
		else
			MoLiDeErGameController.instance:startGame(var_9_1, var_9_0.episodeId)
		end
	else
		arg_9_0:gameFinish()
	end
end

function var_0_0.gameFinish(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = MoLiDeErModel.instance:getCurEpisode()

	if not var_10_0 then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	arg_10_0._finishCallback = arg_10_1
	arg_10_0._finishCallbackObj = arg_10_2

	if arg_10_0:_checkStory(var_10_0.afterStory) then
		arg_10_0:_playStory(var_10_0.afterStory, arg_10_0.afterStoryFinish, arg_10_0)
	else
		arg_10_0:afterStoryFinish()
	end
end

function var_0_0.afterStoryFinish(arg_11_0)
	local var_11_0 = MoLiDeErModel.instance:getCurEpisode()

	if not var_11_0 then
		logError("莫莉德尔活动，没有关卡数据")

		return
	end

	if arg_11_0:_checkGame(var_11_0.gameId) then
		arg_11_0:episodeFinish(var_11_0.activityId, var_11_0.episodeId)
	else
		arg_11_0:storyEpisodeFinish(var_11_0.activityId, var_11_0.episodeId)
	end

	if arg_11_0._finishCallback and arg_11_0._finishCallbackObj then
		arg_11_0._finishCallback(arg_11_0._finishCallbackObj)
	end

	arg_11_0._finishCallback = nil
	arg_11_0._finishCallbackObj = nil
end

function var_0_0.episodeFinish(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = MoLiDeErGameModel.instance:getSkipGameTrigger(arg_12_1, arg_12_2)

	if var_12_0 then
		MoLiDeErGameModel.instance:setSkipGameTrigger(arg_12_1, arg_12_2, false)
	end

	arg_12_0:dispatchEvent(MoLiDeErEvent.OnFinishEpisode, arg_12_1, arg_12_2, var_12_0)
end

function var_0_0.storyEpisodeFinish(arg_13_0, arg_13_1, arg_13_2)
	MoLiDeErRpc.instance:sendAct194FinishStoryEpisodeRequest(arg_13_1, arg_13_2)
end

function var_0_0._playStory(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	var_14_0.blur = true
	var_14_0.hideStartAndEndDark = true
	var_14_0.mark = true
	var_14_0.isReplay = false

	StoryController.instance:playStory(arg_14_1, var_14_0, arg_14_2, arg_14_3)
end

function var_0_0._checkStory(arg_15_0, arg_15_1)
	if arg_15_1 == nil or arg_15_1 == 0 then
		return false
	end

	return true
end

function var_0_0._checkGame(arg_16_0, arg_16_1)
	if arg_16_1 == nil or arg_16_1 == 0 then
		return false
	end

	return true
end

function var_0_0.statGameStart(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._statGameStartTime = Time.time
	arg_17_0._statActId = arg_17_1
	arg_17_0._statEpisodeId = arg_17_2
end

function var_0_0.statGameExit(arg_18_0, arg_18_1)
	if arg_18_0._statGameStartTime and arg_18_0._statActId and arg_18_0._statEpisodeId then
		local var_18_0 = Time.time - arg_18_0._statGameStartTime

		StatController.instance:track(StatEnum.EventName.MoLiDeEr_Act194GameViewExit, {
			[StatEnum.EventProperties.MoLiDeEr_From] = arg_18_1,
			[StatEnum.EventProperties.Usetime_Num] = var_18_0,
			[StatEnum.EventProperties.ActivityId] = tostring(arg_18_0._statActId),
			[StatEnum.EventProperties.EpisodeId_Num] = arg_18_0._statEpisodeId
		})
	end

	arg_18_0._statGameStartTime = nil
	arg_18_0._statActId = nil
	arg_18_0._statEpisodeId = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
