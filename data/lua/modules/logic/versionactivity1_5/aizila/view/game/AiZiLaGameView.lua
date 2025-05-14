module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameView", package.seeall)

local var_0_0 = class("AiZiLaGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Title")
	arg_1_0._txtHeight = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_Height")
	arg_1_0._txtRemainingTimesNum = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/RemainingTimes/#txt_RemainingTimesNum")
	arg_1_0._txtTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/TargetItem/#txt_TargetDesc")
	arg_1_0._btnstate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottm/#btn_state")
	arg_1_0._btnpack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottm/#btn_pack")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LeftBottm/#btn_equip")
	arg_1_0._txtInfo = gohelper.findChildText(arg_1_0.viewGO, "RightTop/#txt_Info")
	arg_1_0._txtdaydesc = gohelper.findChildText(arg_1_0.viewGO, "RightTop/#txt_daydesc")
	arg_1_0._btnforwardgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottm/#btn_forwardgame")
	arg_1_0._goCostBG = gohelper.findChild(arg_1_0.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG")
	arg_1_0._txtforwardCost = gohelper.findChildText(arg_1_0.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG/#txt_forwardCost")
	arg_1_0._goEnable = gohelper.findChild(arg_1_0.viewGO, "RightBottm/#btn_forwardgame/#go_Enable")
	arg_1_0._goDisable = gohelper.findChild(arg_1_0.viewGO, "RightBottm/#btn_forwardgame/#go_Disable")
	arg_1_0._btnexitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottm/#btn_exitgame")
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightBottm/#btn_Continue")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstate:AddClickListener(arg_2_0._btnstateOnClick, arg_2_0)
	arg_2_0._btnpack:AddClickListener(arg_2_0._btnpackOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnforwardgame:AddClickListener(arg_2_0._btnforwardgameOnClick, arg_2_0)
	arg_2_0._btnexitgame:AddClickListener(arg_2_0._btnexitgameOnClick, arg_2_0)
	arg_2_0._btnContinue:AddClickListener(arg_2_0._btnContinueOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstate:RemoveClickListener()
	arg_3_0._btnpack:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnforwardgame:RemoveClickListener()
	arg_3_0._btnexitgame:RemoveClickListener()
	arg_3_0._btnContinue:RemoveClickListener()
end

function var_0_0._btnContinueOnClick(arg_4_0)
	if arg_4_0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
end

function var_0_0._btnstateOnClick(arg_5_0)
	if arg_5_0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameStateView)
end

function var_0_0._btnpackOnClick(arg_6_0)
	if arg_6_0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGamePackView)
end

function var_0_0._btnequipOnClick(arg_7_0)
	if arg_7_0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function var_0_0._btnforwardgameOnClick(arg_8_0)
	if arg_8_0:isLockOp() then
		return
	end

	local var_8_0 = arg_8_0:_getMO()

	if not var_8_0 then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	arg_8_0._isNeedShowBtnForwrdGame = false

	if arg_8_0:_isNotForwardGame() then
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		arg_8_0:refreshUI()

		return
	end

	if arg_8_0:_getCostActionPoint() > var_8_0.actionPoint then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	arg_8_0:_setLockOpTime(0.2)
	AiZiLaGameController.instance:forwardGame()
end

function var_0_0._btnexitgameOnClick(arg_9_0)
	if arg_9_0:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._goforwardgame = arg_10_0._btnforwardgame.gameObject
	arg_10_0._animator = arg_10_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_10_0._animatorTop = gohelper.findChildComponent(arg_10_0.viewGO, "Top", AiZiLaEnum.ComponentType.Animator)
	arg_10_0._govxcost = gohelper.findChild(arg_10_0.viewGO, "LeftTop/RemainingTimes/vx_cost")
	arg_10_0._goRightBottm = gohelper.findChild(arg_10_0.viewGO, "RightBottm")
	arg_10_0._goRightTop = gohelper.findChild(arg_10_0.viewGO, "RightTop")
	arg_10_0._goTop = gohelper.findChild(arg_10_0.viewGO, "Top")
	arg_10_0._txtExit = gohelper.findChildText(arg_10_0.viewGO, "RightBottm/#btn_exitgame/txt_Exit")
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	if arg_12_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_12_0.viewContainer.viewName, arg_12_0._btnexitgameOnClick, arg_12_0)
	end

	local var_12_0 = not GuideController.instance:isForbidGuides() and GuideModel.instance:isGuideRunning(AiZiLaEnum.Guide.FirstEnter)

	arg_12_0:_setLockOpTime(var_12_0 and 4 or 0.6)
	arg_12_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_12_0.closeThis, arg_12_0)
	arg_12_0:addEventCb(AiZiLaGameController.instance, AiZiLaEvent.RefreshGameEpsiode, arg_12_0._onRefreshGameEpsiode, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_12_0._onDestroyViewFinish, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_12_0._onOpenView, arg_12_0)

	arg_12_0._isNeedShowBtnForwrdGame = true

	arg_12_0:_refreshParam()
	arg_12_0:refreshUI()
	arg_12_0:_setCurElevation(AiZiLaGameModel.instance:getElevation())
	arg_12_0:_refreshActionPointUI()
	arg_12_0:_playAnimtor(arg_12_0._animatorTop, UIAnimationName.Open)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:_killTween()
	arg_14_0._simageFullBG:UnLoadImage()
