module("modules.logic.guide.controller.trigger.GuideTriggerOpenViewCondition", package.seeall)

slot0 = class("GuideTriggerOpenViewCondition", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	slot3 = string.split(slot2, "_")
	slot5 = slot3[2]
	slot6 = slot3[3]

	if slot1 ~= slot3[1] then
		return false
	end

	return uv0[slot5](slot6)
end

function slot0._onOpenView(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

function slot0.checkInEliminateEpisode(slot0)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(slot0)
end

return slot0
