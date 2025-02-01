module("modules.logic.guide.controller.action.impl.GuideActionDispatchFightEvent", package.seeall)

slot0 = class("GuideActionDispatchFightEvent", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot4 = string.split(slot3, "#")
	slot0._evtId = FightEvent[slot4[1]]
	slot0._evtParamList = nil

	for slot9 = 2, #slot4, 2 do
		slot0._evtParamList = slot0._evtParamList or {}

		table.insert(slot0._evtParamList, string.getValueByType(slot4[slot9], slot4[slot9 + 1]) or slot10)
	end
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._evtParamList then
		FightController.instance:dispatchEvent(slot0._evtId, unpack(slot0._evtParamList))
	else
		FightController.instance:dispatchEvent(slot0._evtId)
	end

	slot0:onDone(true)
end

return slot0
