module("modules.logic.explore.view.ExploreView", package.seeall)

slot0 = class("ExploreView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_btns/#btn_back")
	slot0._btnhelp = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_btns/#btn_help")
	slot0._btnfile = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_btns/#btn_file")
	slot0._btnbag = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_bag")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "topright/#btn_reward")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "topright/#btn_reset")
	slot0._goshou = gohelper.findChild(slot0.viewGO, "shou")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "topright")
	slot0._gooptip = gohelper.findChild(slot0.viewGO, "#go_optip")
	slot0._txtoptip = gohelper.findChildTextMesh(slot0.viewGO, "#go_optip/tip")
	slot0._keyTipsBag = gohelper.findChild(slot0._btnbag.gameObject, "#go_pcbtn2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	NavigateMgr.instance:addEscape(ViewName.ExploreView, slot0._btnbackOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnhelp:AddClickListener(slot0._btnhelpOnClick, slot0)
	slot0._btnfile:AddClickListener(slot0._btnfileOnClick, slot0)
	slot0._btnbag:AddClickListener(slot0._btnbagOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnEnterFbFight, slot0.closeThis, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.CoinCountUpdate, slot0.updateCoinCount, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, slot0.onMapStatusChange, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.HeroCarryChange, slot0.onHeroCarryChange, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.ShowBagBtn, slot0.updateBagBtn, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.ShowResetChange, slot0.updateResetBtn, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, slot0._btnfileOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, slot0._btnhelpOnClick, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._checkDialogIsOpen, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._checkDialogIsOpen, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, slot0._gudieEnd, slot0)
end

function slot0.removeEvents(slot0)
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	slot0._btnback:RemoveClickListener()
	slot0._btnhelp:RemoveClickListener()
	slot0._btnfile:RemoveClickListener()
	slot0._btnbag:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnEnterFbFight, slot0.closeThis, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.CoinCountUpdate, slot0.updateCoinCount, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, slot0.onMapStatusChange, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.HeroCarryChange, slot0.onHeroCarryChange, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.ShowBagBtn, slot0.updateBagBtn, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.ShowResetChange, slot0.updateResetBtn, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, slot0._btnfileOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, slot0._btnhelpOnClick, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._checkDialogIsOpen, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._checkDialogIsOpen, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, slot0._gudieEnd, slot0)
end

function slot0._btnbackOnClick(slot0)
	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.UseItem then
		slot1:setMapStatus(ExploreEnum.MapStatus.Normal)

		return
	end

	ExploreController.instance:exit()
end

function slot0._btnhelpOnClick(slot0)
	if slot0._btnhelp.gameObject.activeInHierarchy then
		HelpController.instance:showHelp(HelpEnum.HelpId.ExploreMap)
	end
end

function slot0._gudieEnd(slot0)
	slot0:_updateHelpBtn()
end

function slot0._updateHelpBtn(slot0)
	gohelper.setActive(slot0._btnhelp, HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
end

function slot0._checkDialogIsOpen(slot0)
	if ViewMgr.instance:isOpen(ViewName.ExploreInteractView) or ViewMgr.instance:isOpen(ViewName.ExploreBonusSceneView) or ViewMgr.instance:isOpen(ViewName.ExploreGuideDialogueView) then
		ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		gohelper.setActive(slot0.viewGO, false)
	else
		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0._btnfileOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()).chapterId
	})
end

function slot0._btnbagOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ExploreBackpackView)
end

function slot0._btnrewardOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ExploreRewardView, DungeonConfig.instance:getChapterCO(ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()).chapterId))
end

function slot0._btnresetOnClick(slot0)
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	ExploreModel.instance.isShowingResetBoxMessage = true

	GameFacade.showMessageBox(ExploreConstValue.MessageBoxId.MapReset, MsgBoxEnum.BoxType.Yes_No, slot0._onResetReq, slot0._onCancel, nil, slot0, slot0)
end

function slot0._onResetReq(slot0)
	ExploreRpc.instance:sendResetExploreRequest()

	ExploreModel.instance.isShowingResetBoxMessage = false
end

function slot0._onCancel(slot0)
	ExploreModel.instance.isShowingResetBoxMessage = false
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)

	slot0._click:AddClickDownListener(slot0._onClickDown, slot0)
	slot0._click:AddClickUpListener(slot0._onClickUp, slot0)

	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._gofullscreen)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnMultiDragCb(slot0.onScaleHandler, slot0)

	slot4 = slot0

	slot0._touchEventMgr:SetScrollWheelCb(slot0.onMouseScrollWheelChange, slot4)

	slot0._progressItems = {}

	for slot4 = 1, 3 do
		slot0._progressItems[slot4] = slot0:getUserDataTb_()
		slot0._progressItems[slot4].go = gohelper.findChild(slot0.viewGO, "topright/progresslist/#go_progress" .. slot4)
		slot0._progressItems[slot4].dark = gohelper.findChild(slot0._progressItems[slot4].go, "dark")
		slot0._progressItems[slot4].light = gohelper.findChild(slot0._progressItems[slot4].go, "light")
		slot0._progressItems[slot4].progress = gohelper.findChildTextMesh(slot0._progressItems[slot4].go, "txt_progress")
	end

	PCInputController.instance:showkeyTips(slot0._keyTipsBag, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.bag)
