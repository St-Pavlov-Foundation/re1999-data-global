module("modules.logic.guide.controller.trigger.GuideTriggerRoomConfirmBuilding", package.seeall)

slot0 = class("GuideTriggerRoomConfirmBuilding", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	RoomBuildingController.instance:registerCallback(RoomEvent.ConfirmBuilding, slot0._onConfirmBuilding, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == tonumber(slot2)
end

function slot0._onConfirmBuilding(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:checkStartGuide(slot1)
	end
end

return slot0
