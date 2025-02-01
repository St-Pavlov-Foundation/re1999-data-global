module("modules.logic.fight.system.work.FightWorkSkillDelay", package.seeall)

slot0 = class("FightWorkSkillDelay", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	if lua_fight_skill_delay.configDict[slot0._fightStepMO.actId] then
		if FightReplayModel.instance:isReplay() then
			slot0:onDone(true)
		else
			TaskDispatcher.runDelay(slot0._delayDone, slot0, slot1.delay / 1000 / FightModel.instance:getSpeed())
		end
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
