module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.Activity201MaLiAnNaController", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isPlayBurn = false
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0:onInit()
end

function var_0_0._onGameFinished(arg_5_0, arg_5_1, arg_5_2)
	if not Activity201MaLiAnNaModel.instance:isEpisodePass(arg_5_2) then
		if Activity201MaLiAnNaModel.instance:checkEpisodeIsGame(arg_5_2) and not Activity201MaLiAnNaModel.instance:checkEpisodeFinishGame(arg_5_2) then
			Activity203Rpc.instance:sendAct203SaveEpisodeProgressRequest(arg_5_1, arg_5_2)
		end

		local var_5_0 = Activity201MaLiAnNaConfig.instance:getStoryClear(arg_5_1, arg_5_2)

		function arg_5_0._sendCallBack()
			Activity201MaLiAnNaModel.instance:setNewFinishEpisode(arg_5_2)
			arg_5_0:openResultView({
				isWin = true,
				episodeId = arg_5_2
			})
		end

		function arg_5_0._afterFinishStory()
			Activity203Rpc.instance:sendGetAct203FinishEpisodeRequest(arg_5_1, arg_5_2, arg_5_0._sendCallBack, arg_5_0)
		end

		if var_5_0 and var_5_0 ~= 0 then
			var_0_0.instance:stopBurnAudio()
			StoryController.instance:playStory(var_5_0, nil, arg_5_0._afterFinishStory, arg_5_0, {
				isWin = true,
				episodeId = arg_5_2
			})
		else
			arg_5_0:_afterFinishStory()
		end
	else
		arg_5_0:_playStoryClear(arg_5_2)
	end
end

function var_0_0.onFinishEpisode(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	local var_8_0 = arg_8_3.activityId
	local var_8_1 = arg_8_3.episodeId

	Activity201MaLiAnNaModel.instance:setNewFinishEpisode(var_8_1)
	arg_8_0:_playStoryClear(var_8_1)
end

function var_0_0._playStoryClear(arg_9_0, arg_9_1)
	if not Activity201MaLiAnNaModel.instance:isEpisodePass(arg_9_1) then
		return
	end

	local var_9_0 = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local var_9_1 = Activity201MaLiAnNaConfig.instance:getStoryClear(var_9_0, arg_9_1)

	if var_9_1 and var_9_1 ~= 0 then
		var_0_0.instance:stopBurnAudio()
		StoryController.instance:playStory(var_9_1, nil, arg_9_0.openResultView, arg_9_0, {
			isWin = true,
			episodeId = arg_9_1
		})
	else
		arg_9_0:openResultView({
			isWin = true,
			episodeId = arg_9_1
		})
	end
end

function var_0_0.openResultView(arg_10_0, arg_10_1)
	var_0_0.instance:startBurnAudio()

	local var_10_0 = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local var_10_1 = arg_10_1 and arg_10_1.episodeId

	if not var_10_0 or not var_10_1 then
		return
	end

	if not (Activity201MaLiAnNaConfig.instance:getEpisodeCo(var_10_0, var_10_1).gameId ~= 0) then
		arg_10_0:dispatchEvent(Activity201MaLiAnNaEvent.OnBackToLevel)
		arg_10_0:dispatchEvent(Activity201MaLiAnNaEvent.EpisodeFinished)

		return
	end

	ViewMgr.instance:openView(ViewName.MaLiAnNaResultView, {
		episodeId = var_10_1,
		isWin = arg_10_1.isWin
	})
end

function var_0_0.enterLevelView(arg_11_0)
	Activity203Rpc.instance:sendGetAct203InfoRequest(VersionActivity3_0Enum.ActivityId.MaLiAnNa, arg_11_0._onRecInfo, arg_11_0)
end

function var_0_0._onRecInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == 0 and arg_12_3.activityId == VersionActivity3_0Enum.ActivityId.MaLiAnNa then
		Activity201MaLiAnNaModel.instance:initInfos(arg_12_3.episodes)
		ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaGameMainView)
		ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaLevelView)
	end
end

function var_0_0.startBurnAudio(arg_13_0)
	if arg_13_0._isPlayBurn then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_burn_loop)

	arg_13_0._isPlayBurn = true
end

function var_0_0.stopBurnAudio(arg_14_0)
	if arg_14_0._isPlayBurn then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_burn_loop)

		arg_14_0._isPlayBurn = false
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
