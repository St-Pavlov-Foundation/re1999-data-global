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

		if not FightDataHelper.entityMgr:getById(slot2.id) then
			slot0:onDone(true)

			return
		end

		slot7 = false

		for slot11, slot12 in pairs(slot5:getBuffDic()) do
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

			if not lua_fight_sp_effect_kkny_heal.configDict[slot5.skin] then
				slot0:onDone(true)

				return
			end

			slot11 = slot2.effect:addHangEffect(slot10.path, slot10.hangPoint, nil, slot1)

			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot11)
			slot11:setLocalPos(0, 0, 0)
			FightAudioMgr.instance:playAudio(slot10.audio)
		end
	end

	slot0:com_registTimer(slot0._delayAfterPerformance, slot1)
end

function slot0.clearWork(slot0)
end

return slot0
