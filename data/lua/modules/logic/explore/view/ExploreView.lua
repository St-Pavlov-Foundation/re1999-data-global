module("modules.logic.explore.view.ExploreView", package.seeall)

local var_0_0 = class("ExploreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_btns/#btn_back")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_btns/#btn_help")
	arg_1_0._btnfile = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_btns/#btn_file")
	arg_1_0._btnbag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bag")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "topright/#btn_reward")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "topright/#btn_reset")
	arg_1_0._goshou = gohelper.findChild(arg_1_0.viewGO, "shou")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "topright")
	arg_1_0._gooptip = gohelper.findChild(arg_1_0.viewGO, "#go_optip")
	arg_1_0._txtoptip = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_optip/tip")
	arg_1_0._keyTipsBag = gohelper.findChild(arg_1_0._btnbag.gameObject, "#go_pcbtn2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addEscape(ViewName.ExploreView, arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	arg_2_0._btnfile:AddClickListener(arg_2_0._btnfileOnClick, arg_2_0)
	arg_2_0._btnbag:AddClickListener(arg_2_0._btnbagOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnEnterFbFight, arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.CoinCountUpdate, arg_2_0.updateCoinCount, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, arg_2_0.onMapStatusChange, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.HeroCarryChange, arg_2_0.onHeroCarryChange, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.ShowBagBtn, arg_2_0.updateBagBtn, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.ShowResetChange, arg_2_0.updateResetBtn, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, arg_2_0._btnfileOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, arg_2_0._btnhelpOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._checkDialogIsOpen, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._checkDialogIsOpen, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_2_0._gudieEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnhelp:RemoveClickListener()
	arg_3_0._btnfile:RemoveClickListener()
	arg_3_0._btnbag:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnEnterFbFight, arg_3_0.closeThis, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.CoinCountUpdate, arg_3_0.updateCoinCount, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, arg_3_0.onMapStatusChange, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.HeroCarryChange, arg_3_0.onHeroCarryChange, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.ShowBagBtn, arg_3_0.updateBagBtn, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.ShowResetChange, arg_3_0.updateResetBtn, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, arg_3_0._btnfileOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, arg_3_0._btnhelpOnClick, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0._checkDialogIsOpen, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._checkDialogIsOpen, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_3_0._gudieEnd, arg_3_0)
end

function var_0_0._btnbackOnClick(arg_4_0)
	local var_4_0 = ExploreController.instance:getMap()

	if var_4_0:getNowStatus() == ExploreEnum.MapStatus.UseItem then
		var_4_0:setMapStatus(ExploreEnum.MapStatus.Normal)

		return
	end

	ExploreController.instance:exit()
end

function var_0_0._btnhelpOnClick(arg_5_0)
	if arg_5_0._btnhelp.gameObject.activeInHierarchy then
		HelpController.instance:showHelp(HelpEnum.HelpId.ExploreMap)
	end
end

function var_0_0._gudieEnd(arg_6_0)
	arg_6_0:_updateHelpBtn()
end

function var_0_0._updateHelpBtn(arg_7_0)
	gohelper.setActive(arg_7_0._btnhelp, HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
end

function var_0_0._checkDialogIsOpen(arg_8_0)
	if ViewMgr.instance:isOpen(ViewName.ExploreInteractView) or ViewMgr.instance:isOpen(ViewName.ExploreBonusSceneView) or ViewMgr.instance:isOpen(ViewName.ExploreGuideDialogueView) then
		ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		gohelper.setActive(arg_8_0.viewGO, false)
	else
		gohelper.setActive(arg_8_0.viewGO, true)
	end
end

function var_0_0._btnfileOnClick(arg_9_0)
	local var_9_0 = ExploreModel.instance:getMapId()
	local var_9_1 = ExploreConfig.instance:getMapIdConfig(var_9_0)

	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = var_9_1.chapterId
	})
end

function var_0_0._btnbagOnClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.ExploreBackpackView)
end

function var_0_0._btnrewardOnClick(arg_11_0)
	local var_11_0 = ExploreModel.instance:getMapId()
	local var_11_1 = ExploreConfig.instance:getMapIdConfig(var_11_0)
	local var_11_2 = DungeonConfig.instance:getChapterCO(var_11_1.chapterId)

	ViewMgr.instance:openView(ViewName.ExploreRewardView, var_11_2)
end

function var_0_0._btnresetOnClick(arg_12_0)
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	ExploreModel.instance.isShowingResetBoxMessage = true

	GameFacade.showMessageBox(ExploreConstValue.MessageBoxId.MapReset, MsgBoxEnum.BoxType.Yes_No, arg_12_0._onResetReq, arg_12_0._onCancel, nil, arg_12_0, arg_12_0)
