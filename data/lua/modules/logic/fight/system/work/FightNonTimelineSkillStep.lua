module("modules.logic.fight.system.work.FightNonTimelineSkillStep", package.seeall)

slot0 = class("FightNonTimelineSkillStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.stepMO = slot1
end

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnInvokeSkill, slot0.stepMO)
	slot0:onDone(true)
end

return slot0
