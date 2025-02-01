module("modules.logic.fight.system.work.FightGuideBeforeSkill", package.seeall)

slot0 = class("FightGuideBeforeSkill", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0, slot1)
	if slot0._fightStepMO.fromId == FightEntityScene.MySideId or slot0._fightStepMO.fromId == FightEntityScene.EnemySideId then
		slot0:_done()

		return
	end

	slot0._attacker = FightHelper.getEntity(slot0._fightStepMO.fromId)
	slot0._skillId = slot0._fightStepMO.actId

	if slot0._attacker == nil then
		slot0:_done()

		return
	end

	slot2 = FightController.instance:GuideFlowPauseAndContinue("OnGuideBeforeSkillPause", FightEvent.OnGuideBeforeSkillPause, FightEvent.OnGuideBeforeSkillContinue, slot0._done, slot0, slot0._attacker:getMO().modelId, slot0._skillId)
end

function slot0._done(slot0)
	slot0:onDone(true)
end

return slot0
