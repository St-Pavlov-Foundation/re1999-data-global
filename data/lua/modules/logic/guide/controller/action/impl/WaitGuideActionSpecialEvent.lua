module("modules.logic.guide.controller.action.impl.WaitGuideActionSpecialEvent", package.seeall)

slot0 = class("WaitGuideActionSpecialEvent", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._eventName = #string.split(slot3, "#") >= 1 and slot4[1]
	slot0._eventEnum = slot0._eventName and GuideEnum.SpecialEventEnum[slot0._eventName] or 0
	slot0._guideId = slot1
	slot0._stepId = slot2
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0._eventEnum == 0 then
		logError("找不到特殊事件: " .. tostring(slot0._eventName))
		slot0:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.SpecialEventDone, slot0._onEventDone, slot0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventStart, slot0._eventEnum, slot0._guideId, slot0._stepId)
end

function slot0._onEventDone(slot0, slot1)
	if slot0._eventEnum == slot1 then
		GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, slot0._onEventDone, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, slot0._onEventDone, slot0)
end

return slot0
