module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameView", package.seeall)

local var_0_0 = class("JiaLaBoNaGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtRemainingTimesNum = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	arg_1_0._txtTargetDecr = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	arg_1_0._txtTarget2Decr = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Stage")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Title")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	arg_1_0._btnReadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ReadBtn")
	arg_1_0._btnResetBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ResetBtn")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnResetBtn:AddClickListener(arg_2_0._btnResetBtnOnClick, arg_2_0)
	arg_2_0._btnReadBtn:AddClickListener(arg_2_0._btnReadBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnResetBtn:RemoveClickListener()
	arg_3_0._btnReadBtn:RemoveClickListener()
end

function var_0_0._btnResetBtnOnClick(arg_4_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, arg_4_0._yesResetFunc)
end

function var_0_0._btnReadBtnOnClick(arg_5_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	if Va3ChessGameModel.instance:getRound() > 1 then
		if not arg_5_0._litterPointTime or arg_5_0._litterPointTime < Time.time then
			arg_5_0._litterPointTime = Time.time + 0.3

			arg_5_0:_returnPointGame()
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

var_0_0.UI_RESTART_BLOCK_KEY = "JiaLaBoNaGameViewsGameMainDelayRestart"

function var_0_0._editableInitView(arg_6_0)
	function arg_6_0._yesResetFunc()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(arg_6_0.delayRestartGame, arg_6_0, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	arg_6_0._imgTarget1Icon = gohelper.findChildImage(arg_6_0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	arg_6_0._imgTarget2Icon = gohelper.findChildImage(arg_6_0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	arg_6_0._govxfinish = gohelper.findChild(arg_6_0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	arg_6_0._govxglow = gohelper.findChild(arg_6_0.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	arg_6_0._goTips = gohelper.findChild(arg_6_0.viewGO, "Top/Tips")
	arg_6_0._goresetgame = gohelper.findChild(arg_6_0.viewGO, "excessive")

	gohelper.setActive(arg_6_0._goTips, false)

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#go_excessive/anim")
	local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "excessive/anim")

	arg_6_0._swicthSceneAnimator = var_6_0:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	arg_6_0._resetGameAnimator = var_6_1:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	arg_6_0._viewAnimator = arg_6_0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(arg_6_0._goexcessive, false)
	gohelper.setActive(arg_6_0._goresetgame, false)

	arg_6_0._isLastSwitchStart = false
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, arg_8_0.onSetViewVictory, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, arg_8_0.onSetViewFail, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentRoundUpdate, arg_8_0.refreshRound, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, arg_8_0.onResultQuit, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, arg_8_0.refreshConditions, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetCenterHintText, arg_8_0.setUICenterHintText, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, arg_8_0.handleResetByResult, arg_8_0)
	arg_8_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameLoadingMapStateUpdate, arg_8_0._onReadyGoNextMap, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, arg_8_0._onToastUpdate, arg_8_0)
	arg_8_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, arg_8_0._onReturnChessFromBattleGroup, arg_8_0)
	arg_8_0:refreshUI()
	arg_8_0:_setOpenAnimSpeed(true)
	TaskDispatcher.runDelay(arg_8_0._onResetOpenAnim, arg_8_0, 1)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)
end

function var_0_0.onClose(arg_9_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_9_0.delayRestartGame, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._returnPointGame, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onHideToast, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onDelayRefreshMainTask, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onResetOpenAnim, arg_9_0)
end

function var_0_0._getEpisodeCfg(arg_10_0)
	local var_10_0 = Va3ChessModel.instance:getActId()
	local var_10_1 = Va3ChessModel.instance:getEpisodeId()

	if arg_10_0._curEpisodeCfg and arg_10_0._curEpisodeCfg.activity == var_10_0 and arg_10_0._curEpisodeCfg.id == var_10_1 then
		return arg_10_0._curEpisodeCfg
	end

	if var_10_0 ~= nil and var_10_1 ~= nil then
		local var_10_2 = Va3ChessConfig.instance:getEpisodeCo(var_10_0, var_10_1)

		arg_10_0._curEpisodeCfg = var_10_2
		arg_10_0._curMainConditions = var_10_2 and GameUtil.splitString2(var_10_2.mainConfition, true, "|", "#")
		arg_10_0._curConditionDesc = var_10_2 and string.split(var_10_2.mainConditionStr, "|")
		arg_10_0._extStarConditions = var_10_2 and GameUtil.splitString2(var_10_2.extStarCondition, true, "|", "#")

		return arg_10_0._curEpisodeCfg
	end
end

function var_0_0._onResetOpenAnim(arg_11_0)
	if arg_11_0._needResetViewOpen then
		arg_11_0:_setOpenAnimSpeed(false)
	end
end

function var_0_0._setOpenAnimSpeed(arg_12_0, arg_12_1)
	arg_12_0._needResetViewOpen = arg_12_1
	arg_12_0._viewAnimator.speed = arg_12_1 and 0 or 1

	arg_12_0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	arg_12_0._viewAnimator:Update(0)
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = arg_13_0:_getEpisodeCfg()

	if var_13_0 then
		arg_13_0._txtStage.text = var_13_0.orderId
		arg_13_0._txtTitle.text = var_13_0.name
	end

	arg_13_0:refreshConditions()
	arg_13_0:refreshRound()
end

function var_0_0.onSetViewVictory(arg_14_0)
	Stat1_3Controller.instance:jiaLaBoNaStatSuccess()

	local var_14_0 = arg_14_0:_getEpisodeCfg()

	arg_14_0:refreshConditions()

	if var_14_0 then
		if var_14_0.storyClear == 0 then
			var_0_0.openWinResult()

			return
		end

		local var_14_1 = var_14_0.storyClear

		if var_14_0.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(var_14_1) then
			local var_14_2 = {}

			var_14_2.blur = true
			var_14_2.mark = true
			var_14_2.hideStartAndEndDark = true
			var_14_2.isReplay = false

			StoryController.instance:playStories({
				var_14_1
			}, var_14_2, var_0_0._onStroyClearFinish)
		else
			var_0_0.openWinResult()
		end
	end
end

var_0_0.OPEN_WIN_RESULT = "JiaLaBoNaGameView.JiaLaBoNaGameView.OPEN_WIN_RESULT"

function var_0_0._onStroyClearFinish()
	UIBlockMgr.instance:startBlock(var_0_0.STROY_CLEARR_FINISH)
	TaskDispatcher.runDelay(var_0_0.openWinResult, nil, 1)
end

function var_0_0.openWinResult()
	UIBlockMgr.instance:endBlock(var_0_0.STROY_CLEARR_FINISH)

	local var_16_0 = Va3ChessModel.instance:getEpisodeId()
	local var_16_1 = "OnChessWinPause" .. var_16_0
	local var_16_2 = GuideEvent[var_16_1]
	local var_16_3 = GuideEvent.OnChessWinContinue
	local var_16_4 = var_0_0._openSuccessView
	local var_16_5

	GuideController.instance:GuideFlowPauseAndContinue(var_16_1, var_16_2, var_16_3, var_16_4, var_16_5)
end

function var_0_0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = true
	})
