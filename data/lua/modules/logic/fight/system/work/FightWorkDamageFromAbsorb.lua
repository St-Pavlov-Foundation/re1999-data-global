module("modules.logic.fight.system.work.FightWorkDamageFromAbsorb", package.seeall)

slot0 = class("FightWorkDamageFromAbsorb", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) then
		if slot0._actEffectMO.effectNum > 0 then
			FightFloatMgr.instance:float(slot1.id, FightEnum.FloatType.damage, slot1:isMySide() and -slot2 or slot2)

			if slot1.nameUI then
				slot1.nameUI:addHp(-slot2)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
		end

		if not slot1.effect then
			slot0:onDone(true)

			return
		end

		if not (slot1.spine and slot1.spine:getSpineGO()) then
			slot0:onDone(true)

			return
		end

		if not (gohelper.findChild(slot3, ModuleEnum.SpineHangPointRoot) and gohelper.findChild(slot4, "special1")) then
			slot0:onDone(true)

			return
		end

		if not FightDataHelper.entityMgr:getById(slot1.id) then
			slot0:onDone(true)

			return
		end

		if not lua_fight_sp_effect_kkny_bear_damage.configDict[slot6.skin] then
			slot0:onDone(true)

			return
		end

		slot8 = slot1.effect:addHangEffect(slot7.path, slot7.hangPoint, nil, 1.2 / FightModel.instance:getSpeed())

		FightAudioMgr.instance:playAudio(slot7.audio)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot8)
		slot8:setLocalPos(0, 0, 0)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