end

function slot0.updateBagBtn(slot0)
	gohelper.setActive(slot0._btnbag, ExploreSimpleModel.instance.isShowBag)
	gohelper.setActive(slot0._goshou, ExploreSimpleModel.instance.isShowBag)
end

function slot0.updateResetBtn(slot0)
	gohelper.setActive(slot0._btnreset, ExploreMapModel.instance:getIsShowResetBtn())
end

function slot0.onMouseScrollWheelChange(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, -slot1)
end

function slot0.onScaleHandler(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	slot0._scale = true

	if BootNativeUtil.isMobilePlayer() then
		slot0._clickDown = false
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, slot1 and -0.02 or 0.02)
end

function slot0._onClickDown(slot0)
	slot0._clickDown = true
end

function slot0._onClickUp(slot0)
	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if slot0._clickDown then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, GamepadController.instance:getMousePosition())
	end
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickDownListener()
	slot0._click:RemoveClickUpListener()
end

function slot0.checkMove(slot0)
	if GuideController.instance:isGuiding() then
		return
	end

	slot1 = ExploreEnum.RoleMoveDir.None

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		slot1 = ExploreEnum.RoleMoveDir.Up
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		slot1 = ExploreEnum.RoleMoveDir.Left
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
		slot1 = ExploreEnum.RoleMoveDir.Down
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		slot1 = ExploreEnum.RoleMoveDir.Right
	end

	if slot1 ~= ExploreEnum.RoleMoveDir.None and slot0._isTop == false then
		slot1 = ExploreEnum.RoleMoveDir.None
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateMoveDir, slot1)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gooptip, false)

	slot0._isTop = true

	if BootNativeUtil.isWindows() or SDKMgr.instance:isEmulator() then
		TaskDispatcher.runRepeat(slot0.checkMove, slot0, 0)
	end

	slot0:updateResetBtn()
	slot0:updateBagBtn()
	slot0:updateCoinCount()
	slot0:_updateHelpBtn()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.checkMove, slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBackpackView)

	if slot0._touchEventMgr then
		slot0._touchEventMgr:ClearAllCallback()

		slot0._touchEventMgr = nil
	end
end

function slot0._showBotBtn(slot0, slot1)
	gohelper.setActive(slot0._btnbag, slot1)
end

function slot0.updateCoinCount(slot0)
	slot2, slot3, slot4, slot5, slot6, slot7 = ExploreSimpleModel.instance:getCoinCountByMapId(ExploreModel.instance:getMapId())

	gohelper.setActive(slot0._progressItems[1].dark, slot4 ~= slot7)
	gohelper.setActive(slot0._progressItems[1].light, slot4 == slot7)

	slot0._progressItems[1].progress.text = string.format("%d/%d", slot4, slot7)

	gohelper.setActive(slot0._progressItems[2].dark, slot3 ~= slot6)
	gohelper.setActive(slot0._progressItems[2].light, slot3 == slot6)

	slot0._progressItems[2].progress.text = string.format("%d/%d", slot3, slot6)

	gohelper.setActive(slot0._progressItems[3].dark, slot2 ~= slot5)
	gohelper.setActive(slot0._progressItems[3].light, slot2 == slot5)

	slot0._progressItems[3].progress.text = string.format("%d/%d", slot2, slot5)
end

function slot0.onHeroCarryChange(slot0)
	slot0:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function slot0.onMapStatusChange(slot0, slot1)
	if slot1 == ExploreEnum.MapStatus.MoveUnit or slot1 == ExploreEnum.MapStatus.RotateUnit then
		slot0._txtoptip.text = luaLang("exploreview_optip_interact")

		gohelper.setActive(slot0._gooptip, true)
	elseif ExploreController.instance:getMap():getHero():getHeroStatus() == ExploreAnimEnum.RoleAnimStatus.Carry then
		slot0._txtoptip.text = luaLang("exploreview_optip_carry")

		gohelper.setActive(slot0._gooptip, true)
	else
		gohelper.setActive(slot0._gooptip, false)
	end

	gohelper.setActive(slot0._btnback, slot1 ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(slot0._btnhelp, slot1 ~= ExploreEnum.MapStatus.UseItem and HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
	gohelper.setActive(slot0._btnfile, slot1 ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(slot0._gotopright, slot1 ~= ExploreEnum.MapStatus.UseItem)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.ExploreBackpackView then
		slot0:_showBotBtn(false)
	end

	slot0:_checkIsTop()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.ExploreBackpackView then
		slot0:_showBotBtn(true)
	end

	slot0:_checkIsTop()
end

slot0.ignoreView = {
	[ViewName.ToastView] = true,
	[ViewName.ExploreBackpackView] = true
}

function slot0._checkIsTop(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	while uv0.ignoreView[slot1[#slot1]] do
		slot3 = slot1[slot2 - 1]
	end

	slot0._isTop = slot3 == ViewName.ExploreView
end

return slot0
