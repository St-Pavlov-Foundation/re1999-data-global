module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle1", package.seeall)

slot0 = class("EntitySpecialIdle1", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)

	slot0._entity = slot1
end

function slot0.detectState(slot0)
	if slot0._entity:getMO() and slot1:getBuffDic() then
		for slot6, slot7 in pairs(slot2) do
			if slot7.buffId == 30513 or slot7.buffId == 30515 then
				FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot0._entity.id)
			end
		end
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2 == FightEnum.EffectType.BUFFADD and (slot3 == 30513 or slot3 == 30515) then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot0._entity.id)
	end
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
