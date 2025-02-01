module("modules.logic.guide.controller.trigger.GuideTriggerRoomOpenBuildingStrengthView", package.seeall)

slot0 = class("GuideTriggerRoomOpenBuildingStrengthView", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function slot0._onOpenBuildingStrengthView(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:checkStartGuide(slot1)
	end
end

return slot0