end

function var_0_0._onRefreshGameEpsiode(arg_15_0)
	arg_15_0._isHasNeedRefresh = true

	arg_15_0:refreshUI()
	arg_15_0:_refreshActionPointUI()
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	arg_16_0:_refreshGoShow()
end

function var_0_0._onDestroyViewFinish(arg_17_0, arg_17_1)
	arg_17_0:_refreshGoShow()

	if arg_17_0._isHasNeedRefresh and arg_17_1 == ViewName.AiZiLaGameEventResult then
		arg_17_0._isHasNeedRefresh = false

		arg_17_0:refreshUI()
		arg_17_0:_refreshAnimUI()

		if arg_17_0:_getMO():isPass() then
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.CloseGameEventResult)
		end
	end
end

function var_0_0._refreshGoShow(arg_18_0)
	local var_18_0 = not (ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) or ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView)) and true or false

	if arg_18_0._lastIsShow ~= var_18_0 then
		arg_18_0._lastIsShow = var_18_0

		gohelper.setActive(arg_18_0._goTop, var_18_0)
		gohelper.setActive(arg_18_0._goRightBottm, var_18_0)
		gohelper.setActive(arg_18_0._goRightTop, var_18_0)
	end
end

function var_0_0._refreshParam(arg_19_0)
	local var_19_0 = arg_19_0:_getMO()
	local var_19_1 = var_19_0 and var_19_0:getTargetIds() or {}

	arg_19_0._minEle = arg_19_0:getElevation(var_19_1[1]) or 0
	arg_19_0._targetEle = arg_19_0:getElevation(var_19_1[2]) or 0
	arg_19_0._maxEle = arg_19_0:getElevation(var_19_1[#var_19_1]) or 0
	arg_19_0._showElevation = arg_19_0._showElevation or arg_19_0._minEle
end

function var_0_0.needPlayRiseAnim(arg_20_0)
	local var_20_0 = AiZiLaGameModel.instance:getElevation()

	return arg_20_0._showElevation and var_20_0 > arg_20_0._showElevation
end

function var_0_0.refreshUI(arg_21_0)
	local var_21_0 = arg_21_0:_getMO()

	if not var_21_0 then
		return
	end

	local var_21_1 = var_21_0:getConfig()

	if var_21_1 and arg_21_0._lastEpisodeId ~= var_21_1.episodeId and not string.nilorempty(var_21_1.bgPath) then
		arg_21_0._lastEpisodeId = var_21_1.episodeId

		arg_21_0._simageFullBG:LoadImage(string.format("%s.png", var_21_1.bgPath))
	end

	arg_21_0._txtInfo.text = var_21_1 and var_21_1.name
	arg_21_0._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", var_21_0.day)

	local var_21_2 = true

	if arg_21_0:_isNotForwardGame() and not arg_21_0._isNeedShowBtnForwrdGame then
		var_21_2 = false
	end

	gohelper.setActive(arg_21_0._btnContinue, not var_21_2)
	gohelper.setActive(arg_21_0._btnforwardgame, var_21_2)
	gohelper.setActive(arg_21_0._btnContinue, not var_21_2)

	if var_21_2 then
		local var_21_3 = arg_21_0:_getCostActionPoint()

		gohelper.setActive(arg_21_0._txtforwardCost, var_21_3 > 0)

		local var_21_4 = var_21_0.actionPoint and var_21_3 > var_21_0.actionPoint
		local var_21_5 = formatLuaLang("v1a5_aizila_action_point_cost", -var_21_3)

		if var_21_4 then
			var_21_5 = string.format("<color=#dc5f56>%s</color>", var_21_5)
		end

		arg_21_0._txtforwardCost.text = var_21_5

		gohelper.setActive(arg_21_0._goEnable, not var_21_4)
		gohelper.setActive(arg_21_0._goDisable, var_21_4)
		ZProj.UGUIHelper.SetGrayscale(arg_21_0._goforwardgame, var_21_4)
	end

	local var_21_6 = var_21_0:isCanSafe()

	if arg_21_0._lastIsSafe ~= var_21_6 then
		arg_21_0._txtExit.text = luaLang(var_21_6 and "v1a5_aizila_safe_exit_game" or "v1a5_aizila_exit_game")
	end
end

function var_0_0._refreshActionPointUI(arg_22_0)
	local var_22_0 = arg_22_0:_getMO()
	local var_22_1 = var_22_0 and var_22_0.actionPoint or 0
	local var_22_2 = math.max(0, var_22_1)

	if arg_22_0._lastActionPoint and var_22_2 < arg_22_0._lastActionPoint then
		gohelper.setActive(arg_22_0._govxcost, false)
		gohelper.setActive(arg_22_0._govxcost, true)
	end

	arg_22_0._lastActionPoint = var_22_2
	arg_22_0._txtRemainingTimesNum.text = formatLuaLang("v1a5_aizila_action_point_tag", var_22_2)
end

function var_0_0._refreshAnimUI(arg_23_0)
	local var_23_0 = AiZiLaGameModel.instance:getElevation()

	arg_23_0:_killTween()

	if var_23_0 > arg_23_0._showElevation then
		local var_23_1 = "rise"

		arg_23_0:_playAnimtor(arg_23_0._animator, var_23_1)
		arg_23_0:_playAnimtor(arg_23_0._animatorTop, var_23_1)

		arg_23_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, arg_23_0._tweenFrameCallback, arg_23_0._tweenFinishCallback, arg_23_0, {
			startEle = arg_23_0._showElevation,
			endEle = var_23_0
		})

		TaskDispatcher.runDelay(arg_23_0._refreshActionPointUI, arg_23_0, 2.4)
		arg_23_0:_setLockOpTime(AiZiLaEnum.AnimatorTime.MapViewRise)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_elevationl_up)
	else
		arg_23_0:_setCurElevation(var_23_0)
		arg_23_0:_refreshActionPointUI()
	end
