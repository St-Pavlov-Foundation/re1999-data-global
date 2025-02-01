module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameView", package.seeall)

slot0 = class("JiaLaBoNaGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtRemainingTimesNum = gohelper.findChildText(slot0.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	slot0._txtTargetDecr = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	slot0._txtTarget2Decr = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	slot0._txtStage = gohelper.findChildText(slot0.viewGO, "Top/#txt_Stage")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Top/#txt_Title")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	slot0._btnReadBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ReadBtn")
	slot0._btnResetBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ResetBtn")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnResetBtn:AddClickListener(slot0._btnResetBtnOnClick, slot0)
	slot0._btnReadBtn:AddClickListener(slot0._btnReadBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnResetBtn:RemoveClickListener()
	slot0._btnReadBtn:RemoveClickListener()
end

function slot0._btnResetBtnOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, slot0._yesResetFunc)
end

function slot0._btnReadBtnOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	if Va3ChessGameModel.instance:getRound() > 1 then
		if not slot0._litterPointTime or slot0._litterPointTime < Time.time then
			slot0._litterPointTime = Time.time + 0.3

			slot0:_returnPointGame()
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

slot0.UI_RESTART_BLOCK_KEY = "JiaLaBoNaGameViewsGameMainDelayRestart"

function slot0._editableInitView(slot0)
	function slot0._yesResetFunc()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(uv0.delayRestartGame, uv0, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	slot0._imgTarget1Icon = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	slot0._imgTarget2Icon = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	slot0._govxfinish = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	slot0._govxglow = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Top/Tips")
	slot0._goresetgame = gohelper.findChild(slot0.viewGO, "excessive")

	gohelper.setActive(slot0._goTips, false)

	slot0._swicthSceneAnimator = gohelper.findChild(slot0.viewGO, "#go_excessive/anim"):GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	slot0._resetGameAnimator = gohelper.findChild(slot0.viewGO, "excessive/anim"):GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	slot0._viewAnimator = slot0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(slot0._goexcessive, false)
	gohelper.setActive(slot0._goresetgame, false)

	slot0._isLastSwitchStart = false
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, slot0.onSetViewVictory, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, slot0.onSetViewFail, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentRoundUpdate, slot0.refreshRound, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetCenterHintText, slot0.setUICenterHintText, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, slot0.handleResetByResult, slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, slot0.refreshUI, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameLoadingMapStateUpdate, slot0._onReadyGoNextMap, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, slot0._onToastUpdate, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, slot0._onReturnChessFromBattleGroup, slot0)
	slot0:refreshUI()
	slot0:_setOpenAnimSpeed(true)
	TaskDispatcher.runDelay(slot0._onResetOpenAnim, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)
	TaskDispatcher.cancelTask(slot0._returnPointGame, slot0)
	TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayRefreshMainTask, slot0)
	TaskDispatcher.cancelTask(slot0._onResetOpenAnim, slot0)
end

function slot0._getEpisodeCfg(slot0)
	slot1 = Va3ChessModel.instance:getActId()
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if slot0._curEpisodeCfg and slot0._curEpisodeCfg.activity == slot1 and slot0._curEpisodeCfg.id == slot2 then
		return slot0._curEpisodeCfg
	end

	if slot1 ~= nil and slot2 ~= nil then
		slot3 = Va3ChessConfig.instance:getEpisodeCo(slot1, slot2)
		slot0._curEpisodeCfg = slot3
		slot0._curMainConditions = slot3 and GameUtil.splitString2(slot3.mainConfition, true, "|", "#")
		slot0._curConditionDesc = slot3 and string.split(slot3.mainConditionStr, "|")
		slot0._extStarConditions = slot3 and GameUtil.splitString2(slot3.extStarCondition, true, "|", "#")

		return slot0._curEpisodeCfg
	end
end

function slot0._onResetOpenAnim(slot0)
	if slot0._needResetViewOpen then
		slot0:_setOpenAnimSpeed(false)
	end
end

