module("modules.logic.fight.system.work.FightParallelPlayNextSkillStep", package.seeall)

slot0 = class("FightParallelPlayNextSkillStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.stepMO = slot1
	slot0.prevStepMO = slot2
	slot0.fightStepMOs = slot3

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._parallelPlayNextSkillCheck(slot0, slot1)
	if slot1 ~= slot0.prevStepMO then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.prevStepMO.fromId) then
		return
	end

	if FightCardModel.instance:isUniqueSkill(slot2.fromId, slot0.prevStepMO.actId) then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.stepMO.fromId) then
		return
	end

	if FightCardModel.instance:isUniqueSkill(slot0.stepMO.fromId, slot0.stepMO.actId) then
		return
	end

	if FightSkillMgr.instance:isEntityPlayingTimeline(slot0.stepMO.fromId) then
		return
	end

	if slot0.stepMO.fromId == slot0.prevStepMO.fromId then
		return
	end

	if FightDataHelper.entityMgr:getById(slot0.stepMO.fromId).side ~= FightDataHelper.entityMgr:getById(slot0.prevStepMO.fromId).side then
		return
	end

	if slot0.fightStepMOs then
		for slot10 = (tabletool.indexOf(slot0.fightStepMOs, slot1) or #slot0.fightStepMOs) + 1, #slot0.fightStepMOs do
			if slot0.fightStepMOs[slot10].actType == FightEnum.ActType.EFFECT then
				for slot15, slot16 in ipairs(slot11.actEffectMOs) do
					if slot16.effectType == FightEnum.EffectType.DEAD and slot1.fromId == slot16.targetId then
						return
					end
				end
			end
		end
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)

	slot0.stepMO.isParallelStep = true

	FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillDoneThis, slot1)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, slot0._parallelPlayNextSkillCheck, slot0)
end

return slot0
