module("modules.logic.guide.controller.trigger.GuideTriggerRoomEnterEdit", package.seeall)

slot0 = class("GuideTriggerRoomEnterEdit", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == SceneType.Room and RoomController.instance:isEditMode()
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

return slot0