function slot0._setOpenAnimSpeed(slot0, slot1)
	slot0._needResetViewOpen = slot1
	slot0._viewAnimator.speed = slot1 and 0 or 1

	slot0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	slot0._viewAnimator:Update(0)
end

function slot0.refreshUI(slot0)
	if slot0:_getEpisodeCfg() then
		slot0._txtStage.text = slot1.orderId
		slot0._txtTitle.text = slot1.name
	end

	slot0:refreshConditions()
	slot0:refreshRound()
end

function slot0.onSetViewVictory(slot0)
	Stat1_3Controller.instance:jiaLaBoNaStatSuccess()
	slot0:refreshConditions()

	if slot0:_getEpisodeCfg() then
		if slot1.storyClear == 0 then
			uv0.openWinResult()

			return
		end

		slot2 = slot1.storyClear

		if slot1.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(slot2) then
			StoryController.instance:playStories({
				slot2
			}, {
				blur = true,
				mark = true,
				hideStartAndEndDark = true,
				isReplay = false
			}, uv0._onStroyClearFinish)
		else
			uv0.openWinResult()
		end
	end
end

slot0.OPEN_WIN_RESULT = "JiaLaBoNaGameView.JiaLaBoNaGameView.OPEN_WIN_RESULT"

function slot0._onStroyClearFinish()
	UIBlockMgr.instance:startBlock(uv0.STROY_CLEARR_FINISH)
	TaskDispatcher.runDelay(uv0.openWinResult, nil, 1)
end

function slot0.openWinResult()
	UIBlockMgr.instance:endBlock(uv0.STROY_CLEARR_FINISH)

	slot1 = "OnChessWinPause" .. Va3ChessModel.instance:getEpisodeId()

	GuideController.instance:GuideFlowPauseAndContinue(slot1, GuideEvent[slot1], GuideEvent.OnChessWinContinue, uv0._openSuccessView, nil)
end

function slot0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = true
	})
end

function slot0.onSetViewFail(slot0)
	Stat1_3Controller.instance:jiaLaBoNaStatFail()

	if Va3ChessGameModel.instance:getFailReason() == Va3ChessEnum.FailReason.MaxRound then
		Va3ChessGameModel.instance:setRound(Va3ChessGameModel.instance:getRound() + 1)
		slot0:refreshRound()
	end

	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = false
	})
end

function slot0.refreshRound(slot0)
	if slot0:_getEpisodeCfg() then
		slot0._txtRemainingTimesNum.text = string.format("%s", math.max(slot1.maxRound - Va3ChessGameModel.instance:getRound() + 1, 0))
	end
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.delayRestartGame(slot0)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)
	Stat1_3Controller.instance:jiaLaBoNaStatReset()
	JiaLaBoNaController.instance:resetStartGame()
end

function slot0._returnPointGame(slot0)
	Stat1_3Controller.instance:jiaLaBoNaMarkUseRead()
	JiaLaBoNaController.instance:returnPointGame()
end

function slot0.refreshConditions(slot0)
	if slot0:_getEpisodeCfg() then
		slot2 = slot0._curConditionDesc
		slot0._curShowMainTaskDesStr = slot0._curConditionDesc[slot0:_findFinishIndex(slot0._curMainConditions, slot1.activityId) + 1] or slot0._curConditionDesc[slot5]
		slot0._curMainTaskFinishAll = #slot0._curMainConditions <= slot5
		slot0._txtTarget2Decr.text = slot1.conditionStr

		if slot0._lastTarget2Finish ~= slot0:_checkTarget2Finish(slot0._extStarConditions, slot4) then
			slot0._lastTarget2Finish = slot6

			slot0:_setColorByFinish(slot0._imgTarget2Icon, slot6)
			gohelper.setActive(slot0._govxglow, false)

			if slot6 then
				gohelper.setActive(slot0._govxglow, true)
			end
		end

		if slot0._lastFinishIndex ~= slot5 then
			slot0._lastFinishIndex = slot5

			gohelper.setActive(slot0._govxfinish, false)

			if slot5 > 0 then
				slot0:_setColorByFinish(slot0._imgTarget1Icon, slot5 > 0)
				gohelper.setActive(slot0._govxfinish, true)
				TaskDispatcher.cancelTask(slot0._onDelayRefreshMainTask, slot0)
				TaskDispatcher.runDelay(slot0._onDelayRefreshMainTask, slot0, 0.5)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_target_flushed)
			else
				slot0:_onDelayRefreshMainTask()
			end
		end
	end
