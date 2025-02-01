module("modules.logic.fight.entity.mgr.FightSkillMgr", package.seeall)

slot0 = class("FightSkillMgr")

function slot0.ctor(slot0)
	slot0._playingEntityId2StepMO = {}
	slot0._playingSkillCount = 0
end

function slot0.init(slot0)
end

function slot0.dispose(slot0)
	slot0._playingEntityId2StepMO = {}
	slot0._playingSkillCount = 0
end

function slot0.beforeTimeline(slot0, slot1, slot2)
	slot0._playingSkillCount = slot0._playingSkillCount + 1
	slot0._playingEntityId2StepMO[slot1.id] = slot2 or 1

	slot1:resetEntity()
	FightController.instance:dispatchEvent(FightEvent.BeforePlayTimeline, slot1.id)

	if slot0:isUniqueSkill(slot1, slot2) then
		FightController.instance:dispatchEvent(FightEvent.BeforePlayUniqueSkill, slot1.id)
	end
end

function slot0.afterTimeline(slot0, slot1, slot2)
	slot0._playingSkillCount = slot0._playingSkillCount - 1

	if slot0._playingSkillCount < 0 then
		slot0._playingSkillCount = 0
	end

	slot0._playingEntityId2StepMO[slot1.id] = nil

	if slot2 and slot0:isUniqueSkill(slot1, slot2) then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayUniqueSkill, slot1.id)

		for slot7, slot8 in ipairs(FightHelper.getAllEntitys()) do
			slot8:resetEntity()
		end
	else
		slot1:resetEntity()
	end

	if not slot0:isPlayingAnyTimeline() then
		FightTLEventUIVisible.resetLatestStepUid()
	end
end

function slot0.isUniqueSkill(slot0, slot1, slot2)
	if slot1:getMO() and FightCardModel.instance:isUniqueSkill(slot3.id, slot2.actId) then
		return true
	end
end

function slot0.isEntityPlayingTimeline(slot0, slot1)
	return slot0._playingEntityId2StepMO[slot1] ~= nil
end

function slot0.isPlayingAnyTimeline(slot0)
	return slot0._playingSkillCount > 0
end

slot0.instance = slot0.New()

return slot0
