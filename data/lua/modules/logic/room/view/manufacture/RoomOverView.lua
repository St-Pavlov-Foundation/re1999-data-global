module("modules.logic.room.view.manufacture.RoomOverView", package.seeall)

slot0 = class("RoomOverView", BaseView)
slot1 = 0.05

function slot0.onInitView(slot0)
	slot0._btnmanufacture = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "topTab/#btn_manufacture")
	slot0._gomannuselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_manufacture/select")
	slot0._gomannuunselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_manufacture/unselect")
	slot0._gomannuReddot = gohelper.findChild(slot0.viewGO, "topTab/#btn_manufacture/#go_reddot")
	slot0._btntransport = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "topTab/#btn_transport")
	slot0._gotransportselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_transport/select")
	slot0._gotransportunselect = gohelper.findChild(slot0.viewGO, "topTab/#btn_transport/unselect")
	slot0._gotransportReddot = gohelper.findChild(slot0.viewGO, "topTab/#btn_transport/#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmanufacture:AddClickListener(slot0._btnmanufactureOnClick, slot0)
	slot0._btntransport:AddClickListener(slot0._btntransportOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmanufacture:RemoveClickListener()
	slot0._btntransport:RemoveClickListener()
end

function slot0._btnmanufactureOnClick(slot0)
	slot0:_btnTabClick(RoomOverViewContainer.SubViewTabId.Manufacture)
end

function slot0._btntransportOnClick(slot0)
	slot0:_btnTabClick(RoomOverViewContainer.SubViewTabId.Transport)
end

function slot0._btnTabClick(slot0, slot1)
	if not slot0.viewContainer:checkTabId(slot1) then
		logError(string.format("RoomOverView._btnTabOnClick error, no subview, tabId:%s", slot1))

		return
	end

	if slot0._curSelectTab == slot1 then
		return
	end

	slot0.viewContainer:switchTab(slot1)

	slot0._curSelectTab = slot1

	slot0:refreshTab()
end

function slot0._onViewChange(slot0, slot1)
	if slot1 ~= ViewName.RoomManufactureAddPopView and slot1 ~= ViewName.RoomCritterListView and slot1 ~= ViewName.RoomManufactureBuildingDetailView then
		return
	end

	if slot0._willClose then
		return
	end

	TaskDispatcher.cancelTask(slot0._delayCheckLeft, slot0)
	TaskDispatcher.runDelay(slot0._delayCheckLeft, slot0, uv0)
end

function slot0._delayCheckLeft(slot0)
	slot1 = false

	if ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView) or (ViewMgr.instance:isOpen(ViewName.RoomCritterListView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingDetailView)) then
		slot1 = true
	end

	if slot1 ~= slot0._isLeft then
		slot0:playAnim(slot1 and "left" or "right")

		slot0._isLeft = slot1
	end
end

function slot0._editableInitView(slot0)
	slot0._tabSelectedGoDict = {}
	slot1 = slot0:getUserDataTb_()
	slot1.goSelected = slot0._gomannuselect
	slot1.goUnSelected = slot0._gomannuunselect
	slot0._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Manufacture] = slot1
	slot2 = slot0:getUserDataTb_()
	slot2.goSelected = slot0._gotransportselect
	slot2.goUnSelected = slot0._gotransportunselect
	slot0._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Transport] = slot2
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._isLeft = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._willClose = false
	slot0._curSelectTab = slot0.viewContainer:getDefaultSelectedTab()

	slot0:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
	RedDotController.instance:addRedDot(slot0._gomannuReddot, RedDotEnum.DotNode.ManufactureOverview)
end

function slot0.refreshTab(slot0)
	for slot4, slot5 in pairs(slot0._tabSelectedGoDict) do
		slot6 = slot4 == slot0._curSelectTab

		gohelper.setActive(slot5.goSelected, slot6)
		gohelper.setActive(slot5.goUnSelected, not slot6)
	end
end

function slot0.playAnim(slot0, slot1)
	slot0._animator.enabled = true

	slot0._animator:Play(slot1, 0, 0)
end

function slot0.onClose(slot0)
	slot0._willClose = true

	TaskDispatcher.cancelTask(slot0._delayCheckLeft, slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function slot0.onDestroyView(slot0)
	slot0._isLeft = false
end

return slot0
