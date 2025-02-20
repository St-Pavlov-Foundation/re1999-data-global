module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle6", package.seeall)

slot0 = class("EntitySpecialIdle6", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = slot1
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if FightHelper.getEntity(slot3.toId) and slot4:isMySide() and slot4:getMO() and slot5.modelId == 3025 then
		for slot9, slot10 in ipairs(slot3.actEffectMOs) do
			if slot10.effectType == FightEnum.EffectType.MISS and slot10.targetId == slot4.id then
				for slot15, slot16 in pairs(slot5:getBuffDic()) do
					if slot16.buffId == 710601 or slot16.buffId == 710602 then
						FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot4.id)

						return
					end
				end
			end
		end
	end
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
