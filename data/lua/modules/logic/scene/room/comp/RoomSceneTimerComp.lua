module("modules.logic.scene.room.comp.RoomSceneTimerComp", package.seeall)

slot0 = class("RoomSceneTimerComp", BaseSceneComp)

function slot0.init(slot0, slot1, slot2)
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, TimeUtil.OneSecond)
	RoomMapController.instance:dispatchEvent(RoomEvent.RoomTimerInitComplete)
end

function slot0.everySecondCall(slot0)
	if RoomController.instance:isDebugMode() then
		return
	end

	ManufactureController.instance:checkManufactureInfoUpdate()
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

return slot0
