module("modules.logic.fight.system.work.FightWorkShowEquipSkillEffect", package.seeall)

slot0 = class("FightWorkShowEquipSkillEffect", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot3 = FightModel.instance:getCurRoundMO() and slot2.fightStepMOs
	slot4 = nil

	if slot0._fightStepMO.custom_stepIndex then
		slot4 = slot0._fightStepMO.custom_stepIndex + 1
	end

	slot0._nextStepMO = slot3 and slot3[slot4]
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5)

	if slot0._fightStepMO.actType == FightEnum.ActType.SKILL and not FightReplayModel.instance:isReplay() and EquipConfig.instance:isEquipSkill(slot0._fightStepMO.actId) then
		if slot0._fightStepMO.actEffectMOs and #slot0._fightStepMO.actEffectMOs == 1 and slot0._fightStepMO.actEffectMOs[1].effectType == FightEnum.EffectType.BUFFADD and slot2.buff and lua_skill_buff.configDict[slot2.buff.buffId] and string.nilorempty(slot3.features) then
			slot0:onDone(true)

			return
		end

		FightController.instance:dispatchEvent(FightEvent.OnFloatEquipEffect, slot0._fightStepMO.fromId, slot1)

		if slot0._nextStepMO and slot0._nextStepMO.fromId == slot0._fightStepMO.fromId and FightCardModel:isActiveSkill(slot0._nextStepMO.fromId, slot0._nextStepMO.actId) then
			TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5 / FightModel.instance:getUISpeed())

			return
		end
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
