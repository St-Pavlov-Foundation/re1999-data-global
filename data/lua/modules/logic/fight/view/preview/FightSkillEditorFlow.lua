module("modules.logic.fight.view.preview.FightSkillEditorFlow", package.seeall)

slot0 = class("FightSkillEditorFlow", BaseFlow)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot0._skillReleaseFlow = FlowParallel.New()
	slot7 = slot0._playSkill

	slot0._skillReleaseFlow:addWork(FunctionWork.New(slot7, slot0))

	slot2 = nil

	for slot6, slot7 in ipairs(slot1.actEffectMOs) do
		if (slot7.effectType == FightEnum.EffectType.HEAL or slot7.effectType == FightEnum.EffectType.HEALCRIT) and slot7.effectNum > 0 then
			if not slot2 then
				slot0._skillReleaseFlow:addWork(FightWorkSkillFinallyHeal.New(slot1))
			end

			slot2:addActEffectMO(slot7)
		end
	end
end

function slot0._playSkill(slot0)
	slot0._attacker = FightHelper.getEntity(slot0._fightStepMO.fromId)
	slot0._skillId = slot0._fightStepMO.actId

	if string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot0._attacker:getMO() and slot1.skin, slot0._skillId)) then
		slot0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)

	if FightSkillMgr.instance:isEntityPlayingTimeline(slot0._attacker.id) then
		TaskDispatcher.runRepeat(slot0._checkNoSkillPlaying, slot0, 0.01)
	else
		slot0._attacker.skill:playSkill(slot0._skillId, slot0._fightStepMO)
	end
end

function slot0._checkNoSkillPlaying(slot0)
	if not FightSkillMgr.instance:isEntityPlayingTimeline(slot0._attacker.id) then
		TaskDispatcher.cancelTask(slot0._checkNoSkillPlaying, slot0)
		slot0._attacker.skill:playSkill(slot0._skillId, slot0._fightStepMO)
	end
end

function slot0._onSkillEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
	slot0:onDone(true)
end

function slot0.onStart(slot0)
	slot0._skillReleaseFlow:start()
end

function slot0.clearWork(slot0)
end

function slot0.onDestroy(slot0)
	if slot0._skillReleaseFlow then
		slot0._skillReleaseFlow:stop()

		slot0._skillReleaseFlow = nil
	end

	uv0.super.onDestroy(slot0)
end

function slot0.stopSkillFlow(slot0)
	if slot0._skillReleaseFlow and slot0._skillReleaseFlow.status == WorkStatus.Running then
		for slot6 = slot0._skillReleaseFlow._curIndex, #slot0._skillReleaseFlow:getWorkList() do
			slot1[slot6]:onDone(true)
		end

		slot0._skillReleaseFlow:stop()

		slot0._skillReleaseFlow = nil
	end
end

return slot0
