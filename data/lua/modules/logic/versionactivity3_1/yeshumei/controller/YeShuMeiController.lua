module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiController", package.seeall)

local var_0_0 = class("YeShuMeiController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0._onGameFinished(arg_5_0, arg_5_1, arg_5_2)
	if not YeShuMeiModel.instance:isEpisodePass(arg_5_2) then
		if YeShuMeiModel.instance:checkEpisodeIsGame(arg_5_2) and not YeShuMeiModel.instance:checkEpisodeFinishGame(arg_5_2) then
			YeShuMeiRpc.instance:sendAct211SaveEpisodeProgressRequest(arg_5_1, arg_5_2)
		end

		local var_5_0 = YeShuMeiConfig.instance:getStoryClear(arg_5_1, arg_5_2)

		function arg_5_0._sendCallBack()
			YeShuMeiModel.instance:setNewFinishEpisode(arg_5_2)
			arg_5_0:_finishEpisode({
				episodeId = arg_5_2
			})
		end

		function arg_5_0._afterFinishStory()
			YeShuMeiRpc.instance:sendGetAct211FinishEpisodeRequest(arg_5_1, arg_5_2, arg_5_0._sendCallBack, arg_5_0)
		end

		if var_5_0 and var_5_0 ~= 0 then
			StoryController.instance:playStory(var_5_0, nil, arg_5_0._afterFinishStory, arg_5_0, {
				episodeId = arg_5_2
			})
		else
			arg_5_0:_afterFinishStory()
		end
	else
		arg_5_0:_playStoryClear(arg_5_2)
	end
end

function var_0_0._playStoryClear(arg_8_0, arg_8_1)
	if not YeShuMeiModel.instance:isEpisodePass(arg_8_1) then
		return
	end

	local var_8_0 = VersionActivity3_1Enum.ActivityId.YeShuMei
	local var_8_1 = YeShuMeiConfig.instance:getStoryClear(var_8_0, arg_8_1)

	if var_8_1 and var_8_1 ~= 0 then
		StoryController.instance:playStory(var_8_1, nil, arg_8_0._finishEpisode, arg_8_0, {
			episodeId = arg_8_1
		})
	else
		arg_8_0:_finishEpisode({
			episodeId = arg_8_1
		})
	end
end

function var_0_0._finishEpisode(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1.episodeId
	local var_9_1 = VersionActivity3_1Enum.ActivityId.YeShuMei

	if not var_9_1 or not var_9_0 then
		return
	end

	if YeShuMeiConfig.instance:getEpisodeCo(var_9_1, var_9_0).gameId ~= 0 and ViewMgr.instance:isOpen(ViewName.YeShuMeiGameView) then
		YeShuMeiStatHelper.instance:sendGameFinish()
		ViewMgr.instance:closeView(ViewName.YeShuMeiGameView)
	end

	arg_9_0:dispatchEvent(YeShuMeiEvent.OnBackToLevel)
	arg_9_0:dispatchEvent(YeShuMeiEvent.EpisodeFinished)
end

function var_0_0.enterLevelView(arg_10_0, arg_10_1)
	arg_10_0._openEpisodeId = arg_10_1

	YeShuMeiRpc.instance:sendGetAct211InfoRequest(VersionActivity3_1Enum.ActivityId.YeShuMei, arg_10_0._onRecInfo, arg_10_0)
end

function var_0_0._onRecInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 and arg_11_3.activityId == VersionActivity3_1Enum.ActivityId.YeShuMei then
		YeShuMeiModel.instance:initInfos(arg_11_3.episodes)
		ViewMgr.instance:openView(ViewName.YeShuMeiLevelView, {
			episodeId = arg_11_0._openEpisodeId
		})

		arg_11_0._openEpisodeId = nil
	end
end

function var_0_0.reInit(arg_12_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
