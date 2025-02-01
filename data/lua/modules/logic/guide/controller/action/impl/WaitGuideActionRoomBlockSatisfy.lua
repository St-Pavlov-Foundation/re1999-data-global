module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBlockSatisfy", package.seeall)

slot0 = class("WaitGuideActionRoomBlockSatisfy", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._check, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._check, slot0)

	slot0._blockCount = tonumber(slot0.actionParam)

	slot0:_check()
end

function slot0._check(slot0)
	if slot0:_checkBlockCount() and slot0:_checkRoomOb() then
		GuidePriorityController.instance:add(slot0.guideId, slot0._satisfyPriority, slot0, 0.01)
	end
end

function slot0._checkBlockCount(slot0)
	return slot0._blockCount <= RoomMapBlockModel.instance:getFullBlockCount()
end

function slot0._checkRoomOb(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return RoomController.instance:isObMode()
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._check, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0._check, slot0)
	GuidePriorityController.instance:remove(slot0.guideId)
end

function slot0._satisfyPriority(slot0)
	slot0:onDone(true)
end

return slot0
