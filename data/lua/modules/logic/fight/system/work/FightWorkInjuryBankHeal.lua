module("modules.logic.fight.system.work.FightWorkInjuryBankHeal", package.seeall)

slot0 = class("FightWorkInjuryBankHeal", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = 2 / FightModel.instance:getSpeed()

	if FightHelper.getEntity(slot0._actEffectMO.targetId) then
		if slot2.nameUI then
			slot3 = slot0._actEffectMO.effectNum

			FightFloatMgr.instance:float(slot2.id, FightEnum.FloatType.heal, slot3)
			slot2.nameUI:addHp(slot3)
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot2, slot3)
		end

		if not (slot2.spine and slot2.spine:getSpineGO()) then
			slot0:onDone(true)

			return
		end

		if not slot2.effect then
			slot0:onDone(true)

			return
		end

		slot4 = slot2.effect:addHangEffect("buff/buff_jiaxue", nil, , slot1)

		FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot4)
		slot4:setLocalPos(0, 0, 0)
		FightAudioMgr.instance:playAudio(410000015)

		if not FightEntityModel.instance:getById(slot2.id) then
			slot0:onDone(true)

			return
		end

		slot7 = false

		for slot11, slot12 in ipairs(slot5:getBuffList() or {}) do
			if FightConfig.instance:hasBuffFeature(slot12.buffId, FightEnum.BuffFeature.InjuryBank) then
				slot7 = true

				break
			end
		end

		if slot7 then
			if not (gohelper.findChild(slot3, ModuleEnum.SpineHangPointRoot) and gohelper.findChild(slot8, "special1")) then
				slot0:onDone(true)

				return
			end

			slot10 = slot2.effect:addHangEffect("v1a9_kkny/kkny_innate2_s1", "special1", nil, slot1)

			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot10)
			slot10:setLocalPos(0, 0, 0)
			FightAudioMgr.instance:playAudio(430800102)
		end
	end

	slot0:com_registTimer(slot0._delayAfterPerformance, slot1)
end

function slot0.clearWork(slot0)
end

return slot0
