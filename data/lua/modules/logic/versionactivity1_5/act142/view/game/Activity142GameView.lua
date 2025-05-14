module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameView", package.seeall)

local var_0_0 = class("Activity142GameView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Stage")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Title")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Top/Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")

	gohelper.setActive(arg_1_0._goTips, false)

	arg_1_0._goMainTargetFinishBg = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target1/image_TargetFinishedBG")
	arg_1_0._imgMainTargetIcon = gohelper.findChildImage(arg_1_0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	arg_1_0._goMainTargetLightIcon = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon/image_TargetIconLight")
	arg_1_0._txtMainTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	arg_1_0._goMainTargetFinishEff = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target1/vx_finish")

	gohelper.setActive(arg_1_0._goMainTargetFinishBg, true)
	gohelper.setActive(arg_1_0._goMainTargetLightIcon, false)
	gohelper.setActive(arg_1_0._goMainTargetFinishEff, false)

	arg_1_0._goSubTargetFinishBg = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target2/image_TargetFinishedBG")
	arg_1_0._imgSubTargetIcon = gohelper.findChildImage(arg_1_0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	arg_1_0._goSubTargetLightIcon = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon/image_TargetIconLight")
	arg_1_0._txtSubTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	arg_1_0._goSubTargetFinishEff = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target2/vx_finish")

	gohelper.setActive(arg_1_0._goSubTargetFinishBg, false)
	gohelper.setActive(arg_1_0._goSubTargetLightIcon, false)
	gohelper.setActive(arg_1_0._goSubTargetFinishEff, false)

	arg_1_0._btnBacktrack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_Backtrack")
	arg_1_0._btnResetBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_Reset")
	arg_1_0._goChangeMapEff = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	gohelper.setActive(arg_1_0._goChangeMapEff, false)

	arg_1_0._changeMapAnimator = gohelper.findChild(arg_1_0.viewGO, "#go_excessive/anim"):GetComponent(Va3ChessEnum.ComponentType.Animator)
	arg_1_0._goCloseEyeEff = gohelper.findChild(arg_1_0.viewGO, "excessive")

	gohelper.setActive(arg_1_0._goCloseEyeEff, false)

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "excessive/anim")

	arg_1_0._closeEyeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_1_0)
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, arg_2_0.onSetViewVictory, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, arg_2_0.onSetViewFail, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, arg_2_0.onResultQuit, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, arg_2_0._onToastUpdate, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, arg_2_0.refreshConditions, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0._btnBacktrack:AddClickListener(arg_2_0._btnBackTrackOnClick, arg_2_0)
	arg_2_0._btnResetBtn:AddClickListener(arg_2_0._btnResetBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, arg_3_0.onSetViewVictory, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, arg_3_0.onSetViewFail, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, arg_3_0.onResultQuit, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, arg_3_0._onToastUpdate, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, arg_3_0.refreshConditions, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0._btnResetBtn:RemoveClickListener()
	arg_3_0._btnBacktrack:RemoveClickListener()
end

function var_0_0.onSetViewVictory(arg_4_0)
	arg_4_0:refreshConditions()
	Activity142Helper.openWinResult()
	Activity142StatController.instance:statSuccess()
end

function var_0_0.onSetViewFail(arg_5_0)
	arg_5_0:back2CheckPointWithEff(true)
end

function var_0_0.onResultQuit(arg_6_0)
	local var_6_0 = arg_6_0:_getEpisodeCfg()

	if not var_6_0 or var_6_0.storyClear == 0 then
		arg_6_0:closeThis()

		return
	end

	local var_6_1 = var_6_0.storyClear

	if var_6_0.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(var_6_1) then
		local var_6_2 = {}

		var_6_2.blur = true
		var_6_2.mark = true
		var_6_2.hideStartAndEndDark = true
		var_6_2.isReplay = false

		StoryController.instance:playStories({
			var_6_1
		}, var_6_2, arg_6_0.closeThis, arg_6_0)
	else
		arg_6_0:closeThis()
	end
end

function var_0_0._onToastUpdate(arg_7_0, arg_7_1)
	local var_7_0 = Va3ChessModel.instance:getActId()

	if var_7_0 ~= Va3ChessEnum.ActivityId.Act142 then
		return
	end

	local var_7_1 = Va3ChessConfig.instance:getTipsCfg(var_7_0, arg_7_1)

	if not var_7_1 then
		return
	end

	if var_7_1.audioId and var_7_1.audioId ~= 0 then
		AudioMgr.instance:trigger(var_7_1.audioId)
	end

	TaskDispatcher.cancelTask(arg_7_0._onHideToast, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._onHideToast, arg_7_0, var_0_1)

	arg_7_0._txtTips.text = var_7_1.tips

	gohelper.setActive(arg_7_0._goTips, true)
end

function var_0_0._onHideToast(arg_8_0)
	gohelper.setActive(arg_8_0._goTips, false)
end

function var_0_0._btnBackTrackOnClick(arg_9_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity142BackTrace, MsgBoxEnum.BoxType.Yes_No, arg_9_0.back2CheckPointWithEff, nil, nil, arg_9_0)
end

function var_0_0._btnResetBtnOnClick(arg_10_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, arg_10_0.resetWithEff, nil, nil, arg_10_0)
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.EnterGameView)
end

