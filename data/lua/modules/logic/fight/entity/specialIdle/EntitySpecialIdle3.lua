module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle3", package.seeall)

slot0 = class("EntitySpecialIdle3", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = slot1
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot1.id ~= slot0._entity.id then
		return
	end

	if slot0._entity:getMO():isUniqueSkill(slot2) then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot1.id)
	end
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
