module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameView", package.seeall)

local var_0_0 = class("Activity1_3ChessGameView", BaseView)
local var_0_1 = {
	lose = "idle_black",
	losing = "hit",
	normal = "idle_light"
}
local var_0_2 = {
	loop = "loop",
	open = "open",
	close = "close"
}

var_0_0.UI_RESET_BLOCK_KEY = "Activity1_3ChessGameViewResetBlock"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animatorLife1 = gohelper.findChildComponent(arg_1_0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons1", typeof(UnityEngine.Animator))
	arg_1_0._animatorLife2 = gohelper.findChildComponent(arg_1_0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons2", typeof(UnityEngine.Animator))
	arg_1_0._animatorLife3 = gohelper.findChildComponent(arg_1_0.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons3", typeof(UnityEngine.Animator))
	arg_1_0._txtTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	arg_1_0._imageTargetIcon = gohelper.findChildImage(arg_1_0.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	arg_1_0._gotargetFinish = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	arg_1_0._txtTargetDesc2 = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	arg_1_0._imageTargetIcon2 = gohelper.findChildImage(arg_1_0.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	arg_1_0._gotargetStar = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Stage")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Title")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	arg_1_0._btnResetBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ResetBtn")
	arg_1_0._btnReadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ReadBtn")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goTop = gohelper.findChild(arg_1_0.viewGO, "Top")
	arg_1_0._exTargetGo = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList/Target2")
	arg_1_0._goTargetList = gohelper.findChild(arg_1_0.viewGO, "LeftTop/TargetList")
	arg_1_0._goTipsRoot = gohelper.findChild(arg_1_0.viewGO, "Top/Tips")
	arg_1_0._goResetExcessive = gohelper.findChild(arg_1_0.viewGO, "excessive")
	arg_1_0._goNextMapExcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	gohelper.setActive(arg_1_0._goResetExcessive, false)
	gohelper.setActive(arg_1_0._goNextMapExcessive, false)

	arg_1_0._animatorResetExcessive = gohelper.findChildComponent(arg_1_0.viewGO, "excessive/anim", typeof(UnityEngine.Animator))
	arg_1_0._animatorNextMapExcessive = gohelper.findChildComponent(arg_1_0.viewGO, "#go_excessive/anim", typeof(UnityEngine.Animator))
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnResetBtn:AddClickListener(arg_2_0._btnResetBtnOnClick, arg_2_0)
	arg_2_0._btnReadBtn:AddClickListener(arg_2_0._btnBackOnClick, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, arg_2_0.onSetViewVictory, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, arg_2_0.onSetViewFail, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, arg_2_0.refreshLifeCount, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, arg_2_0.onResultQuit, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, arg_2_0.refreshConditions, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TargetUpdate, arg_2_0.refreshConditions, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, arg_2_0.showTips, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.BeforeEnterNextMap, arg_2_0._beforeEnterNextMap, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_2_0._onEnterNextMap, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.PlayStoryFinish, arg_2_0._onPlayStoryFinish, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, arg_2_0._onReturnChessFromBattleGroup, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, arg_2_0.onResetGame, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, arg_2_0.onReadGame, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickReset, arg_2_0.eventResetFunc, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickRead, arg_2_0._btnReadBtnOnClick, arg_2_0)
	arg_2_0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, arg_2_0._afterPlayStory, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnResetBtn:RemoveClickListener()
	arg_3_0._btnReadBtn:RemoveClickListener()
end

function var_0_0._btnBackOnClick(arg_4_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	local var_4_0 = Va3ChessModel.instance:getActId()

	Stat1_3Controller.instance:bristleMarkUseRead()
	Activity1_3ChessController.instance:requestBackChessGame(var_4_0)
end

function var_0_0._btnReadBtnOnClick(arg_5_0)
	Stat1_3Controller.instance:bristleMarkUseRead()
	UIBlockMgr.instance:startBlock(var_0_0.UI_RESET_BLOCK_KEY)
	arg_5_0:_playReadProgressAniamtion(true)
	TaskDispatcher.runDelay(arg_5_0.delayReadProgress, arg_5_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function var_0_0.delayReadProgress(arg_6_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_6_0.delayReadProgress, arg_6_0)

	local var_6_0 = Va3ChessModel.instance:getActId()

	Activity1_3ChessController.instance:requestReadChessGame(var_6_0, arg_6_0.playReadAniamtionClose, arg_6_0)
end

function var_0_0._btnResetBtnOnClick(arg_7_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, arg_7_0.btnResetFunc, nil, nil, arg_7_0)
end

function var_0_0.btnResetFunc(arg_8_0)
	Stat1_3Controller.instance:bristleStatReset()
	arg_8_0:_resetFunc()
end

function var_0_0.eventResetFunc(arg_9_0)
	Stat1_3Controller.instance:bristleStatStart()
	arg_9_0:_resetFunc()
end

function var_0_0._resetFunc(arg_10_0)
	UIBlockMgr.instance:startBlock(var_0_0.UI_RESET_BLOCK_KEY)
	arg_10_0:_playResetAniamtion(true)
	TaskDispatcher.runDelay(arg_10_0.delayRestartGame, arg_10_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function var_0_0.delayRestartGame(arg_11_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_11_0.delayRestartGame, arg_11_0)

	local var_11_0 = Va3ChessModel.instance:getEpisodeId()

	if var_11_0 then
		Activity1_3ChessController.instance:beginResetChessGame(var_11_0, arg_11_0.playResetAniamtionClose, arg_11_0)
	end
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._lifeState = {
		true,
		true,
		true
	}

	MainCameraMgr.instance:addView(arg_12_0.viewName, arg_12_0.initCamera, arg_12_0.resetCamera, arg_12_0)
end

function var_0_0.initCamera(arg_13_0)
	if Va3ChessGameModel.instance:isPlayingStory() then
		return
	end

	local var_13_0 = CameraMgr.instance:getMainCamera()

	var_13_0.orthographic = true
	var_13_0.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)

	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function var_0_0.resetCamera(arg_14_0)
	CameraMgr.instance:getMainCamera().orthographic = false

	Activity1_3ChessGameController.instance:setSceneCamera(false)
	arg_14_0:removeEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, arg_14_0._afterPlayStory, arg_14_0)
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	gohelper.setActive(arg_16_0._goTipsRoot, false)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.GameTitleAppear)
	arg_16_0:refreshUI()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refreshConditions, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.delayRestartGame, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.delayReadProgress, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._delayHideTips, arg_18_0)
end

function var_0_0.refreshUI(arg_19_0)
	local var_19_0 = arg_19_0:_getEpisodeCfg()

	if var_19_0 then
		arg_19_0._txtStage.text = var_19_0.orderId
		arg_19_0._txtTitle.text = var_19_0.name
	end

	arg_19_0:refreshConditions()
	arg_19_0:refreshLifeCount()
end

function var_0_0.onSetViewVictory(arg_20_0)
	Stat1_3Controller.instance:bristleStatSuccess()
	arg_20_0:refreshConditions()

	local var_20_0 = arg_20_0:_getEpisodeCfg()

	if var_20_0 then
		if var_20_0.storyClear == 0 then
			arg_20_0.openWinResult()

			return
		end

		local var_20_1 = var_20_0.storyClear

		if var_20_0.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(var_20_1) then
			local var_20_2 = {}

			var_20_2.blur = true
			var_20_2.mark = true
			var_20_2.hideStartAndEndDark = true
			var_20_2.isReplay = false

			StoryController.instance:playStories({
				var_20_1
			}, var_20_2, var_0_0.openWinResult)
		else
			arg_20_0.openWinResult()
		end
	end
end

function var_0_0.openWinResult()
	local var_21_0 = Va3ChessModel.instance:getEpisodeId()
	local var_21_1 = "OnChessWinPause" .. var_21_0
	local var_21_2 = GuideEvent[var_21_1]
	local var_21_3 = GuideEvent.OnChessWinContinue
	local var_21_4 = var_0_0._openSuccessView
	local var_21_5

	GuideController.instance:GuideFlowPauseAndContinue(var_21_1, var_21_2, var_21_3, var_21_4, var_21_5)
end

function var_0_0._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = true
	})
end

function var_0_0.onSetViewFail(arg_23_0)
	Stat1_3Controller.instance:bristleStatFail()
	arg_23_0:refreshConditions()
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = false
	})
