module("modules.logic.guide.controller.action.impl.GuideActionSkillContinue", package.seeall)

slot0 = class("GuideActionSkillContinue", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.OnGuideBeforeSkillContinue)
	slot0:onDone(true)
end

return slot0