end

function var_0_0._onResetReq(arg_13_0)
	ExploreRpc.instance:sendResetExploreRequest()

	ExploreModel.instance.isShowingResetBoxMessage = false
end

function var_0_0._onCancel(arg_14_0)
	ExploreModel.instance.isShowingResetBoxMessage = false
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._click = SLFramework.UGUI.UIClickListener.Get(arg_15_0._gofullscreen)

	arg_15_0._click:AddClickDownListener(arg_15_0._onClickDown, arg_15_0)
	arg_15_0._click:AddClickUpListener(arg_15_0._onClickUp, arg_15_0)

	arg_15_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_15_0._gofullscreen)

	arg_15_0._touchEventMgr:SetIgnoreUI(true)
	arg_15_0._touchEventMgr:SetOnMultiDragCb(arg_15_0.onScaleHandler, arg_15_0)
	arg_15_0._touchEventMgr:SetScrollWheelCb(arg_15_0.onMouseScrollWheelChange, arg_15_0)

	arg_15_0._progressItems = {}

	for iter_15_0 = 1, 3 do
		arg_15_0._progressItems[iter_15_0] = arg_15_0:getUserDataTb_()
		arg_15_0._progressItems[iter_15_0].go = gohelper.findChild(arg_15_0.viewGO, "topright/progresslist/#go_progress" .. iter_15_0)
		arg_15_0._progressItems[iter_15_0].dark = gohelper.findChild(arg_15_0._progressItems[iter_15_0].go, "dark")
		arg_15_0._progressItems[iter_15_0].light = gohelper.findChild(arg_15_0._progressItems[iter_15_0].go, "light")
		arg_15_0._progressItems[iter_15_0].progress = gohelper.findChildTextMesh(arg_15_0._progressItems[iter_15_0].go, "txt_progress")
	end

	PCInputController.instance:showkeyTips(arg_15_0._keyTipsBag, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.bag)
end

function var_0_0.updateBagBtn(arg_16_0)
	gohelper.setActive(arg_16_0._btnbag, ExploreSimpleModel.instance.isShowBag)
	gohelper.setActive(arg_16_0._goshou, ExploreSimpleModel.instance.isShowBag)
end

function var_0_0.updateResetBtn(arg_17_0)
	gohelper.setActive(arg_17_0._btnreset, ExploreMapModel.instance:getIsShowResetBtn())
end

function var_0_0.onMouseScrollWheelChange(arg_18_0, arg_18_1)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	local var_18_0 = -arg_18_1

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, var_18_0)
end

function var_0_0.onScaleHandler(arg_19_0, arg_19_1)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	arg_19_0._scale = true

	if BootNativeUtil.isMobilePlayer() then
		arg_19_0._clickDown = false
	end

	local var_19_0 = arg_19_1 and -0.02 or 0.02

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, var_19_0)
end

function var_0_0._onClickDown(arg_20_0)
	arg_20_0._clickDown = true
end

function var_0_0._onClickUp(arg_21_0)
	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if arg_21_0._clickDown then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, GamepadController.instance:getMousePosition())
	end
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._click:RemoveClickDownListener()
	arg_22_0._click:RemoveClickUpListener()
end

function var_0_0.checkMove(arg_23_0)
	if GuideController.instance:isGuiding() then
		return
	end

	local var_23_0 = ExploreEnum.RoleMoveDir.None

	if SDKMgr.instance:isEmulator() then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
			var_23_0 = ExploreEnum.RoleMoveDir.Up
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
			var_23_0 = ExploreEnum.RoleMoveDir.Left
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
			var_23_0 = ExploreEnum.RoleMoveDir.Down
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
			var_23_0 = ExploreEnum.RoleMoveDir.Right
		end

		if var_23_0 ~= ExploreEnum.RoleMoveDir.None and arg_23_0._isTop == false then
			var_23_0 = ExploreEnum.RoleMoveDir.None
		end
	else
		local var_23_1 = PCInputController.instance
		local var_23_2, var_23_3, var_23_4, var_23_5 = var_23_1:getThirdMoveKey()

		if var_23_1:getKeyPress(var_23_2) then
			var_23_0 = ExploreEnum.RoleMoveDir.Up
		elseif var_23_1:getKeyPress(var_23_3) then
			var_23_0 = ExploreEnum.RoleMoveDir.Left
		elseif var_23_1:getKeyPress(var_23_4) then
			var_23_0 = ExploreEnum.RoleMoveDir.Down
		elseif var_23_1:getKeyPress(var_23_5) then
			var_23_0 = ExploreEnum.RoleMoveDir.Right
		end

		if var_23_0 ~= ExploreEnum.RoleMoveDir.None and arg_23_0._isTop == false then
			var_23_0 = ExploreEnum.RoleMoveDir.None
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateMoveDir, var_23_0)
end