end

function var_0_0.onSetViewFail(arg_18_0)
	Stat1_3Controller.instance:jiaLaBoNaStatFail()

	if Va3ChessGameModel.instance:getFailReason() == Va3ChessEnum.FailReason.MaxRound then
		Va3ChessGameModel.instance:setRound(Va3ChessGameModel.instance:getRound() + 1)
		arg_18_0:refreshRound()
	end

	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = false
	})
end

function var_0_0.refreshRound(arg_19_0)
	local var_19_0 = arg_19_0:_getEpisodeCfg()

	if var_19_0 then
		local var_19_1 = var_19_0.maxRound - Va3ChessGameModel.instance:getRound() + 1

		arg_19_0._txtRemainingTimesNum.text = string.format("%s", math.max(var_19_1, 0))
	end
end

function var_0_0.onResultQuit(arg_20_0)
	arg_20_0:closeThis()
end

function var_0_0.delayRestartGame(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.delayRestartGame, arg_21_0)
	Stat1_3Controller.instance:jiaLaBoNaStatReset()
	JiaLaBoNaController.instance:resetStartGame()
end

function var_0_0._returnPointGame(arg_22_0)
	Stat1_3Controller.instance:jiaLaBoNaMarkUseRead()
	JiaLaBoNaController.instance:returnPointGame()
end

function var_0_0.refreshConditions(arg_23_0)
	local var_23_0 = arg_23_0:_getEpisodeCfg()

	if var_23_0 then
		local var_23_1 = arg_23_0._curConditionDesc
		local var_23_2 = #arg_23_0._curMainConditions
		local var_23_3 = var_23_0.activityId
		local var_23_4 = arg_23_0:_findFinishIndex(arg_23_0._curMainConditions, var_23_3)

		arg_23_0._curShowMainTaskDesStr = arg_23_0._curConditionDesc[var_23_4 + 1] or arg_23_0._curConditionDesc[var_23_4]
		arg_23_0._curMainTaskFinishAll = var_23_2 <= var_23_4

		local var_23_5 = arg_23_0:_checkTarget2Finish(arg_23_0._extStarConditions, var_23_3)

		arg_23_0._txtTarget2Decr.text = var_23_0.conditionStr

		if arg_23_0._lastTarget2Finish ~= var_23_5 then
			arg_23_0._lastTarget2Finish = var_23_5

			arg_23_0:_setColorByFinish(arg_23_0._imgTarget2Icon, var_23_5)
			gohelper.setActive(arg_23_0._govxglow, false)

			if var_23_5 then
				gohelper.setActive(arg_23_0._govxglow, true)
			end
		end

		if arg_23_0._lastFinishIndex ~= var_23_4 then
			arg_23_0._lastFinishIndex = var_23_4

			gohelper.setActive(arg_23_0._govxfinish, false)

			if var_23_4 > 0 then
				arg_23_0:_setColorByFinish(arg_23_0._imgTarget1Icon, var_23_4 > 0)
				gohelper.setActive(arg_23_0._govxfinish, true)
				TaskDispatcher.cancelTask(arg_23_0._onDelayRefreshMainTask, arg_23_0)
				TaskDispatcher.runDelay(arg_23_0._onDelayRefreshMainTask, arg_23_0, 0.5)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_target_flushed)
			else
				arg_23_0:_onDelayRefreshMainTask()
			end
		end
	end
