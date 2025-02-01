module("modules.logic.fight.system.work.FightWorkBFSGSkillEnd", package.seeall)

slot0 = class("FightWorkBFSGSkillEnd", FightEffectBase)

function slot0.onStart(slot0)
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	FightModel.forceParallelSkill = false

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
