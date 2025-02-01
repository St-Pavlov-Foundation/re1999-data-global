module("modules.logic.room.view.manufacture.RoomCritterBuildingView", package.seeall)

slot0 = class("RoomCritterBuildingView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._scrolltabbtn = gohelper.findChildScrollRect(slot0.viewGO, "tabLayout/#scroll_tabbtn")
	slot0._gotablayout = gohelper.findChild(slot0.viewGO, "tabLayout")
	slot0._gotabItem = gohelper.findChild(slot0.viewGO, "tabLayout/#scroll_tabbtn/Viewport/Content/#go_tabItem")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "righttop")
	slot0._btnrule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_BackBtns/#btn_rule")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrule:AddClickListener(slot0._btnruleOnClick, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingHideView, slot0.hideView, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingShowView, slot0.showView, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0.hideView, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0.showView, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, slot0.refreshCamera, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, slot0._onChangeRestBuilding, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrule:RemoveClickListener()
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingHideView, slot0.hideView, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingShowView, slot0.showView, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0.hideView, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0.showView, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, slot0.refreshCamera, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, slot0._onChangeRestBuilding, slot0)
end

function slot0._btnruleOnClick(slot0)
	if slot0._helpCallback then
		slot0._helpCallback()
	end
end

function slot0._btnTabOnClick(slot0, slot1)
	if not slot0.viewContainer:checkTabId(slot1) then
		logError(string.format("RoomCritterBuildingView._btnTabOnClick error, no subview, tabId:%s", slot1))

		return
	end

	if slot0._curSelectTab == slot1 then
		return
	end

	slot0.viewContainer:switchTab(slot1)

	slot0._curSelectTab = slot1

	slot0:refreshTab()
	slot0:refreshCamera()
	slot0:refreshSeatSlotIcon()

	if slot1 == RoomCritterBuildingViewContainer.SubViewTabId.Training and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function slot0.hideView(slot0, slot1, slot2)
	gohelper.setActive(slot0._goBackBtns, slot1)
	slot0._animator:Play(UIAnimationName.Close, 0, 0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, slot2)
end

function slot0.showView(slot0)
	slot0:refreshSeatSlotIcon()
	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(slot0._goBackBtns, true)
end

function slot0._onChangeRestBuilding(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		return
	end

	gohelper.setActive(slot0._goBackBtns, false)
	slot0._animator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.cancelTask(slot0._changeFinish, slot0)
	TaskDispatcher.runDelay(slot0._changeFinish, slot0, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function slot0._changeFinish(slot0)
	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(slot0._goBackBtns, true)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._scene = RoomCameraController.instance:getRoomScene()

	gohelper.setActive(slot0._gotabItem, false)

	slot0._tabDict = {}
end

function slot0.onUpdateParam(slot0)
	if not slot0.viewParam then
		return
	end

	slot0._curSelectTab = slot0.viewContainer:getDefaultSelectedTab()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._tradeLevelUp, slot0)
	slot0:onUpdateParam()
	slot0:setTabItem()
	slot0:refreshTab()
	slot0:refreshSeatSlotIcon()

	if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
		slot0:addEventCb(GuideController.instance, GuideEvent.FinishStep, slot0._onFinishSetep, slot0)
		slot0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, false)
	end

	slot1, slot2 = slot0:_isOpenIncubate()

	if not slot1 or slot2 then
		slot0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, false)
	end

	if slot2 then
		TaskDispatcher.runDelay(slot0._tradeLevelUp, slot0, 2)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, false)
end

function slot0.setTabItem(slot0)
	for slot4, slot5 in ipairs(RoomCritterBuildingViewContainer.TabSettingList) do
		if not slot0._tabDict[slot4] and not gohelper.isNil(gohelper.cloneInPlace(slot0._gotabItem, slot4)) then
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot7
			slot6.goselect = gohelper.findChild(slot7, "select")
			slot6.gonormal = gohelper.findChild(slot7, "normal")
			slot6.selecticon = gohelper.findChildImage(slot7, "select/#image_icon")
			slot6.normalicon = gohelper.findChildImage(slot7, "normal/#image_icon")
			slot6.btn = gohelper.findChildButtonWithAudio(slot7, "#btn_click")
			slot6.goreddot = gohelper.findChild(slot7, "#go_reddot")

			slot6.btn:AddClickListener(slot0._btnTabOnClick, slot0, slot4)

			if slot5.openBtnCallBack then
				gohelper.setActive(slot7, slot5.openBtnCallBack())
			else
				gohelper.setActive(slot7, true)
			end

			UISpriteSetMgr.instance:setCritterSprite(slot6.selecticon, slot5.icon)
			UISpriteSetMgr.instance:setCritterSprite(slot6.normalicon, slot5.icon)

			slot0._tabDict[slot4] = slot6
		end
	end

	if slot0._tabDict[RoomCritterBuildingViewContainer.SubViewTabId.Training] then
		RedDotController.instance:addRedDot(slot1.goreddot, RedDotEnum.DotNode.RoomCritterTrainTab)
	end
end

function slot0.refreshTab(slot0)
	for slot4, slot5 in pairs(slot0._tabDict) do
		slot6 = slot4 == slot0._curSelectTab

		gohelper.setActive(slot5.goselect, slot6)
		gohelper.setActive(slot5.gonormal, not slot6)
	end

	slot0._helpCallback = RoomCritterBuildingViewContainer.TabSettingList[slot0._curSelectTab].helpBtnCallBack

	gohelper.setActive(slot0._btnrule.gameObject, slot0._helpCallback ~= nil)
end

function slot0._setOpenByTabId(slot0, slot1, slot2, slot3)
	if slot0._tabDict[slot1] then
		gohelper.setActive(slot4.go, slot2)

		if slot2 and slot3 then
			if not slot4.animator then
				slot4.animator = slot4.go:GetComponent(RoomEnum.ComponentType.Animator)
			end

			if slot4.animator then
				slot4.animator:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
			end
		end
	end

	return true
end

function slot0._tradeLevelUp(slot0)
	slot1, slot2 = slot0:_isOpenIncubate()

	if slot1 and slot2 then
		slot2 = true

		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate, 1)
	end

	slot0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, slot1, slot2)
end

function slot0._isOpenIncubate(slot0)
	slot2 = false

	if ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate) <= ManufactureModel.instance:getTradeLevel() and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate) ~= 1 then
		slot2 = true
	end

	return slot1, slot2
end

function slot0._onFinishSetep(slot0, slot1, slot2)
	if RoomTradeEnum.GuideUnlock.Summon == slot1 and slot2 == 4 then
		slot0:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, true, true)
	end
end

function slot0.refreshCamera(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if not slot2 then
		return
	end

	slot4 = ManufactureConfig.instance:getBuildingCameraIdByIndex(slot2.buildingId, slot0._curSelectTab)

	if RoomCameraController.instance:getRoomCamera() and slot4 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot1, slot4, slot0._cameraTweenFinish, slot0)
	end
end

function slot0._cameraTweenFinish(slot0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, slot0._curSelectTab)
end

function slot0.refreshSeatSlotIcon(slot0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, slot0._curSelectTab == RoomCritterBuildingViewContainer.SubViewTabId.Rest)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0.viewContainer:getContainerViewBuilding(true)

	return slot1, slot2
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._changeFinish, slot0)
	TaskDispatcher.cancelTask(slot0._tradeLevelUp, slot0)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, false)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._tabDict) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
