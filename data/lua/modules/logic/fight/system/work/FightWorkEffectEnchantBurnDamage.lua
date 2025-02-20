module("modules.logic.fight.system.work.FightWorkEffectEnchantBurnDamage", package.seeall)

slot0 = class("FightWorkEffectEnchantBurnDamage", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.effectNum > 0 then
		FightFloatMgr.instance:float(slot1.id, FightEnum.FloatType.damage, slot1:isMySide() and -slot2 or slot2)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)

		slot4 = slot1.effect:addHangEffect("buff/buff_shenghuo", "mountbody", nil, 1.5 / FightModel.instance:getSpeed())

		FightAudioMgr.instance:playAudio(4307301)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot4)
		slot4:setLocalPos(0, 0, 0)
	end

	slot0:onDone(true)
end

return slot0
