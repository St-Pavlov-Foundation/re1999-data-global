module("modules.logic.scene.room.fsm.RoomTransitionEnterWaterReform", package.seeall)

slot0 = class("RoomTransitionEnterWaterReform", SimpleFSMBaseTransition)

function slot0.start(slot0)
end

function slot0.onStart(slot0, slot1)
	RoomWaterReformListModel.instance:initShowBlock()
	RoomWaterReformModel.instance:initWaterArea()
	RoomWaterReformModel.instance:setWaterReform(true)
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectRoomViewBlockOpTab, RoomEnum.RoomViewBlockOpMode.WaterReform)
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
