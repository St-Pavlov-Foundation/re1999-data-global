module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameView", package.seeall)

slot0 = class("AiZiLaGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Top/#txt_Title")
	slot0._txtHeight = gohelper.findChildText(slot0.viewGO, "Top/#txt_Height")
	slot0._txtRemainingTimesNum = gohelper.findChildText(slot0.viewGO, "LeftTop/RemainingTimes/#txt_RemainingTimesNum")
	slot0._txtTargetDesc = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/TargetItem/#txt_TargetDesc")
	slot0._btnstate = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottm/#btn_state")
	slot0._btnpack = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottm/#btn_pack")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "LeftBottm/#btn_equip")
	slot0._txtInfo = gohelper.findChildText(slot0.viewGO, "RightTop/#txt_Info")
	slot0._txtdaydesc = gohelper.findChildText(slot0.viewGO, "RightTop/#txt_daydesc")
	slot0._btnforwardgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottm/#btn_forwardgame")
	slot0._goCostBG = gohelper.findChild(slot0.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG")
	slot0._txtforwardCost = gohelper.findChildText(slot0.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG/#txt_forwardCost")
	slot0._goEnable = gohelper.findChild(slot0.viewGO, "RightBottm/#btn_forwardgame/#go_Enable")
	slot0._goDisable = gohelper.findChild(slot0.viewGO, "RightBottm/#btn_forwardgame/#go_Disable")
	slot0._btnexitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottm/#btn_exitgame")
	slot0._btnContinue = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightBottm/#btn_Continue")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstate:AddClickListener(slot0._btnstateOnClick, slot0)
	slot0._btnpack:AddClickListener(slot0._btnpackOnClick, slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnforwardgame:AddClickListener(slot0._btnforwardgameOnClick, slot0)
	slot0._btnexitgame:AddClickListener(slot0._btnexitgameOnClick, slot0)
	slot0._btnContinue:AddClickListener(slot0._btnContinueOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstate:RemoveClickListener()
	slot0._btnpack:RemoveClickListener()
	slot0._btnequip:RemoveClickListener()
	slot0._btnforwardgame:RemoveClickListener()
	slot0._btnexitgame:RemoveClickListener()
	slot0._btnContinue:RemoveClickListener()
end

function slot0._btnContinueOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
end

function slot0._btnstateOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameStateView)
end

function slot0._btnpackOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGamePackView)
end

function slot0._btnequipOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function slot0._btnforwardgameOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	if not slot0:_getMO() then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	slot0._isNeedShowBtnForwrdGame = false

	if slot0:_isNotForwardGame() then
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		slot0:refreshUI()

		return
	end

	if slot1.actionPoint < slot0:_getCostActionPoint() then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	slot0:_setLockOpTime(0.2)
	AiZiLaGameController.instance:forwardGame()
end

function slot0._btnexitgameOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function slot0._editableInitView(slot0)
	slot0._goforwardgame = slot0._btnforwardgame.gameObject
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0._animatorTop = gohelper.findChildComponent(slot0.viewGO, "Top", AiZiLaEnum.ComponentType.Animator)
	slot0._govxcost = gohelper.findChild(slot0.viewGO, "LeftTop/RemainingTimes/vx_cost")
	slot0._goRightBottm = gohelper.findChild(slot0.viewGO, "RightBottm")
	slot0._goRightTop = gohelper.findChild(slot0.viewGO, "RightTop")
	slot0._goTop = gohelper.findChild(slot0.viewGO, "Top")
	slot0._txtExit = gohelper.findChildText(slot0.viewGO, "RightBottm/#btn_exitgame/txt_Exit")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btnexitgameOnClick, slot0)
	end

	slot0:_setLockOpTime(not GuideController.instance:isForbidGuides() and GuideModel.instance:isGuideRunning(AiZiLaEnum.Guide.FirstEnter) and 4 or 0.6)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)
	slot0:addEventCb(AiZiLaGameController.instance, AiZiLaEvent.RefreshGameEpsiode, slot0._onRefreshGameEpsiode, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, slot0._onDestroyViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)

	slot0._isNeedShowBtnForwrdGame = true

	slot0:_refreshParam()
	slot0:refreshUI()
	slot0:_setCurElevation(AiZiLaGameModel.instance:getElevation())
	slot0:_refreshActionPointUI()
	slot0:_playAnimtor(slot0._animatorTop, UIAnimationName.Open)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_killTween()
	slot0._simageFullBG:UnLoadImage()
end

function slot0._onRefreshGameEpsiode(slot0)
	slot0._isHasNeedRefresh = true

	slot0:refreshUI()
	slot0:_refreshActionPointUI()
end

function slot0._onOpenView(slot0, slot1)
	slot0:_refreshGoShow()
end

function slot0._onDestroyViewFinish(slot0, slot1)
	slot0:_refreshGoShow()

	if slot0._isHasNeedRefresh and slot1 == ViewName.AiZiLaGameEventResult then
		slot0._isHasNeedRefresh = false

		slot0:refreshUI()
		slot0:_refreshAnimUI()

		if slot0:_getMO():isPass() then
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.CloseGameEventResult)
		end
	end
end

function slot0._refreshGoShow(slot0)
	if slot0._lastIsShow ~= (not (ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) or ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView)) and true or false) then
		slot0._lastIsShow = slot2

		gohelper.setActive(slot0._goTop, slot2)
		gohelper.setActive(slot0._goRightBottm, slot2)
		gohelper.setActive(slot0._goRightTop, slot2)
	end
end

