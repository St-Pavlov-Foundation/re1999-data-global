module("modules.logic.fight.system.work.FightWorkBFSGSkillStart", package.seeall)

slot0 = class("FightWorkBFSGSkillStart", FightEffectBase)

function slot0.onStart(slot0)
	uv0.BeiFangShaoGeUniqueSkill = 1
	FightModel.forceParallelSkill = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, false)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
