module("modules.logic.room.view.RoomViewDebugBuilding", package.seeall)

slot0 = class("RoomViewDebugBuilding", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._godebugbuilding = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugbuilding")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugbuilding/btn_close")
	slot0._scrolldebugbuilding = gohelper.findChildScrollRect(slot0.viewGO, "go_normalroot/go_debugbuilding/scroll_debugbuilding")

	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)

	slot0._isShowDebugBuilding = false

	gohelper.setActive(slot0._godebugbuilding, false)

	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0._btncloseOnClick(slot0)
	RoomDebugController.instance:setDebugBuildingListShow(false)
end

function slot0._refreshUI(slot0)
end

function slot0._debugBuildingListViewShowChanged(slot0, slot1)
	slot2 = slot0._isShowDebugBuilding ~= slot1
	slot0._isShowDebugBuilding = slot1

	RoomDebugBuildingListModel.instance:clearSelect()
	gohelper.setActive(slot0._godebugbuilding, slot1)

	if slot1 then
		RoomDebugBuildingListModel.instance:setDebugBuildingList()

		slot0._scrolldebugbuilding.horizontalNormalizedPosition = 0
	end
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, slot0._debugBuildingListViewShowChanged, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._scrolldebugbuilding:RemoveOnValueChanged()
end

return slot0
