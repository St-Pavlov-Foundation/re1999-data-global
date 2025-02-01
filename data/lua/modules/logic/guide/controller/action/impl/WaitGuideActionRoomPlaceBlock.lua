module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlaceBlock", package.seeall)

slot0 = class("WaitGuideActionRoomPlaceBlock", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot0._placeCount = tonumber(slot0.actionParam)

	uv0.super.onStart(slot0, slot1)
	RoomMapController.instance:registerCallback(RoomEvent.OnUseBlock, slot0._checkPlaceCount, slot0)
	slot0:_checkPlaceCount()
end

function slot0._checkPlaceCount(slot0)
	if slot0._placeCount <= RoomMapBlockModel.instance:getFullBlockCount() then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.OnUseBlock, slot0._checkPlaceCount, slot0)
end

return slot0
