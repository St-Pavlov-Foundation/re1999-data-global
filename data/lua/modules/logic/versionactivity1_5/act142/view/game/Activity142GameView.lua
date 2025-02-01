module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameView", package.seeall)

slot0 = class("Activity142GameView", BaseView)
slot1 = 5

function slot0.onInitView(slot0)
	slot0._txtStage = gohelper.findChildText(slot0.viewGO, "Top/#txt_Stage")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Top/#txt_Title")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Top/Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")

	gohelper.setActive(slot0._goTips, false)

	slot0._goMainTargetFinishBg = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/image_TargetFinishedBG")
	slot0._imgMainTargetIcon = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	slot0._goMainTargetLightIcon = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon/image_TargetIconLight")
	slot0._txtMainTargetDesc = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	slot0._goMainTargetFinishEff = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/vx_finish")

	gohelper.setActive(slot0._goMainTargetFinishBg, true)
	gohelper.setActive(slot0._goMainTargetLightIcon, false)
	gohelper.setActive(slot0._goMainTargetFinishEff, false)

	slot0._goSubTargetFinishBg = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2/image_TargetFinishedBG")
	slot0._imgSubTargetIcon = gohelper.findChildImage(slot0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	slot0._goSubTargetLightIcon = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon/image_TargetIconLight")
	slot0._txtSubTargetDesc = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	slot0._goSubTargetFinishEff = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target2/vx_finish")

	gohelper.setActive(slot0._goSubTargetFinishBg, false)
	gohelper.setActive(slot0._goSubTargetLightIcon, false)
	gohelper.setActive(slot0._goSubTargetFinishEff, false)

	slot0._btnBacktrack = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_Backtrack")
	slot0._btnResetBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_Reset")
	slot0._goChangeMapEff = gohelper.findChild(slot0.viewGO, "#go_excessive")

	gohelper.setActive(slot0._goChangeMapEff, false)

	slot0._changeMapAnimator = gohelper.findChild(slot0.viewGO, "#go_excessive/anim"):GetComponent(Va3ChessEnum.ComponentType.Animator)
	slot0._goCloseEyeEff = gohelper.findChild(slot0.viewGO, "excessive")

	gohelper.setActive(slot0._goCloseEyeEff, false)

	slot0._closeEyeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "excessive/anim"))
	slot0._viewAnimator = slot0.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, slot0.onSetViewVictory, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, slot0.onSetViewFail, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, slot0._onToastUpdate, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0._btnBacktrack:AddClickListener(slot0._btnBackTrackOnClick, slot0)
	slot0._btnResetBtn:AddClickListener(slot0._btnResetBtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, slot0.onSetViewVictory, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, slot0.onSetViewFail, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, slot0._onToastUpdate, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0._btnResetBtn:RemoveClickListener()
	slot0._btnBacktrack:RemoveClickListener()
end

function slot0.onSetViewVictory(slot0)
	slot0:refreshConditions()
	Activity142Helper.openWinResult()
	Activity142StatController.instance:statSuccess()
end

function slot0.onSetViewFail(slot0)
	slot0:back2CheckPointWithEff(true)
end

function slot0.onResultQuit(slot0)
	if not slot0:_getEpisodeCfg() or slot1.storyClear == 0 then
		slot0:closeThis()

		return
	end

	if slot1.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(slot1.storyClear) then
		StoryController.instance:playStories({
			slot2
		}, {
			blur = true,
			mark = true,
			hideStartAndEndDark = true,
			isReplay = false
		}, slot0.closeThis, slot0)
	else
		slot0:closeThis()
	end
end

function slot0._onToastUpdate(slot0, slot1)
	if Va3ChessModel.instance:getActId() ~= Va3ChessEnum.ActivityId.Act142 then
		return
	end

	if not Va3ChessConfig.instance:getTipsCfg(slot2, slot1) then
		return
	end

	if slot3.audioId and slot3.audioId ~= 0 then
		AudioMgr.instance:trigger(slot3.audioId)
	end

	TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
	TaskDispatcher.runDelay(slot0._onHideToast, slot0, uv0)

	slot0._txtTips.text = slot3.tips

	gohelper.setActive(slot0._goTips, true)
end

function slot0._onHideToast(slot0)
	gohelper.setActive(slot0._goTips, false)
end

function slot0._btnBackTrackOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity142BackTrace, MsgBoxEnum.BoxType.Yes_No, slot0.back2CheckPointWithEff, nil, , slot0)
end

function slot0._btnResetBtnOnClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, slot0.resetWithEff, nil, , slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.EnterGameView)
end

