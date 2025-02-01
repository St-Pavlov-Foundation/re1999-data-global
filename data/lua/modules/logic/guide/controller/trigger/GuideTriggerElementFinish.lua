module("modules.logic.guide.controller.trigger.GuideTriggerElementFinish", package.seeall)

slot0 = class("GuideTriggerElementFinish", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateMapElementState, slot0._OnUpdateMapElementState, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if DungeonConfig.instance:getChapterMapElement(tonumber(slot2)) and slot5.mapId == tonumber(slot1) and DungeonMapModel.instance:elementIsFinished(slot3) then
		return true
	end

	return false
end

function slot0._OnUpdateMapElementState(slot0, slot1)
	slot0:checkStartGuide(slot1)
end

return slot0
