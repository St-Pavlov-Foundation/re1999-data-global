module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCanGetResources", package.seeall)

slot0 = class("WaitGuideActionRoomCanGetResources", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._partId = tonumber(slot0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._onEnterOneSceneFinish(slot0, slot1)
	if slot0:checkGuideLock() then
		return
	end

	if slot1 == SceneType.Room and RoomController.instance:isObMode() and #RoomProductionHelper.getCanGainLineIdList(slot0._partId) > 0 then
		GuidePriorityController.instance:add(slot0.guideId, slot0._satisfyPriority, slot0, 0.01)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot0:checkGuideLock() then
		return
	end

	if slot1 == ViewName.RoomInitBuildingView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	GuidePriorityController.instance:remove(slot0.guideId)
end

function slot0._satisfyPriority(slot0)
	slot0:onDone(true)
end

return slot0
