module("modules.logic.guide.controller.trigger.GuideTriggerRoomReset", package.seeall)

slot0 = class("GuideTriggerRoomReset", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	RoomMapController.instance:registerCallback(RoomEvent.Reset, slot0._onReset, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function slot0._onReset(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:checkStartGuide()
	end
end

return slot0
