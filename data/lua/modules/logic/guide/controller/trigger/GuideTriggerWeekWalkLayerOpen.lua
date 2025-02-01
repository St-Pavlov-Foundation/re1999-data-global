module("modules.logic.guide.controller.trigger.GuideTriggerWeekWalkLayerOpen", package.seeall)

slot0 = class("GuideTriggerWeekWalkLayerOpen", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, slot0._checkStartGuide, slot0)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnWeekwalkInfoUpdate, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return WeekWalkModel.instance:getMapInfo(tonumber(slot2))
end

function slot0._onMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:checkStartGuide()
	end
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