end

function var_0_0._killTween(arg_24_0)
	if arg_24_0._tweenId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenId)

		arg_24_0._tweenId = nil

		TaskDispatcher.cancelTask(arg_24_0._refreshActionPointUI, arg_24_0)
	end
end

function var_0_0._tweenFrameCallback(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1 * (arg_25_2.endEle - arg_25_2.startEle) + arg_25_2.startEle

	if arg_25_1 >= 0.99 then
		var_25_0 = arg_25_2.endEle
	end

	arg_25_0:_setCurElevation(math.floor(var_25_0))
end

function var_0_0._tweenFinishCallback(arg_26_0, arg_26_1, arg_26_2)
	return
end

function var_0_0._setCurElevation(arg_27_0, arg_27_1)
	arg_27_1 = math.max(arg_27_0._minEle, arg_27_1)
	arg_27_0._showElevation = arg_27_1
	arg_27_0._txtTargetDesc.text = string.format("<color=#ffa632>%sm</color>/%sm", arg_27_1, arg_27_0._targetEle)
	arg_27_0._txtHeight.text = GameUtil.getSubPlaceholderLuaLang(luaLang("aizilagameview_height"), {
		arg_27_1,
		arg_27_0._maxEle
	})
end

function var_0_0._playAnimtor(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		arg_28_1.enabled = true

		arg_28_1:Play(arg_28_2, 0, 0)
	end
end

function var_0_0._getCostActionPoint(arg_29_0)
	local var_29_0 = arg_29_0:_getMO()

	if not var_29_0 then
		return 0
	end

	return var_29_0:getCostActionPoint()
end

function var_0_0._isNotForwardGame(arg_30_0)
	local var_30_0 = arg_30_0:_getMO()

	if var_30_0 then
		return var_30_0.eventId ~= 0 and (var_30_0.optionResultId == 0 or var_30_0.option == 0)
	end

	return false
end

function var_0_0.getElevation(arg_31_0, arg_31_1)
	local var_31_0 = AiZiLaConfig.instance:getEpisodeShowTargetCo(arg_31_1)

	return var_31_0 and var_31_0.elevation or 0
end

function var_0_0._getMO(arg_32_0)
	return AiZiLaGameModel.instance:getEpisodeMO()
end

function var_0_0._setLockOpTime(arg_33_0, arg_33_1)
	arg_33_0._lockTime = Time.time + arg_33_1
end

function var_0_0.isLockOp(arg_34_0)
	if arg_34_0._lockTime and Time.time < arg_34_0._lockTime then
		return true
	end

	return false
end

return var_0_0
