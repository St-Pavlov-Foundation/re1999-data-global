module("modules.logic.fight.system.work.FightParallelPlaySameSkillStep", package.seeall)

slot0 = class("FightParallelPlaySameSkillStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0.stepMO = slot1
	slot0.prevStepMO = slot2

	FightController.instance:registerCallback(FightEvent.ParallelPlaySameSkillCheck, slot0._parallelPlaySameSkillCheck, slot0)
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._parallelPlaySameSkillCheck(slot0, slot1)
	if slot1 ~= slot0.prevStepMO then
		return
	end

	if slot0.stepMO.fromId == slot0.prevStepMO.fromId and slot0.stepMO.actId == slot0.prevStepMO.actId and slot0.stepMO.toId == slot0.prevStepMO.toId then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlaySameSkillDoneThis, slot1)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlaySameSkillCheck, slot0._parallelPlaySameSkillCheck, slot0)
end

return slot0
