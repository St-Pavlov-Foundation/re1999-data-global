module("modules.logic.room.view.manufacture.RoomTransportOverView", package.seeall)

slot0 = class("RoomTransportOverView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotransportContent = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	slot0._gotransportItem = gohelper.findChild(slot0.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	slot0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_popBlock")
	slot0._btnoneKeyCritter = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottomBtns/#btn_oneKeyCritter")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoneKeyCritter:AddClickListener(slot0._btnoneKeyCritterOnClick, slot0)
	slot0._btnpopBlock:AddClickListener(slot0._btnpopBlockOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoneKeyCritter:RemoveClickListener()
	slot0._btnpopBlock:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0._btnoneKeyCritterOnClick(slot0)
	ManufactureController.instance:oneKeyCritter(true)
end

function slot0._btnpopBlockOnClick(slot0)
	slot0:_closeCritterListView()
end

function slot0._onManufactureInfoUpdate(slot0)
	for slot4, slot5 in ipairs(slot0._transportItemList) do
		slot5:onManufactureInfoUpdate()
	end
end

function slot0._onViewChange(slot0, slot1)
	if slot1 ~= ViewName.RoomCritterListView then
		return
	end

	slot0:refreshPopBlock()
end

function slot0._editableInitView(slot0)
	slot0:_setTransportList()
end

function slot0._setTransportList(slot0)
	slot0._transportItemList = {}
	slot1 = true

	if RoomMapTransportPathModel.instance:getMaxCount() < #RoomMapTransportPathModel.instance:getTransportPathMOList() then
		slot1 = false

		logError(string.format("RoomTransportOverView:_setTransportList error path count more than maxCount, pathCount:%s, maxCount:%s", #slot3, slot2))
	end

	slot4 = {}

	for slot9 = 1, #RoomTransportHelper.getSiteBuildingTypeList() do
		slot11 = slot3[slot9]

		if slot1 and slot11 and slot11:isLinkFinish() then
			-- Nothing
		end

		slot4[slot9] = {
			mo = slot11
		}
	end

	gohelper.CreateObjList(slot0, slot0._onSetTransportItem, slot4, slot0._gotransportContent, slot0._gotransportItem, RoomTransportOverItem)
end

function slot0._onSetTransportItem(slot0, slot1, slot2, slot3)
	slot1:setData(slot2.mo)

	slot0._transportItemList[slot3] = slot1
end

function slot0._closeCritterListView(slot0)
	ManufactureController.instance:clearSelectTransportPath()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshPopBlock()
	slot0:everySecondCall()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, TimeUtil.OneSecond)
end

function slot0.refreshPopBlock(slot0)
	gohelper.setActive(slot0._btnpopBlock, ViewMgr.instance:isOpen(ViewName.RoomCritterListView))
end

function slot0.everySecondCall(slot0)
	if slot0._transportItemList then
		for slot4, slot5 in ipairs(slot0._transportItemList) do
			slot5:everySecondCall()
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	slot0:_closeCritterListView()
end

function slot0.onDestroyView(slot0)
end

return slot0
