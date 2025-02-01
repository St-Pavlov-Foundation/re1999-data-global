module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomInitBuildingLvUp", package.seeall)

slot0 = class("WaitGuideActionRoomInitBuildingLvUp", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._targetLevel = tonumber(slot0.actionParam) or 3

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, slot0._onUpdateRoomLevel, slot0, LuaEventSystem.Low)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.RoomInitBuildingView and slot0:_isSatisfy() then
		slot0:onDone(true)
	end
end

function slot0._isSatisfy(slot0)
	return ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) and slot0._targetLevel <= RoomMapModel.instance:getRoomLevel()
end

function slot0._onUpdateRoomLevel(slot0)
	if slot0:_isSatisfy() then
		slot0:_checkTaskFinish()
	end
end

function slot0._checkTaskFinish(slot0)
	slot1, slot2 = RoomSceneTaskController.instance:isFirstTaskFinished()

	if slot1 then
		TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, slot0._checkTaskFinish, slot0, LuaEventSystem.Low)
	else
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, slot0._onUpdateRoomLevel, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, slot0._checkTaskFinish, slot0)
end

return slot0
