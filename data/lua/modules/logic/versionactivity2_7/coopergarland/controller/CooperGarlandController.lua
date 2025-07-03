module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandController", package.seeall)

local var_0_0 = class("CooperGarlandController", BaseController)

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

function var_0_0.getAct192Info(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not CooperGarlandModel.instance:isAct192Open(arg_5_3) then
		return
	end

	local var_5_0 = CooperGarlandModel.instance:getAct192Id()

	Activity192Rpc.instance:sendGetAct192InfoRequest(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onGetAct192Info(arg_6_0, arg_6_1)
	CooperGarlandModel.instance:updateAct192Info(arg_6_1)
	arg_6_0:dispatchEvent(CooperGarlandEvent.OnAct192InfoUpdate)
end

function var_0_0.saveGameProgress(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not CooperGarlandModel.instance:isAct192Open(arg_7_3) then
		return
	end

	local var_7_0 = CooperGarlandModel.instance:getAct192Id()

	if not CooperGarlandModel.instance:isUnlockEpisode(var_7_0, arg_7_1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	Activity192Rpc.instance:sendAct192FinishEpisodeRequest(var_7_0, arg_7_1, tostring(arg_7_2), arg_7_0._onSaveGameProgress, arg_7_0)
end

function var_0_0._onSaveGameProgress(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	local var_8_0 = arg_8_3.activityId
	local var_8_1 = arg_8_3.episodeId
	local var_8_2 = arg_8_3.progress
	local var_8_3 = CooperGarlandModel.instance:isFinishedEpisode(var_8_0, var_8_1)

	CooperGarlandModel.instance:updateAct192Episode(var_8_0, var_8_1, var_8_3, var_8_2)
end

function var_0_0.finishEpisode(arg_9_0, arg_9_1, arg_9_2)
	if not CooperGarlandModel.instance:isAct192Open(arg_9_2) then
		return
	end

	local var_9_0 = CooperGarlandModel.instance:getAct192Id()

	if not CooperGarlandModel.instance:isUnlockEpisode(var_9_0, arg_9_1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if CooperGarlandModel.instance:isFinishedEpisode(var_9_0, arg_9_1) then
		arg_9_0:_playStoryClear(arg_9_1)

		if CooperGarlandConfig.instance:isExtraEpisode(var_9_0, arg_9_1) then
			arg_9_0:saveGameProgress(arg_9_1, CooperGarlandEnum.Const.DefaultGameProgress, true)
		end
	else
		Activity192Rpc.instance:sendAct192FinishEpisodeRequest(var_9_0, arg_9_1, nil, arg_9_0.onFinishEpisode, arg_9_0)
	end
end

function var_0_0.onFinishEpisode(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	local var_10_0 = arg_10_3.activityId
	local var_10_1 = arg_10_3.episodeId
	local var_10_2 = arg_10_3.progress

	CooperGarlandModel.instance:updateAct192Episode(var_10_0, var_10_1, true, var_10_2)

	if var_10_0 == CooperGarlandModel.instance:getAct192Id() then
		arg_10_0:_playStoryClear(var_10_1)
	end

	arg_10_0:dispatchEvent(CooperGarlandEvent.FirstFinishEpisode, var_10_0, var_10_1)
end

function var_0_0._playStoryClear(arg_11_0, arg_11_1)
	local var_11_0 = CooperGarlandModel.instance:getAct192Id()

	if not CooperGarlandModel.instance:isFinishedEpisode(var_11_0, arg_11_1) then
		return
	end

	local var_11_1 = CooperGarlandConfig.instance:getStoryClear(var_11_0, arg_11_1)

	if var_11_1 and var_11_1 ~= 0 then
		StoryController.instance:playStory(var_11_1, nil, arg_11_0.openResultView, arg_11_0, {
			isWin = true,
			episodeId = arg_11_1
		})
	else
		arg_11_0:openResultView({
			isWin = true,
			episodeId = arg_11_1
		})
	end
end

function var_0_0.clickEpisode(arg_12_0, arg_12_1, arg_12_2)
	if not CooperGarlandModel.instance:isAct192Open(true) then
		return
	end

	if not CooperGarlandModel.instance:isUnlockEpisode(arg_12_1, arg_12_2) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	arg_12_0:dispatchEvent(CooperGarlandEvent.OnClickEpisode, arg_12_1, arg_12_2)
end

function var_0_0.afterClickEpisode(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = CooperGarlandModel.instance:getAct192Id()

	if not arg_13_1 or not arg_13_2 or arg_13_1 ~= var_13_0 then
		return
	end

	CooperGarlandStatHelper.instance:enterEpisode(arg_13_2)

	if CooperGarlandConfig.instance:isExtraEpisode(arg_13_1, arg_13_2) then
		local var_13_1 = CooperGarlandModel.instance:getEpisodeProgress(arg_13_1, arg_13_2)

		Activity192Rpc.instance:sendAct192FinishEpisodeRequest(arg_13_1, arg_13_2, tostring(var_13_1))
	end

	local var_13_2 = CooperGarlandConfig.instance:getStoryBefore(arg_13_1, arg_13_2)

	if var_13_2 and var_13_2 ~= 0 then
		StoryController.instance:playStory(var_13_2, nil, arg_13_0._enterGame, arg_13_0, {
			episodeId = arg_13_2
		})

		return
	end

	arg_13_0:_enterGame({
		episodeId = arg_13_2
	})
end

function var_0_0.openLevelView(arg_14_0)
	arg_14_0:getAct192Info(arg_14_0._realOpenLevelView, arg_14_0, true)
end

function var_0_0._realOpenLevelView(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandLevelView)
end

function var_0_0.openTaskView(arg_16_0)
	CooperGarlandTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity192
	}, arg_16_0._realOpenTaskView, arg_16_0)
end

function var_0_0._realOpenTaskView(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 ~= 0 then
		return
	end

	CooperGarlandTaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.CooperGarlandTaskView)
end

function var_0_0.openResultView(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_1.isWin then
		CooperGarlandStatHelper.instance:sendEpisodeFinish()
	end

	local var_18_0 = CooperGarlandModel.instance:getAct192Id()
	local var_18_1 = arg_18_1 and arg_18_1.episodeId

	if not var_18_0 or not var_18_1 then
		return
	end

	if not CooperGarlandConfig.instance:isGameEpisode(var_18_0, var_18_1) then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandResultView, {
		episodeId = var_18_1,
		isWin = arg_18_1.isWin
	})
end

function var_0_0._enterGame(arg_19_0, arg_19_1)
	local var_19_0 = CooperGarlandModel.instance:getAct192Id()
	local var_19_1 = arg_19_1 and arg_19_1.episodeId

	if CooperGarlandConfig.instance:isGameEpisode(var_19_0, var_19_1) then
		CooperGarlandStatHelper.instance:enterGame()
		CooperGarlandGameModel.instance:enterGameInitData(var_19_1)
		CooperGarlandGameEntityMgr.instance:enterMap()
		ViewMgr.instance:openView(ViewName.CooperGarlandGameView)
	else
		arg_19_0:finishEpisode(var_19_1, true)
	end
end

function var_0_0.resetJoystick(arg_20_0)
	arg_20_0:dispatchEvent(CooperGarlandEvent.ResetJoystick)
end

function var_0_0.resetPanelBalance(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:changePanelBalance(0, 0, arg_21_1, arg_21_2)
end

function var_0_0.changePanelBalance(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	arg_22_0:dispatchEvent(CooperGarlandEvent.ChangePanelAngle, arg_22_1, arg_22_2, arg_22_3 or 0, arg_22_4)
end

function var_0_0.changeRemoveMode(arg_23_0)
	local var_23_0 = not CooperGarlandGameModel.instance:getIsRemoveMode()

	if var_23_0 then
		local var_23_1 = CooperGarlandGameModel.instance:getRemoveCount()

		if not var_23_1 or var_23_1 <= 0 then
			GameFacade.showToast(ToastEnum.CooperGarlandRemoveCountNotEnough)

			return
		end
	end

	arg_23_0:setStopGame(var_23_0)
	CooperGarlandGameModel.instance:setRemoveMode(var_23_0)
	arg_23_0:dispatchEvent(CooperGarlandEvent.OnRemoveModeChange)
end

function var_0_0.changeControlMode(arg_24_0)
	arg_24_0:resetJoystick()
	arg_24_0:resetPanelBalance(0, true)

	local var_24_0 = CooperGarlandGameModel.instance:getControlMode() % CooperGarlandEnum.Const.JoystickModeLeft + 1

	CooperGarlandGameModel.instance:setControlMode(var_24_0)
	arg_24_0:dispatchEvent(CooperGarlandEvent.OnChangeControlMode)
end

function var_0_0.removeComponent(arg_25_0, arg_25_1, arg_25_2)
	if not CooperGarlandGameModel.instance:getIsRemoveMode() then
		return
	end

	local var_25_0 = CooperGarlandGameModel.instance:getRemoveCount()

	if not var_25_0 or var_25_0 <= 0 then
		return
	end

	local var_25_1 = CooperGarlandConfig.instance:getMapComponentType(arg_25_1, arg_25_2)

	if var_25_1 == CooperGarlandEnum.ComponentType.Hole or var_25_1 == CooperGarlandEnum.ComponentType.Spike then
		CooperGarlandGameEntityMgr.instance:removeComp(arg_25_2)
		CooperGarlandGameModel.instance:setRemoveCount(var_25_0 - 1)
		arg_25_0:dispatchEvent(CooperGarlandEvent.OnRemoveComponent, arg_25_2)
	end
end

function var_0_0.enterNextRound(arg_26_0)
	local var_26_0 = CooperGarlandGameModel.instance:getGameRound() + 1
	local var_26_1 = CooperGarlandModel.instance:getAct192Id()
	local var_26_2 = CooperGarlandGameModel.instance:getEpisodeId()

	if CooperGarlandConfig.instance:isExtraEpisode(var_26_1, var_26_2) then
		arg_26_0:saveGameProgress(var_26_2, var_26_0, true)
	end

	CooperGarlandGameModel.instance:changeRound(var_26_0)
	CooperGarlandGameEntityMgr.instance:changeMap()
	arg_26_0:dispatchEvent(CooperGarlandEvent.OnEnterNextRound)
end

function var_0_0.resetGame(arg_27_0)
	CooperGarlandGameModel.instance:resetGameData()
	CooperGarlandGameEntityMgr.instance:resetMap()
	arg_27_0:dispatchEvent(CooperGarlandEvent.OnResetGame)
end

function var_0_0.exitGame(arg_28_0)
	CooperGarlandGameEntityMgr.instance:clearAllMap()
	CooperGarlandGameModel.instance:clearAllData()
	ViewMgr.instance:closeView(ViewName.CooperGarlandGameView)
end

function var_0_0.setStopGame(arg_29_0, arg_29_1)
	if CooperGarlandGameModel.instance:getIsStopGame() == arg_29_1 then
		return
	end

	CooperGarlandGameModel.instance:setIsStopGame(arg_29_1)
	arg_29_0:resetJoystick()
	arg_29_0:resetPanelBalance(0, true)
	CooperGarlandGameEntityMgr.instance:checkBallFreeze(true)
	arg_29_0:dispatchEvent(CooperGarlandEvent.OnGameStopChange)
end

function var_0_0.triggerEnterComponent(arg_30_0, arg_30_1, arg_30_2)
	if not CooperGarlandGameEntityMgr.instance:isBallCanTriggerComp() then
		return
	end

	local var_30_0
	local var_30_1 = AudioEnum2_7.CooperGarland
	local var_30_2 = CooperGarlandConfig.instance:getMapComponentType(arg_30_1, arg_30_2)

	if var_30_2 == CooperGarlandEnum.ComponentType.End then
		var_30_0 = var_30_1.play_ui_yuzhou_ball_fall

		arg_30_0:_ballArrivesEnd()
	elseif var_30_2 == CooperGarlandEnum.ComponentType.Hole or var_30_2 == CooperGarlandEnum.ComponentType.Spike then
		var_30_0 = var_30_2 == CooperGarlandEnum.ComponentType.Hole and var_30_1.play_ui_yuzhou_ball_trap or var_30_1.play_ui_yuzhou_ball_spikes

		CooperGarlandGameEntityMgr.instance:playBallDieVx()
		arg_30_0:_gameFail(arg_30_2)
	elseif var_30_2 == CooperGarlandEnum.ComponentType.Key then
		arg_30_0:_ballKeyChange(true)

		var_30_0 = var_30_1.play_ui_yuzhou_ball_star

		CooperGarlandGameEntityMgr.instance:removeComp(arg_30_2)
	elseif var_30_2 == CooperGarlandEnum.ComponentType.Story then
		local var_30_3 = CooperGarlandConfig.instance:getMapComponentExtraParams(arg_30_1, arg_30_2)

		arg_30_0:_triggerStory(var_30_3)
	end

	if var_30_0 then
		AudioMgr.instance:trigger(var_30_0)
	end
end

function var_0_0.triggerExitComponent(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = CooperGarlandConfig.instance:getMapComponentType(arg_31_1, arg_31_2)
end

function var_0_0._ballArrivesEnd(arg_32_0)
	arg_32_0:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapArrive()

	local var_32_0 = CooperGarlandGameModel.instance:getGameRound()
	local var_32_1 = CooperGarlandGameModel.instance:getGameId()

	if var_32_0 >= CooperGarlandConfig.instance:getMaxRound(var_32_1) then
		CooperGarlandStatHelper.instance:sendGameFinish()
		arg_32_0:dispatchEvent(CooperGarlandEvent.PlayFinishEpisodeStarVX)
	else
		CooperGarlandGameModel.instance:setSceneOpenAnimShowBall(false)
		arg_32_0:dispatchEvent(CooperGarlandEvent.PlayEnterNextRoundAnim)
	end
end

function var_0_0._gameFail(arg_33_0, arg_33_1)
	arg_33_0:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapFail(arg_33_1)

	local var_33_0 = CooperGarlandGameModel.instance:getEpisodeId()

	arg_33_0:openResultView({
		isWin = false,
		episodeId = var_33_0
	})
end

function var_0_0._ballKeyChange(arg_34_0, arg_34_1)
	CooperGarlandGameModel.instance:setBallHasKey(arg_34_1)
	arg_34_0:dispatchEvent(CooperGarlandEvent.OnBallKeyChange)
end

function var_0_0._triggerStory(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1 and tonumber(arg_35_1)

	if not var_35_0 then
		return
	end

	local var_35_1 = GuideController.instance:isForbidGuides()

	if not GuideModel.instance:isGuideRunning(var_35_0) or var_35_1 then
		return
	end

	arg_35_0:setStopGame(true)
	arg_35_0:dispatchEvent(CooperGarlandEvent.triggerGuideDialogue, var_35_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
