module("modules.logic.fight.entity.comp.FightTotalDamageComp", package.seeall)

slot0 = class("FightTotalDamageComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._damageDict = {}
end

function slot0.init(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnDamageTotal, slot0._onDamageTotal, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

function slot0.removeEventListeners(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDamageTotal, slot0._onDamageTotal, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._showTotalFloat, slot0)
end

function slot0._onDamageTotal(slot0, slot1, slot2, slot3, slot4)
	if slot2 == slot0.entity and slot3 and slot3 > 0 then
		slot0._damageDict[slot1] = slot0._damageDict[slot1] or {}

		table.insert(slot0._damageDict[slot1], slot3)

		if slot4 then
			slot0._damageDict[slot1].showTotal = true
			slot0._damageDict[slot1].fromId = slot1.fromId

			TaskDispatcher.runDelay(slot0._showTotalFloat, slot0, 0.6)
		end
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entity and slot3.actType == FightEnum.ActType.SKILL then
		TaskDispatcher.cancelTask(slot0._showTotalFloat, slot0)

		if slot0._damageDict[slot3] then
			slot0._damageDict[slot3].showTotal = true
			slot0._damageDict[slot3].fromId = slot3.fromId
		end

		slot0:_showTotalFloat()
	end
end

slot1 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}
slot2 = {
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

function slot0._showTotalFloat(slot0)
	for slot4, slot5 in pairs(slot0._damageDict) do
		if slot5.showTotal and #slot5 > 1 then
			slot6 = false
			slot7 = 0

			for slot11, slot12 in ipairs(slot4.actEffectMOs) do
				if slot12.targetId == slot0.entity.id and FightTLEventDefHit.originHitEffectType[slot12.effectType] then
					slot6 = true
				end
			end

			for slot11, slot12 in ipairs(slot4.actEffectMOs) do
				if slot12.targetId == slot0.entity.id then
					if uv0[slot12.effectType] then
						slot7 = slot7 + slot12.effectNum
					elseif uv1[slot13] then
						for slot17, slot18 in ipairs(slot5) do
							slot7 = 0 + slot18
						end

						break
					end
				end
			end

			if slot7 > 0 then
				if slot0._fixedPos then
					-- Nothing
				end

				FightFloatMgr.instance:float(slot0.entity.id, slot6 and FightEnum.FloatType.total_origin or FightEnum.FloatType.total, slot7, {
					fromId = slot5.fromId,
					defenderId = slot0.entity.id,
					pos_x = slot0._fixedPos[1],
					pos_y = slot0._fixedPos[2]
				})
			end
		end

		if slot5.showTotal then
			slot0._damageDict[slot4] = nil
		end
	end
end

return slot0