function slot0._getEpisodeCfg(slot0)
	slot1 = Va3ChessModel.instance:getActId()
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if slot0._episodeCfg and slot0._episodeCfg.activity == slot1 and slot0._episodeCfg.id == slot2 then
		return slot0._episodeCfg
	end

	if slot1 ~= nil and slot2 ~= nil then
		slot0._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(slot1, slot2)

		return slot0._episodeCfg
	end
end

function slot0.refreshUI(slot0)
	if slot0:_getEpisodeCfg() then
		slot0._txtStage.text = slot1.orderId
		slot0._txtTitle.text = slot1.name
	end

	slot0:refreshConditions()
end

function slot0.refreshConditions(slot0)
	if not slot0:_getEpisodeCfg() then
		return
	end

	slot0._txtMainTargetDesc.text = slot1.mainConditionStr

	if slot0._lastIsFinishAllMainCon ~= Activity142Helper.checkConditionIsFinish(slot1.mainConfition, slot1.activityId) then
		slot0._lastIsFinishAllMainCon = slot3

		slot0:_isTriggerFinish(slot3, slot0._goMainTargetLightIcon, nil, slot0._goMainTargetFinishEff)
	end

	slot0._txtSubTargetDesc.text = slot1.conditionStr

	if slot0._lastIsFinishAllSubCon ~= Activity142Helper.checkConditionIsFinish(slot1.extStarCondition, slot2) then
		slot0._lastIsFinishAllSubCon = slot4

		slot0:_isTriggerFinish(slot4, slot0._goSubTargetLightIcon, nil, slot0._goSubTargetFinishEff)
	end
end

function slot0._isTriggerFinish(slot0, slot1, slot2, slot3, slot4)
	if not gohelper.isNil(slot2) then
		gohelper.setActive(slot2, slot1)
	end

	if not gohelper.isNil(slot3) then
		gohelper.setActive(slot3, slot1)
	end

	if not gohelper.isNil(slot4) then
		if slot1 then
			gohelper.setActive(slot4, false)
			gohelper.setActive(slot4, true)
		else
			gohelper.setActive(slot4, false)
		end
	end
end

function slot0.back2CheckPointWithEff(slot0, slot1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RETURN_CHECK_POINT)

	if slot1 then
		Activity142StatController.instance:statFail()
	else
		Activity142StatController.instance:statBack2CheckPoint()
	end

	slot0:_playCloseEyeAnim(true, slot0.beginBack2CheckPoint, slot0)
end

function slot0.beginBack2CheckPoint(slot0)
	Activity142Controller.instance:act142Back2CheckPoint(slot0.onBackCheckPointCb, slot0)
end

function slot0.onBackCheckPointCb(slot0, slot1, slot2, slot3)
	TaskDispatcher.cancelTask(slot0.back2CheckPointFinish, slot0)
	TaskDispatcher.runDelay(slot0.back2CheckPointFinish, slot0, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function slot0.back2CheckPointFinish(slot0)
	slot0:_playCloseEyeAnim(false, slot0.back2CheckPointWithEffComplete, slot0)
end

function slot0.back2CheckPointWithEffComplete(slot0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RETURN_CHECK_POINT)
end

function slot0.resetWithEff(slot0)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RESET_GAME)
	Activity142StatController.instance:statReset()
	slot0:_playCloseEyeAnim(true, slot0.beginReset, slot0)
end

function slot0.beginReset(slot0)
	Activity142Controller.instance:act142ResetGame(slot0.onResetCb, slot0)
end

function slot0.onResetCb(slot0, slot1, slot2, slot3)
	TaskDispatcher.cancelTask(slot0.onResetFinish, slot0)
	TaskDispatcher.runDelay(slot0.onResetFinish, slot0, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function slot0.onResetFinish(slot0)
	slot0:_playCloseEyeAnim(false, slot0.resetWithEffComplete, slot0)
end

function slot0.resetWithEffComplete(slot0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RESET_GAME)
end

function slot0._playCloseEyeAnim(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot0._goCloseEyeEff) or gohelper.isNil(slot0._closeEyeAnimatorPlayer) then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	gohelper.setActive(slot0._goCloseEyeEff, true)
	slot0._closeEyeAnimatorPlayer:Play(slot1 and Activity142Enum.GAME_VIEW_EYE_CLOSE_ANIM or Activity142Enum.GAME_VIEW_EYE_OPEN_ANIM, slot2, slot3)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.chess_activity142.CloseEye)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
	TaskDispatcher.cancelTask(slot0.back2CheckPointFinish, slot0)
	TaskDispatcher.cancelTask(slot0.onResetFinish, slot0)
	slot0:back2CheckPointWithEffComplete()
	slot0:resetWithEffComplete()
end

return slot0
