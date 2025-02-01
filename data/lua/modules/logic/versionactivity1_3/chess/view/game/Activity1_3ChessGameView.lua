module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameView", package.seeall)

slot0 = class("Activity1_3ChessGameView", BaseView)
slot1 = {
	lose = "idle_black",
	losing = "hit",
	normal = "idle_light"
}
slot2 = {
	loop = "loop",
	open = "open",
	close = "close"
}
slot0.UI_RESET_BLOCK_KEY = "Activity1_3ChessGameViewResetBlock"

function slot0.onInitView(slot0)
	slot0._animatorLife1 = gohelper.findChildComponent(slot0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons1", typeof(UnityEngine.Animator))
	slot0._animatorLife2 = gohelper.findChildComponent(slot0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons2", typeof(UnityEngine.Animator))
	slot0._animatorLife3 = gohelper.findChildComponent(slot0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons3", typeof(UnityEngine.Animator))
	slot0._txtTargetDesc = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	slot0._imageTargetIcon = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	slot0._gotargetFinish = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	slot0._txtTargetDesc2 = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	slot0._imageTargetIcon2 = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	slot0._gotargetStar = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	slot0._txtStage = gohelper.findChildText(slot0.viewGO, "Top/#txt_Stage")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Top/#txt_Title")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	slot0._btnResetBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ResetBtn")
	slot0._btnReadBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ReadBtn")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goTop = gohelper.findChild(slot0.viewGO, "Top")
	slot0._exTargetGo = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2")
	slot0._goTargetList = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList")
	slot0._goTipsRoot = gohelper.findChild(slot0.viewGO, "Top/Tips")
	slot0._goResetExcessive = gohelper.findChild(slot0.viewGO, "excessive")
	slot0._goNextMapExcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	gohelper.setActive(slot0._goResetExcessive, false)
	gohelper.setActive(slot0._goNextMapExcessive, false)

	slot0._animatorResetExcessive = gohelper.findChildComponent(slot0.viewGO, "excessive/anim", typeof(UnityEngine.Animator))
	slot0._animatorNextMapExcessive = gohelper.findChildComponent(slot0.viewGO, "#go_excessive/anim", typeof(UnityEngine.Animator))
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnResetBtn:AddClickListener(slot0._btnResetBtnOnClick, slot0)
	slot0._btnReadBtn:AddClickListener(slot0._btnBackOnClick, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, slot0.onSetViewVictory, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, slot0.onSetViewFail, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, slot0.refreshLifeCount, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TargetUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, slot0.showTips, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.BeforeEnterNextMap, slot0._beforeEnterNextMap, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onEnterNextMap, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.PlayStoryFinish, slot0._onPlayStoryFinish, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, slot0._onReturnChessFromBattleGroup, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, slot0.onResetGame, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, slot0.onReadGame, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickReset, slot0.eventResetFunc, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickRead, slot0._btnReadBtnOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, slot0._afterPlayStory, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnResetBtn:RemoveClickListener()
	slot0._btnReadBtn:RemoveClickListener()
end

function slot0._btnBackOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	Stat1_3Controller.instance:bristleMarkUseRead()
	Activity1_3ChessController.instance:requestBackChessGame(Va3ChessModel.instance:getActId())
end

function slot0._btnReadBtnOnClick(slot0)
	Stat1_3Controller.instance:bristleMarkUseRead()
	UIBlockMgr.instance:startBlock(uv0.UI_RESET_BLOCK_KEY)
	slot0:_playReadProgressAniamtion(true)
	TaskDispatcher.runDelay(slot0.delayReadProgress, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function slot0.delayReadProgress(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayReadProgress, slot0)
	Activity1_3ChessController.instance:requestReadChessGame(Va3ChessModel.instance:getActId(), slot0.playReadAniamtionClose, slot0)
end

function slot0._btnResetBtnOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, slot0.btnResetFunc, nil, , slot0)
end

function slot0.btnResetFunc(slot0)
	Stat1_3Controller.instance:bristleStatReset()
	slot0:_resetFunc()
end

function slot0.eventResetFunc(slot0)
	Stat1_3Controller.instance:bristleStatStart()
	slot0:_resetFunc()
end

function slot0._resetFunc(slot0)
	UIBlockMgr.instance:startBlock(uv0.UI_RESET_BLOCK_KEY)
	slot0:_playResetAniamtion(true)
	TaskDispatcher.runDelay(slot0.delayRestartGame, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function slot0.delayRestartGame(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)

	if Va3ChessModel.instance:getEpisodeId() then
		Activity1_3ChessController.instance:beginResetChessGame(slot1, slot0.playResetAniamtionClose, slot0)
	end
end

function slot0._editableInitView(slot0)
	slot0._lifeState = {
		true,
		true,
		true
	}

	MainCameraMgr.instance:addView(slot0.viewName, slot0.initCamera, slot0.resetCamera, slot0)
end

function slot0.initCamera(slot0)
	if Va3ChessGameModel.instance:isPlayingStory() then
		return
	end

	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)

	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function slot0.resetCamera(slot0)
	CameraMgr.instance:getMainCamera().orthographic = false

	Activity1_3ChessGameController.instance:setSceneCamera(false)
	slot0:removeEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, slot0._afterPlayStory, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goTipsRoot, false)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.GameTitleAppear)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshConditions, slot0)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)
	TaskDispatcher.cancelTask(slot0.delayReadProgress, slot0)
	TaskDispatcher.cancelTask(slot0._delayHideTips, slot0)