end

function var_0_0.onResultQuit(arg_24_0)
	arg_24_0:closeThis()
end

function var_0_0.refreshConditions(arg_25_0)
	local var_25_0 = arg_25_0:_getEpisodeCfg()

	if not var_25_0 then
		return
	end

	local var_25_1 = Va3ChessModel.instance:getActId()
	local var_25_2 = Va3ChessGameModel.instance:getFinishedTargetNum() + 1
	local var_25_3 = string.split(var_25_0.starCondition, "|")
	local var_25_4 = arg_25_0._curTargetIndex and var_25_2 > arg_25_0._curTargetIndex and var_25_2 <= #var_25_3

	arg_25_0._curTargetIndex = var_25_2

	if var_25_4 then
		gohelper.setActive(arg_25_0._gotargetFinish, false)
		gohelper.setActive(arg_25_0._gotargetFinish, true)
		AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.MainTargetRefresh)
		TaskDispatcher.runDelay(arg_25_0.refreshConditions, arg_25_0, 0.5)

		return
	end

	local var_25_5 = string.split(var_25_0.conditionStr, "|")

	if var_25_2 <= #var_25_3 then
		local var_25_6 = string.splitToNumber(var_25_3[var_25_2], "#")

		arg_25_0._txtTargetDesc.text = var_25_5[var_25_2] or Va3ChessMapUtils.getClearConditionDesc(var_25_6, var_25_1)
	else
		arg_25_0._txtTargetDesc.text = var_25_5[#var_25_5]
	end

	arg_25_0._imageTargetIcon.color = GameUtil.parseColor(Activity1_3ChessEnum.ChessGameEnum.MainTargetColorGray)

	local var_25_7 = string.split(var_25_0.extStarCondition, "|")

	if #var_25_7 > 1 then
		local var_25_8 = 0
		local var_25_9 = true

		for iter_25_0 = 1, #var_25_7 do
			local var_25_10 = string.splitToNumber(var_25_7[iter_25_0], "#")

			if Va3ChessMapUtils.isClearConditionFinish(var_25_10, var_25_1) then
				var_25_8 = var_25_8 + 1
			end
		end

		local var_25_11 = var_25_8 == #var_25_7
		local var_25_12 = var_25_0.extConditionStr
		local var_25_13 = string.format("%s (%s/%s)", var_25_12, var_25_8, #var_25_7)

		arg_25_0._txtTargetDesc2.text = var_25_13

		local var_25_14 = GameUtil.parseColor(var_25_11 and Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

		arg_25_0._imageTargetIcon2.color = var_25_14

		if var_25_11 then
			gohelper.setActive(arg_25_0._gotargetStar, true)
		end
	else
		local var_25_15 = string.splitToNumber(var_25_0.extStarCondition, "#")
		local var_25_16 = var_25_0.extConditionStr or Va3ChessMapUtils.getClearConditionDesc(var_25_15, var_25_1)
		local var_25_17 = false

		if var_25_15[1] == Va3ChessEnum.ChessClearCondition.InteractAllFinish then
			local var_25_18
			local var_25_19

			var_25_17, var_25_19 = Va3ChessMapUtils.isClearConditionFinish(var_25_15, var_25_1)
			var_25_16 = var_25_0.extConditionStr .. string.format("(%s/%s)", #var_25_15 - 1 - var_25_19, #var_25_15 - 1)
		else
			var_25_17 = Va3ChessMapUtils.isClearConditionFinish(var_25_15, var_25_1)
		end

		arg_25_0._txtTargetDesc2.text = var_25_16

		local var_25_20 = GameUtil.parseColor(var_25_17 and Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

		arg_25_0._imageTargetIcon2.color = var_25_20

		if var_25_17 then
			gohelper.setActive(arg_25_0._gotargetStar, true)
		end
	end
end

function var_0_0.initLifeCountView(arg_26_0)
	for iter_26_0 = 1, 3 do
		arg_26_0["_animatorLife" .. iter_26_0]:Play(var_0_1.normal)
	end
end

function var_0_0.refreshLifeCount(arg_27_0, arg_27_1)
	local var_27_0 = Va3ChessGameModel.instance:getHp()
	local var_27_1 = {
		0,
		1,
		2
	}

	for iter_27_0 = 1, 3 do
		if arg_27_0._lifeState[iter_27_0] and var_27_0 > var_27_1[iter_27_0] then
			arg_27_0["_animatorLife" .. iter_27_0]:Play(var_0_1.normal)
		elseif arg_27_0._lifeState[iter_27_0] then
			arg_27_0._lifeState[iter_27_0] = false

			if not arg_27_1 then
				arg_27_0["_animatorLife" .. iter_27_0]:Play(var_0_1.losing)
			else
				arg_27_0["_animatorLife" .. iter_27_0]:Play(var_0_1.lose)
			end
		end
	end
end

function var_0_0.showTips(arg_28_0, arg_28_1)
	local var_28_0 = Va3ChessModel.instance:getActId()
	local var_28_1 = Va3ChessConfig.instance:getTipsCfg(var_28_0, arg_28_1)

	gohelper.setActive(arg_28_0._goTipsRoot, true)

	arg_28_0._txtTips.text = var_28_1.content

	TaskDispatcher.runDelay(arg_28_0._delayHideTips, arg_28_0, 3)
end

function var_0_0._delayHideTips(arg_29_0)
	gohelper.setActive(arg_29_0._goTipsRoot, false)
end

function var_0_0.onResetGame(arg_30_0)
	arg_30_0._lifeState = {
		true,
		true,
		true
	}

	arg_30_0:refreshLifeCount(true)
end

function var_0_0.onReadGame(arg_31_0)
	arg_31_0._lifeState = {
		true,
		true,
		true
	}

	arg_31_0:refreshLifeCount(true)
end

function var_0_0._beforeEnterNextMap(arg_32_0)
	UIBlockMgr.instance:startBlock(var_0_0.UI_RESET_BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	arg_32_0:_playNextMapAniamtion(true)
end

function var_0_0._onEnterNextMap(arg_33_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESET_BLOCK_KEY)
	arg_33_0:_playNextMapAniamtion(false)
end

function var_0_0._afterPlayStory(arg_34_0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function var_0_0._getEpisodeCfg(arg_35_0)
	local var_35_0 = Va3ChessModel.instance:getActId()
	local var_35_1 = Va3ChessModel.instance:getEpisodeId()

	if var_35_0 ~= nil and var_35_1 ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(var_35_0, var_35_1)
	end
end

function var_0_0._onPlayStoryFinish(arg_36_0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function var_0_0._onReturnChessFromBattleGroup(arg_37_0)
	local var_37_0 = Va3ChessModel.instance:getActId()

	Activity1_3ChessController.instance:requestBackChessGame(var_37_0)
end

function var_0_0.playCloseAniamtion(arg_38_0)
	gohelper.setActive(arg_38_0._goTop, false)
	arg_38_0._viewAnimator:Play(UIAnimationName.Close)
end

function var_0_0.playViewAnimation(arg_39_0, arg_39_1)
	arg_39_0._viewAnimator:Play(arg_39_1, 0, 0)
end

function var_0_0.playResetAniamtionClose(arg_40_0)
	arg_40_0:_playResetAniamtion(false)
end

function var_0_0._playResetAniamtion(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._goResetExcessive, true)
	arg_41_0._animatorResetExcessive:Play(arg_41_1 and var_0_2.open or var_0_2.close)
end

function var_0_0.playReadAniamtionClose(arg_42_0)
	arg_42_0:_playReadProgressAniamtion(false)
end

function var_0_0._playReadProgressAniamtion(arg_43_0, arg_43_1)
	gohelper.setActive(arg_43_0._goResetExcessive, true)
	arg_43_0._animatorResetExcessive:Play(arg_43_1 and var_0_2.open or var_0_2.close)
end

function var_0_0._playNextMapAniamtion(arg_44_0, arg_44_1)
	gohelper.setActive(arg_44_0._goNextMapExcessive, true)
	arg_44_0._animatorNextMapExcessive:Play(arg_44_1 and var_0_2.open or var_0_2.close)
end

return var_0_0