end

function slot0._setColorByFinish(slot0, slot1, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot2 and "#AFD3FF" or "#808080")
end

function slot0._onDelayRefreshMainTask(slot0)
	slot0._txtTargetDecr.text = slot0._curShowMainTaskDesStr

	slot0:_setColorByFinish(slot0._imgTarget1Icon, slot0._curMainTaskFinishAll)
end

function slot0._findFinishIndex(slot0, slot1, slot2)
	for slot7 = 1, #slot1 do
		if not Va3ChessMapUtils.isClearConditionFinish(slot1[slot7], slot2) then
			return slot7 - 1
		end
	end

	return slot3
end

function slot0._checkTarget2Finish(slot0, slot1, slot2)
	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if not Va3ChessMapUtils.isClearConditionFinish(slot7, slot2) then
				return false
			end
		end
	end

	return true
end

function slot0.setUICenterHintText(slot0)
end

function slot0.handleResetByResult(slot0)
end

function slot0._onReadyGoNextMap(slot0, slot1, slot2)
	slot3 = slot1 == Va3ChessEvent.LoadingMapState.Start

	slot0:switchScene(slot3, slot3 and slot2)

	if slot1 == Va3ChessEvent.LoadingMapState.Finish then
		slot0:_onResetOpenAnim()
	end
end

function slot0.switchScene(slot0, slot1, slot2)
	if slot0._isLastSwitchStart == (slot1 == true) then
		return
	end

	if slot0._curSwitchSceneGO == nil then
		slot0._curSwitchSceneGO = slot2 and slot0._goresetgame or slot0._goexcessive
		slot0._curSwitchSceneAnim = slot2 and slot0._resetGameAnimator or slot0._swicthSceneAnimator
	end

	slot0._isLastSwitchStart = slot3

	if slot3 then
		UIBlockMgr.instance:startBlock(uv0.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(slot0._curSwitchSceneGO, true)
	end

	slot0._curSwitchSceneAnim:Play(slot3 and "open" or "close")
	TaskDispatcher.cancelTask(slot0._onHideSwitchScene, slot0)
	TaskDispatcher.runDelay(slot0._onHideSwitchScene, slot0, 0.3)
end

function slot0._onHideSwitchScene(slot0)
	if slot0._isLastSwitchStart then
		slot0._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)

		if slot0._curSwitchSceneGO then
			gohelper.setActive(slot0._curSwitchSceneGO, false)

			slot0._curSwitchSceneGO = nil
			slot0._curSwitchSceneAnim = nil
		end
	end
end

function slot0._onReturnChessFromBattleGroup(slot0)
	JiaLaBoNaController.instance:returnPointGame()
end

function slot0._onToastUpdate(slot0, slot1)
	if Va3ChessModel.instance:getActId() == Va3ChessEnum.ActivityId.Act120 then
		if not Activity120Config.instance:getTipsCo(slot2, slot1) then
			logError(string.format("export_伽菈波娜飘字 activityId:%s id:%s", slot2, slot1))

			return
		end

		if slot3.audioId and slot3.audioId ~= 0 then
			AudioMgr.instance:trigger(slot3.audioId)
		end

		TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
		TaskDispatcher.runDelay(slot0._onHideToast, slot0, 5)

		slot0._txtTips.text = slot3.tips

		gohelper.setActive(slot0._goTips, true)
	end
end

function slot0._onHideToast(slot0)
	gohelper.setActive(slot0._goTips, false)
end

return slot0