end

function slot0.refreshUI(slot0)
	if slot0:_getEpisodeCfg() then
		slot0._txtStage.text = slot1.orderId
		slot0._txtTitle.text = slot1.name
	end

	slot0:refreshConditions()
	slot0:refreshLifeCount()
end

function slot0.onSetViewVictory(slot0)
	Stat1_3Controller.instance:bristleStatSuccess()
	slot0:refreshConditions()

	if slot0:_getEpisodeCfg() then
		if slot1.storyClear == 0 then
			slot0.openWinResult()

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
			}, uv0.openWinResult)
		else
			slot0.openWinResult()
		end
	end
end

function slot0.openWinResult()
	slot1 = "OnChessWinPause" .. Va3ChessModel.instance:getEpisodeId()

	GuideController.instance:GuideFlowPauseAndContinue(slot1, GuideEvent[slot1], GuideEvent.OnChessWinContinue, uv0._openSuccessView, nil)
end

function slot0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = true
	})
end

function slot0.onSetViewFail(slot0)
	Stat1_3Controller.instance:bristleStatFail()
	slot0:refreshConditions()
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = false
	})
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.refreshConditions(slot0)
	if not slot0:_getEpisodeCfg() then
		return
	end

	slot2 = Va3ChessModel.instance:getActId()
	slot3 = Va3ChessGameModel.instance:getFinishedTargetNum() + 1
	slot0._curTargetIndex = slot3

	if slot0._curTargetIndex and slot0._curTargetIndex < slot3 and slot3 <= #string.split(slot1.starCondition, "|") then
		gohelper.setActive(slot0._gotargetFinish, false)
		gohelper.setActive(slot0._gotargetFinish, true)
		AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.MainTargetRefresh)
		TaskDispatcher.runDelay(slot0.refreshConditions, slot0, 0.5)

		return
	end

	if slot3 <= #slot4 then
		slot0._txtTargetDesc.text = string.split(slot1.conditionStr, "|")[slot3] or Va3ChessMapUtils.getClearConditionDesc(string.splitToNumber(slot4[slot3], "#"), slot2)
	else
		slot0._txtTargetDesc.text = slot6[#slot6]
	end

	slot0._imageTargetIcon.color = GameUtil.parseColor(Activity1_3ChessEnum.ChessGameEnum.MainTargetColorGray)

	if #string.split(slot1.extStarCondition, "|") > 1 then
		slot9 = true

		for slot13 = 1, #slot7 do
			if Va3ChessMapUtils.isClearConditionFinish(string.splitToNumber(slot7[slot13], "#"), slot2) then
				slot8 = 0 + 1
			end
		end

		slot9 = slot8 == #slot7
		slot0._txtTargetDesc2.text = string.format("%s (%s/%s)", slot1.extConditionStr, slot8, #slot7)
		slot0._imageTargetIcon2.color = GameUtil.parseColor(slot9 and Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

		if slot9 then
			gohelper.setActive(slot0._gotargetStar, true)
		end
	else
		slot8 = string.splitToNumber(slot1.extStarCondition, "#")
		slot9 = slot1.extConditionStr or Va3ChessMapUtils.getClearConditionDesc(slot8, slot2)
		slot10 = false

		if slot8[1] == Va3ChessEnum.ChessClearCondition.InteractAllFinish then
			slot11 = nil
			slot10, slot13 = Va3ChessMapUtils.isClearConditionFinish(slot8, slot2)
			slot9 = slot1.extConditionStr .. string.format("(%s/%s)", #slot8 - 1 - slot13, #slot8 - 1)
		else
			slot10 = Va3ChessMapUtils.isClearConditionFinish(slot8, slot2)
		end

		slot0._txtTargetDesc2.text = slot9
		slot0._imageTargetIcon2.color = GameUtil.parseColor(slot10 and Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

		if slot10 then
			gohelper.setActive(slot0._gotargetStar, true)
		end
	end
end

function slot0.initLifeCountView(slot0)
	for slot4 = 1, 3 do
		slot0["_animatorLife" .. slot4]:Play(uv0.normal)
	end
end

function slot0.refreshLifeCount(slot0, slot1)
	for slot7 = 1, 3 do
		if slot0._lifeState[slot7] and ({
			0,
			1,
			2
		})[slot7] < Va3ChessGameModel.instance:getHp() then
			slot0["_animatorLife" .. slot7]:Play(uv0.normal)
		elseif slot0._lifeState[slot7] then
			slot0._lifeState[slot7] = false

			if not slot1 then
				slot0["_animatorLife" .. slot7]:Play(uv0.losing)
			else
				slot0["_animatorLife" .. slot7]:Play(uv0.lose)
			end
		end
	end
end

function slot0.showTips(slot0, slot1)
	gohelper.setActive(slot0._goTipsRoot, true)

	slot0._txtTips.text = Va3ChessConfig.instance:getTipsCfg(Va3ChessModel.instance:getActId(), slot1).content

	TaskDispatcher.runDelay(slot0._delayHideTips, slot0, 3)
end

function slot0._delayHideTips(slot0)
	gohelper.setActive(slot0._goTipsRoot, false)
end

function slot0.onResetGame(slot0)
	slot0._lifeState = {
		true,
		true,
		true
	}

	slot0:refreshLifeCount(true)
end

function slot0.onReadGame(slot0)
	slot0._lifeState = {
		true,
		true,
		true
	}

	slot0:refreshLifeCount(true)
end

function slot0._beforeEnterNextMap(slot0)
	UIBlockMgr.instance:startBlock(uv0.UI_RESET_BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	slot0:_playNextMapAniamtion(true)
end

function slot0._onEnterNextMap(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESET_BLOCK_KEY)
	slot0:_playNextMapAniamtion(false)
end

function slot0._afterPlayStory(slot0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function slot0._getEpisodeCfg(slot0)
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() ~= nil and slot2 ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(slot1, slot2)
	end
end

function slot0._onPlayStoryFinish(slot0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function slot0._onReturnChessFromBattleGroup(slot0)
	Activity1_3ChessController.instance:requestBackChessGame(Va3ChessModel.instance:getActId())
end

function slot0.playCloseAniamtion(slot0)
	gohelper.setActive(slot0._goTop, false)
	slot0._viewAnimator:Play(UIAnimationName.Close)
end

function slot0.playViewAnimation(slot0, slot1)
	slot0._viewAnimator:Play(slot1, 0, 0)
end

function slot0.playResetAniamtionClose(slot0)
	slot0:_playResetAniamtion(false)
end

function slot0._playResetAniamtion(slot0, slot1)
	gohelper.setActive(slot0._goResetExcessive, true)
	slot0._animatorResetExcessive:Play(slot1 and uv0.open or uv0.close)
end

function slot0.playReadAniamtionClose(slot0)
	slot0:_playReadProgressAniamtion(false)
end

function slot0._playReadProgressAniamtion(slot0, slot1)
	gohelper.setActive(slot0._goResetExcessive, true)
	slot0._animatorResetExcessive:Play(slot1 and uv0.open or uv0.close)
end

function slot0._playNextMapAniamtion(slot0, slot1)
	gohelper.setActive(slot0._goNextMapExcessive, true)
	slot0._animatorNextMapExcessive:Play(slot1 and uv0.open or uv0.close)
end

return slot0
