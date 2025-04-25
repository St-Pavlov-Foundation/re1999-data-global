module("modules.logic.fight.entity.comp.FightEntityBuffSpecialPrecessComp", package.seeall)

slot0 = class("FightEntityBuffSpecialPrecessComp", FightBaseClass)

function slot0.onAwake(slot0, slot1)
	slot0._entity = slot1

	slot0:com_registFightEvent(FightEvent.AddEntityBuff, slot0._onAddEntityBuff)
end

function slot0._onAddEntityBuff(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	slot0:_registBuffIdClass(slot2.buffId, slot2.uid)
end

slot1 = {
	[4150022] = FightBuffJuDaBenYePuDormancyHand,
	[4150023] = FightBuffJuDaBenYePuDormancyTail
}

function slot0._registBuffIdClass(slot0, slot1, slot2)
	if uv0[slot1] then
		slot0:newClass(uv0[slot1], slot0._entity, slot1, slot2)
	end
end

function slot0.releaseSelf(slot0)
end

return slot0