end

function var_0_0._setColorByFinish(arg_24_0, arg_24_1, arg_24_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_24_1, arg_24_2 and "#AFD3FF" or "#808080")
end

function var_0_0._onDelayRefreshMainTask(arg_25_0)
	arg_25_0._txtTargetDecr.text = arg_25_0._curShowMainTaskDesStr

	arg_25_0:_setColorByFinish(arg_25_0._imgTarget1Icon, arg_25_0._curMainTaskFinishAll)
end

function var_0_0._findFinishIndex(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = #arg_26_1

	for iter_26_0 = 1, var_26_0 do
		if not Va3ChessMapUtils.isClearConditionFinish(arg_26_1[iter_26_0], arg_26_2) then
			return iter_26_0 - 1
		end
	end

	return var_26_0
end

function var_0_0._checkTarget2Finish(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 then
		for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
			if not Va3ChessMapUtils.isClearConditionFinish(iter_27_1, arg_27_2) then
				return false
			end
		end
	end

	return true
end

function var_0_0.setUICenterHintText(arg_28_0)
	return
end

function var_0_0.handleResetByResult(arg_29_0)
	return
end

function var_0_0._onReadyGoNextMap(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 == Va3ChessEvent.LoadingMapState.Start

	arg_30_0:switchScene(var_30_0, var_30_0 and arg_30_2)

	if arg_30_1 == Va3ChessEvent.LoadingMapState.Finish then
		arg_30_0:_onResetOpenAnim()
	end
end

function var_0_0.switchScene(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1 == true

	if arg_31_0._isLastSwitchStart == var_31_0 then
		return
	end

	if arg_31_0._curSwitchSceneGO == nil then
		arg_31_0._curSwitchSceneGO = arg_31_2 and arg_31_0._goresetgame or arg_31_0._goexcessive
		arg_31_0._curSwitchSceneAnim = arg_31_2 and arg_31_0._resetGameAnimator or arg_31_0._swicthSceneAnimator
	end

	arg_31_0._isLastSwitchStart = var_31_0

	if var_31_0 then
		UIBlockMgr.instance:startBlock(var_0_0.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(arg_31_0._curSwitchSceneGO, true)
	end

	arg_31_0._curSwitchSceneAnim:Play(var_31_0 and "open" or "close")
	TaskDispatcher.cancelTask(arg_31_0._onHideSwitchScene, arg_31_0)
	TaskDispatcher.runDelay(arg_31_0._onHideSwitchScene, arg_31_0, 0.3)
end

function var_0_0._onHideSwitchScene(arg_32_0)
	if arg_32_0._isLastSwitchStart then
		arg_32_0._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)

		if arg_32_0._curSwitchSceneGO then
			gohelper.setActive(arg_32_0._curSwitchSceneGO, false)

			arg_32_0._curSwitchSceneGO = nil
			arg_32_0._curSwitchSceneAnim = nil
		end
	end
end

function var_0_0._onReturnChessFromBattleGroup(arg_33_0)
	JiaLaBoNaController.instance:returnPointGame()
end

function var_0_0._onToastUpdate(arg_34_0, arg_34_1)
	local var_34_0 = Va3ChessModel.instance:getActId()

	if var_34_0 == Va3ChessEnum.ActivityId.Act120 then
		local var_34_1 = Activity120Config.instance:getTipsCo(var_34_0, arg_34_1)

		if not var_34_1 then
			logError(string.format("export_伽菈波娜飘字 activityId:%s id:%s", var_34_0, arg_34_1))

			return
		end

		if var_34_1.audioId and var_34_1.audioId ~= 0 then
			AudioMgr.instance:trigger(var_34_1.audioId)
		end

		TaskDispatcher.cancelTask(arg_34_0._onHideToast, arg_34_0)
		TaskDispatcher.runDelay(arg_34_0._onHideToast, arg_34_0, 5)

		arg_34_0._txtTips.text = var_34_1.tips

		gohelper.setActive(arg_34_0._goTips, true)
	end
end

function var_0_0._onHideToast(arg_35_0)
	gohelper.setActive(arg_35_0._goTips, false)
end

return var_0_0
