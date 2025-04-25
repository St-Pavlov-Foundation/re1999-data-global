module("modules.logic.room.view.manufacture.RoomManufactureOverView", package.seeall)

slot0 = class("RoomManufactureOverView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnoneKeyCritter = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottomBtns/#btn_oneKeyCritter")
	slot0._btnoneKeyManu = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottomBtns/#btn_oneKeyManu")
	slot0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_popBlock")
	slot0._goscrollbuilding = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building")
	slot0._scrollbuilding = gohelper.findChildScrollRect(slot0.viewGO, "centerArea/#go_building/#scroll_building")
	slot0._transscrollbuilding = slot0._goscrollbuilding.transform
	slot0._gobuildingContent = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	slot0._gobuildingItem = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	slot0._goslotItem = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem/manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoneKeyCritter:AddClickListener(slot0._btnoneKeyCritterOnClick, slot0)
	slot0._btnoneKeyManu:AddClickListener(slot0._btnoneKeyManuOnClick, slot0)
	slot0._btnpopBlock:AddClickListener(slot0._btnpopBlockOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, slot0._onChangeSelectedSlotItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, slot0._focusBuildingItemAddPop, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.GuideFocusCritter, slot0._onGuideFocusCritter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoneKeyCritter:RemoveClickListener()
	slot0._btnoneKeyManu:RemoveClickListener()
	slot0._btnpopBlock:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, slot0._onChangeSelectedSlotItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, slot0._focusBuildingItemAddPop, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.GuideFocusCritter, slot0._onGuideFocusCritter, slot0)
end

function slot0._btnoneKeyCritterOnClick(slot0)
	ManufactureController.instance:oneKeyCritter()
end

function slot0._btnoneKeyManuOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomOneKeyView)
end

function slot0._btnpopBlockOnClick(slot0)
	slot0:closePopView()
end

function slot0._onChangeSelectedSlotItem(slot0)
	slot1, slot2 = ManufactureModel.instance:getSelectedSlot()

	if slot1 then
		slot0:_setAddPopItems(slot1)
	end

	for slot6, slot7 in pairs(slot0._overBuildingItemDict) do
		slot7:onChangeSelectedSlotItem()
	end
end

function slot0._onManufactureInfoUpdate(slot0)
	for slot4, slot5 in pairs(slot0._overBuildingItemDict) do
		slot5:onManufactureInfoUpdate()
	end
end

function slot0._onTradeLevelChange(slot0)
	for slot4, slot5 in pairs(slot0._overBuildingItemDict) do
		slot5:onTradeLevelChange()
	end
end

function slot0._onManufactureBuildingInfoChange(slot0, slot1)
	for slot5, slot6 in pairs(slot0._overBuildingItemDict) do
		slot6:onManufactureBuildingInfoChange(slot1)
	end
end

function slot0._onBuildingLevelUp(slot0, slot1)
	if slot1 and slot1[slot0._addPopBuildingUid] then
		slot0:_setAddPopItems(slot0._addPopBuildingUid, true)
	end
end

slot1 = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function slot0._onViewChange(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(uv0) do
		if slot1 == slot7 then
			slot2 = true

			break
		end
	end

	if slot2 then
		slot0:refreshPopBlock()
	end
end

function slot0._focusBuildingItemAddPop(slot0, slot1, slot2)
	if not (slot0._overBuildingItemDict[slot1] and slot3:getIndex()) then
		return
	end

	slot0._scrollbuilding.verticalNormalizedPosition = Mathf.Clamp(1 - (slot4 - 1) * (slot0._buildingItemHeight + slot0._layoutSpace) / (recthelper.getHeight(slot0._contentRect) - slot0._scrollHeight), 0, 1)

	ManufactureController.instance:clickSlotItem(slot1, nil, true, true, nil, slot2)
end

function slot0._editableInitView(slot0)
	slot0._scrollHeight = recthelper.getHeight(slot0._goscrollbuilding:GetComponent(gohelper.Type_RectTransform))
	slot0._buildingItemHeight = recthelper.getHeight(slot0._gobuildingItem:GetComponent(gohelper.Type_RectTransform))
	slot0._contentRect = slot0._gobuildingContent:GetComponent(gohelper.Type_RectTransform)
	slot0._layoutSpace = slot0._gobuildingContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup)).spacing

	slot0:clearVar()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_setBuildingList()
	slot0:everySecondCall()
	slot0:refreshPopBlock()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, TimeUtil.OneSecond)
end

function slot0._setBuildingList(slot0)
	slot0._overBuildingItemDict = {}

	gohelper.CreateObjList(slot0, slot0._onSetBuildingItem, ManufactureModel.instance:getAllPlacedManufactureBuilding(), slot0._gobuildingContent, slot0._gobuildingItem, RoomManufactureOverBuildingItem)
end

function slot0._onSetBuildingItem(slot0, slot1, slot2, slot3)
	slot1:setData(slot2, slot3, slot0)

	slot0._overBuildingItemDict[slot2.uid] = slot1
end

function slot0._setAddPopItems(slot0, slot1, slot2)
	if not slot2 and slot0._addPopBuildingUid == slot1 then
		return
	end

	ManufactureController.instance:setManufactureFormulaItemList(slot1)

	slot0._addPopBuildingUid = slot1
end

function slot0.setViewBuildingUid(slot0, slot1)
	slot0.viewContainer:setContainerViewBuildingUid(slot1)
end

function slot0.closePopView(slot0)
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
	ManufactureController.instance:closeWrongTipView()
end

function slot0.refreshPopBlock(slot0)
	gohelper.setActive(slot0._btnpopBlock, false)

	for slot4, slot5 in ipairs(uv0) do
		if ViewMgr.instance:isOpen(slot5) then
			gohelper.setActive(slot0._btnpopBlock, true)

			break
		end
	end
end

function slot0.everySecondCall(slot0)
	for slot4, slot5 in pairs(slot0._overBuildingItemDict) do
		slot5:everySecondCall()
	end
end

function slot0.clearVar(slot0)
	slot0._addPopBuildingUid = nil
end

function slot0._onGuideFocusCritter(slot0, slot1)
	recthelper.setAnchorY(slot0._gobuildingContent.transform, math.max(294 * slot1 - 807, 0))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	slot0:closePopView()
end

function slot0.onDestroyView(slot0)
	slot0:clearVar()
end

return slot0