function slot0._refreshParam(slot0)
	slot2 = slot0:_getMO() and slot1:getTargetIds() or {}
	slot0._minEle = slot0:getElevation(slot2[1]) or 0
	slot0._targetEle = slot0:getElevation(slot2[2]) or 0
	slot0._maxEle = slot0:getElevation(slot2[#slot2]) or 0
	slot0._showElevation = slot0._showElevation or slot0._minEle
end

function slot0.needPlayRiseAnim(slot0)
	return slot0._showElevation and slot0._showElevation < AiZiLaGameModel.instance:getElevation()
end

function slot0.refreshUI(slot0)
	if not slot0:_getMO() then
		return
	end

	if slot1:getConfig() and slot0._lastEpisodeId ~= slot2.episodeId and not string.nilorempty(slot2.bgPath) then
		slot0._lastEpisodeId = slot2.episodeId

		slot0._simageFullBG:LoadImage(string.format("%s.png", slot2.bgPath))
	end

	slot0._txtInfo.text = slot2 and slot2.name
	slot0._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", slot1.day)
	slot3 = true

	if slot0:_isNotForwardGame() and not slot0._isNeedShowBtnForwrdGame then
		slot3 = false
	end

	gohelper.setActive(slot0._btnContinue, not slot3)
	gohelper.setActive(slot0._btnforwardgame, slot3)
	gohelper.setActive(slot0._btnContinue, not slot3)

	if slot3 then
		gohelper.setActive(slot0._txtforwardCost, slot0:_getCostActionPoint() > 0)

		if slot1.actionPoint and slot1.actionPoint < slot4 then
			slot6 = string.format("<color=#dc5f56>%s</color>", formatLuaLang("v1a5_aizila_action_point_cost", -slot4))
		end

		slot0._txtforwardCost.text = slot6

		gohelper.setActive(slot0._goEnable, not slot5)
		gohelper.setActive(slot0._goDisable, slot5)
		ZProj.UGUIHelper.SetGrayscale(slot0._goforwardgame, slot5)
	end

	if slot0._lastIsSafe ~= slot1:isCanSafe() then
		slot0._txtExit.text = luaLang(slot4 and "v1a5_aizila_safe_exit_game" or "v1a5_aizila_exit_game")
	end
end

function slot0._refreshActionPointUI(slot0)
	slot2 = math.max(0, slot0:_getMO() and slot1.actionPoint or 0)

	if slot0._lastActionPoint and slot2 < slot0._lastActionPoint then
		gohelper.setActive(slot0._govxcost, false)
		gohelper.setActive(slot0._govxcost, true)
	end

	slot0._lastActionPoint = slot2
	slot0._txtRemainingTimesNum.text = formatLuaLang("v1a5_aizila_action_point_tag", slot2)
end

function slot0._refreshAnimUI(slot0)
	slot0:_killTween()

	if slot0._showElevation < AiZiLaGameModel.instance:getElevation() then
		slot2 = "rise"

		slot0:_playAnimtor(slot0._animator, slot2)
		slot0:_playAnimtor(slot0._animatorTop, slot2)

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, slot0._tweenFrameCallback, slot0._tweenFinishCallback, slot0, {
			startEle = slot0._showElevation,
			endEle = slot1
		})

		TaskDispatcher.runDelay(slot0._refreshActionPointUI, slot0, 2.4)
		slot0:_setLockOpTime(AiZiLaEnum.AnimatorTime.MapViewRise)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_elevationl_up)
	else
		slot0:_setCurElevation(slot1)
		slot0:_refreshActionPointUI()
	end
end

function slot0._killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil

		TaskDispatcher.cancelTask(slot0._refreshActionPointUI, slot0)
	end
end

function slot0._tweenFrameCallback(slot0, slot1, slot2)
	slot3 = slot1 * (slot2.endEle - slot2.startEle) + slot2.startEle

	if slot1 >= 0.99 then
		slot3 = slot2.endEle
	end

	slot0:_setCurElevation(math.floor(slot3))
end

function slot0._tweenFinishCallback(slot0, slot1, slot2)
end

function slot0._setCurElevation(slot0, slot1)
	slot1 = math.max(slot0._minEle, slot1)
	slot0._showElevation = slot1
	slot0._txtTargetDesc.text = string.format("<color=#ffa632>%sm</color>/%sm", slot1, slot0._targetEle)
	slot0._txtHeight.text = GameUtil.getSubPlaceholderLuaLang(luaLang("aizilagameview_height"), {
		slot1,
		slot0._maxEle
	})
end

function slot0._playAnimtor(slot0, slot1, slot2)
	if slot1 then
		slot1.enabled = true

		slot1:Play(slot2, 0, 0)
	end
end

function slot0._getCostActionPoint(slot0)
	if not slot0:_getMO() then
		return 0
	end

	return slot1:getCostActionPoint()
end

function slot0._isNotForwardGame(slot0)
	if slot0:_getMO() then
		return slot1.eventId ~= 0 and (slot1.optionResultId == 0 or slot1.option == 0)
	end

	return false
end

function slot0.getElevation(slot0, slot1)
	return AiZiLaConfig.instance:getEpisodeShowTargetCo(slot1) and slot2.elevation or 0
end

function slot0._getMO(slot0)
	return AiZiLaGameModel.instance:getEpisodeMO()
end

function slot0._setLockOpTime(slot0, slot1)
	slot0._lockTime = Time.time + slot1
end

function slot0.isLockOp(slot0)
	if slot0._lockTime and Time.time < slot0._lockTime then
		return true
	end

	return false
end

return slot0
