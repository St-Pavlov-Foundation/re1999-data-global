module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle9", package.seeall)

slot0 = class("EntitySpecialIdle9", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)

	slot0._entity = slot1
end

function slot0._onMySideRoundEnd(slot0)
	FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot0._entity.id)
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