function var_0_0._getEpisodeCfg(arg_13_0)
	local var_13_0 = Va3ChessModel.instance:getActId()
	local var_13_1 = Va3ChessModel.instance:getEpisodeId()

	if arg_13_0._episodeCfg and arg_13_0._episodeCfg.activity == var_13_0 and arg_13_0._episodeCfg.id == var_13_1 then
		return arg_13_0._episodeCfg
	end

	if var_13_0 ~= nil and var_13_1 ~= nil then
		arg_13_0._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(var_13_0, var_13_1)

		return arg_13_0._episodeCfg
	end
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = arg_14_0:_getEpisodeCfg()

	if var_14_0 then
		arg_14_0._txtStage.text = var_14_0.orderId
		arg_14_0._txtTitle.text = var_14_0.name
	end

	arg_14_0:refreshConditions()
end

function var_0_0.refreshConditions(arg_15_0)
	local var_15_0 = arg_15_0:_getEpisodeCfg()

	if not var_15_0 then
		return
	end

	local var_15_1 = var_15_0.activityId

	arg_15_0._txtMainTargetDesc.text = var_15_0.mainConditionStr

	local var_15_2 = Activity142Helper.checkConditionIsFinish(var_15_0.mainConfition, var_15_1)

	if arg_15_0._lastIsFinishAllMainCon ~= var_15_2 then
		arg_15_0._lastIsFinishAllMainCon = var_15_2

		arg_15_0:_isTriggerFinish(var_15_2, arg_15_0._goMainTargetLightIcon, nil, arg_15_0._goMainTargetFinishEff)
	end

	arg_15_0._txtSubTargetDesc.text = var_15_0.conditionStr

	local var_15_3 = Activity142Helper.checkConditionIsFinish(var_15_0.extStarCondition, var_15_1)

	if arg_15_0._lastIsFinishAllSubCon ~= var_15_3 then
		arg_15_0._lastIsFinishAllSubCon = var_15_3

		arg_15_0:_isTriggerFinish(var_15_3, arg_15_0._goSubTargetLightIcon, nil, arg_15_0._goSubTargetFinishEff)
	end
end

function var_0_0._isTriggerFinish(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if not gohelper.isNil(arg_16_2) then
		gohelper.setActive(arg_16_2, arg_16_1)
	end

	if not gohelper.isNil(arg_16_3) then
		gohelper.setActive(arg_16_3, arg_16_1)
	end

	if not gohelper.isNil(arg_16_4) then
		if arg_16_1 then
			gohelper.setActive(arg_16_4, false)
			gohelper.setActive(arg_16_4, true)
		else
			gohelper.setActive(arg_16_4, false)
		end
	end
end

function var_0_0.back2CheckPointWithEff(arg_17_0, arg_17_1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RETURN_CHECK_POINT)

	if arg_17_1 then
		Activity142StatController.instance:statFail()
	else
		Activity142StatController.instance:statBack2CheckPoint()
	end

	arg_17_0:_playCloseEyeAnim(true, arg_17_0.beginBack2CheckPoint, arg_17_0)
end

function var_0_0.beginBack2CheckPoint(arg_18_0)
	Activity142Controller.instance:act142Back2CheckPoint(arg_18_0.onBackCheckPointCb, arg_18_0)
end

function var_0_0.onBackCheckPointCb(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	TaskDispatcher.cancelTask(arg_19_0.back2CheckPointFinish, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.back2CheckPointFinish, arg_19_0, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function var_0_0.back2CheckPointFinish(arg_20_0)
	arg_20_0:_playCloseEyeAnim(false, arg_20_0.back2CheckPointWithEffComplete, arg_20_0)
end

function var_0_0.back2CheckPointWithEffComplete(arg_21_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RETURN_CHECK_POINT)
end

function var_0_0.resetWithEff(arg_22_0)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RESET_GAME)
	Activity142StatController.instance:statReset()
	arg_22_0:_playCloseEyeAnim(true, arg_22_0.beginReset, arg_22_0)
end

function var_0_0.beginReset(arg_23_0)
	Activity142Controller.instance:act142ResetGame(arg_23_0.onResetCb, arg_23_0)
end

function var_0_0.onResetCb(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	TaskDispatcher.cancelTask(arg_24_0.onResetFinish, arg_24_0)
	TaskDispatcher.runDelay(arg_24_0.onResetFinish, arg_24_0, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function var_0_0.onResetFinish(arg_25_0)
	arg_25_0:_playCloseEyeAnim(false, arg_25_0.resetWithEffComplete, arg_25_0)
end

function var_0_0.resetWithEffComplete(arg_26_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RESET_GAME)
end

function var_0_0._playCloseEyeAnim(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if gohelper.isNil(arg_27_0._goCloseEyeEff) or gohelper.isNil(arg_27_0._closeEyeAnimatorPlayer) then
		if arg_27_2 then
			arg_27_2(arg_27_3)
		end

		return
	end

	gohelper.setActive(arg_27_0._goCloseEyeEff, true)

	local var_27_0 = arg_27_1 and Activity142Enum.GAME_VIEW_EYE_CLOSE_ANIM or Activity142Enum.GAME_VIEW_EYE_OPEN_ANIM

	arg_27_0._closeEyeAnimatorPlayer:Play(var_27_0, arg_27_2, arg_27_3)

	if arg_27_1 then
		AudioMgr.instance:trigger(AudioEnum.chess_activity142.CloseEye)
	end
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._onHideToast, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.back2CheckPointFinish, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.onResetFinish, arg_28_0)
	arg_28_0:back2CheckPointWithEffComplete()
	arg_28_0:resetWithEffComplete()
end

return var_0_0
