module("modules.logic.guide.controller.trigger.GuideTriggerCachotEnterRoom", package.seeall)

slot0 = class("GuideTriggerCachotEnterRoom", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._onUpdateRogueInfo, slot0)
end

function slot0._onUpdateRogueInfo(slot0)
	slot0:checkStartGuide()
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRoomView) then
		return
	end

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	slot4, slot5 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(slot3.room)
	slot6 = string.splitToNumber(slot2, "_")

	return slot6[1] == slot3.layer and slot6[2] == slot4
end

function slot0._onOpenView(slot0, slot1, slot2)
	if slot1 == ViewName.V1a6_CachotRoomView then
		slot0:checkStartGuide()
	end
end

return slot0
