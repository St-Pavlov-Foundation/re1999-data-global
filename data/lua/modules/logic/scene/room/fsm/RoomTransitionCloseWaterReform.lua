module("modules.logic.scene.room.fsm.RoomTransitionCloseWaterReform", package.seeall)

slot0 = class("RoomTransitionCloseWaterReform", SimpleFSMBaseTransition)

function slot0.start(slot0)
end

function slot0.onStart(slot0, slot1)
	RoomWaterReformListModel.instance:clear()
	RoomWaterReformController.instance:clearSelectWater()
	RoomWaterReformModel.instance:clear()
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
