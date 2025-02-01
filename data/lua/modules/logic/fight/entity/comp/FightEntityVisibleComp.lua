module("modules.logic.fight.entity.comp.FightEntityVisibleComp", package.seeall)

slot0 = class("FightEntityVisibleComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._hideByEntity = nil
	slot0._hideBySkill = nil

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.beforeDestroy(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot2 == FightEnum.AppearTimelineSkillId then
		return
	end

	if FightHelper.getRelativeEntityIdDict(slot3)[slot0.entity.id] then
		slot0.entity:setAlpha(1, 0)

		slot0._hideByEntity = nil
		slot0._hideBySkill = nil
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1.skill and slot1.skill:sameSkillPlaying() then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, slot0.entity.id, true)

	if FightWorkStepChangeHero.playingChangeHero or FightWorkChangeHero.playingChangeHero then
		return
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		slot0.entity:setAlpha(1, 0)

		slot0._hideByEntity = nil
		slot0._hideBySkill = nil
	elseif slot0._hideByEntity and slot0._hideByEntity == slot1.id and slot0._hideBySkill == slot2 then
		slot0.entity:setAlpha(1, 0)

		slot0._hideByEntity = nil
		slot0._hideBySkill = nil
	elseif slot3.stepUid == FightTLEventEntityVisible.latestStepUid then
		slot0.entity:setAlpha(1, 0)

		slot0._hideByEntity = nil
		slot0._hideBySkill = nil
	end
end

function slot0._setEntityVisibleByTimeline(slot0, slot1, slot2, slot3, slot4)
	if slot0.entity.id ~= slot1.id then
		return
	end

	if slot3 then
		slot0.entity:setAlpha(1, slot4)

		slot0._hideByEntity = nil
		slot0._hideBySkill = nil
	else
		slot0.entity:setAlpha(0, slot4)

		slot0._hideByEntity = slot1.id
		slot0._hideBySkill = slot2.actId
	end

	if not slot3 then
		FightFloatMgr.instance:hideEntityEquipFloat(slot1.id)
	end

	if not FightSkillMgr.instance:isUniqueSkill(slot1, slot2) then
		FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, slot1.id, slot3)
	end
end

return slot0