function var_0_0.onOpen(arg_24_0)
	gohelper.setActive(arg_24_0._gooptip, false)

	arg_24_0._isTop = true

	if BootNativeUtil.isWindows() or SDKMgr.instance:isEmulator() then
		TaskDispatcher.runRepeat(arg_24_0.checkMove, arg_24_0, 0)
	end

	arg_24_0:updateResetBtn()
	arg_24_0:updateBagBtn()
	arg_24_0:updateCoinCount()
	arg_24_0:_updateHelpBtn()
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.checkMove, arg_25_0)
	ViewMgr.instance:closeView(ViewName.ExploreBackpackView)

	if arg_25_0._touchEventMgr then
		arg_25_0._touchEventMgr:ClearAllCallback()

		arg_25_0._touchEventMgr = nil
	end
end

function var_0_0._showBotBtn(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._btnbag, arg_26_1)
end

function var_0_0.updateCoinCount(arg_27_0)
	local var_27_0 = ExploreModel.instance:getMapId()
	local var_27_1, var_27_2, var_27_3, var_27_4, var_27_5, var_27_6 = ExploreSimpleModel.instance:getCoinCountByMapId(var_27_0)

	gohelper.setActive(arg_27_0._progressItems[1].dark, var_27_3 ~= var_27_6)
	gohelper.setActive(arg_27_0._progressItems[1].light, var_27_3 == var_27_6)

	arg_27_0._progressItems[1].progress.text = string.format("%d/%d", var_27_3, var_27_6)

	gohelper.setActive(arg_27_0._progressItems[2].dark, var_27_2 ~= var_27_5)
	gohelper.setActive(arg_27_0._progressItems[2].light, var_27_2 == var_27_5)

	arg_27_0._progressItems[2].progress.text = string.format("%d/%d", var_27_2, var_27_5)

	gohelper.setActive(arg_27_0._progressItems[3].dark, var_27_1 ~= var_27_4)
	gohelper.setActive(arg_27_0._progressItems[3].light, var_27_1 == var_27_4)

	arg_27_0._progressItems[3].progress.text = string.format("%d/%d", var_27_1, var_27_4)
end

function var_0_0.onHeroCarryChange(arg_28_0)
	arg_28_0:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function var_0_0.onMapStatusChange(arg_29_0, arg_29_1)
	if arg_29_1 == ExploreEnum.MapStatus.MoveUnit or arg_29_1 == ExploreEnum.MapStatus.RotateUnit then
		arg_29_0._txtoptip.text = luaLang("exploreview_optip_interact")

		gohelper.setActive(arg_29_0._gooptip, true)
	elseif ExploreController.instance:getMap():getHero():getHeroStatus() == ExploreAnimEnum.RoleAnimStatus.Carry then
		arg_29_0._txtoptip.text = luaLang("exploreview_optip_carry")

		gohelper.setActive(arg_29_0._gooptip, true)
	else
		gohelper.setActive(arg_29_0._gooptip, false)
	end

	gohelper.setActive(arg_29_0._btnback, arg_29_1 ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(arg_29_0._btnhelp, arg_29_1 ~= ExploreEnum.MapStatus.UseItem and HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
	gohelper.setActive(arg_29_0._btnfile, arg_29_1 ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(arg_29_0._gotopright, arg_29_1 ~= ExploreEnum.MapStatus.UseItem)
end

function var_0_0._onOpenView(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.ExploreBackpackView then
		arg_30_0:_showBotBtn(false)
	end

	arg_30_0:_checkIsTop()
end

function var_0_0._onCloseView(arg_31_0, arg_31_1)
	if arg_31_1 == ViewName.ExploreBackpackView then
		arg_31_0:_showBotBtn(true)
	end

	arg_31_0:_checkIsTop()
end

var_0_0.ignoreView = {
	[ViewName.ToastView] = true,
	[ViewName.ExploreBackpackView] = true
}

function var_0_0._checkIsTop(arg_32_0)
	local var_32_0 = ViewMgr.instance:getOpenViewNameList()
	local var_32_1 = #var_32_0
	local var_32_2 = var_32_0[var_32_1]

	while var_0_0.ignoreView[var_32_2] do
		var_32_1 = var_32_1 - 1
		var_32_2 = var_32_0[var_32_1]
	end

	arg_32_0._isTop = var_32_2 == ViewName.ExploreView
end

return var_0_0
