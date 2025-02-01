module("modules.logic.guide.controller.action.impl.GuideActionEntityDeadContinue", package.seeall)

slot0 = class("GuideActionEntityDeadContinue", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.OnGuideEntityDeadContinue)
	slot0:onDone(true)
end

return slot0
