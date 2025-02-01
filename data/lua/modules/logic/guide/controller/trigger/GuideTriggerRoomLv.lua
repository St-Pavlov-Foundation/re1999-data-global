module("modules.logic.guide.controller.trigger.GuideTriggerRoomLv", package.seeall)

slot0 = class("GuideTriggerRoomLv", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == SceneType.Room and tonumber(slot2) <= slot0:getParam()
end

function slot0.getParam(slot0)
	return RoomMapModel.instance:getRoomLevel()
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

function slot0._checkStartGuide(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:checkStartGuide(slot1)
	end
end

return slot0
