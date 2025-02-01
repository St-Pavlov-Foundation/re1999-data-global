module("modules.logic.room.controller.RoomBackpackController", package.seeall)

slot0 = class("RoomBackpackController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
end

function slot0.clickCritterRareSort(slot0, slot1)
	RoomBackpackCritterListModel.instance:setIsSortByRareAscend(not RoomBackpackCritterListModel.instance:getIsSortByRareAscend())
	slot0:refreshCritterBackpackList(slot1)
end

function slot0.selectMatureFilterType(slot0, slot1, slot2)
	if RoomBackpackCritterListModel.instance:getMatureFilterType() and slot3 == slot1 then
		return
	end

	RoomBackpackCritterListModel.instance:setMatureFilterType(slot1)
	slot0:refreshCritterBackpackList(slot2)
end

function slot0.refreshCritterBackpackList(slot0, slot1)
	RoomBackpackCritterListModel.instance:setBackpackCritterList(slot1)
end

function slot0.openCritterDecomposeView(slot0)
	ViewMgr.instance:openView(ViewName.RoomCritterDecomposeView)
end

function slot0.refreshPropBackpackList(slot0)
	RoomBackpackPropListModel.instance:setBackpackPropList()
end

slot0.instance = slot0.New()

return slot0
