module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle7", package.seeall)

slot0 = class("EntitySpecialIdle7", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = slot1
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1.id ~= slot0._entity.id then
		return
	end

	for slot7, slot8 in ipairs(slot3.actEffectMOs) do
		if slot8.effectType == FightEnum.EffectType.DEAD then
			FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot1.id)

			break
		end
	end
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
