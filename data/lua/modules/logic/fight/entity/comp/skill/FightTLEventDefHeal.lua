module("modules.logic.fight.entity.comp.skill.FightTLEventDefHeal", package.seeall)

slot0 = class("FightTLEventDefHeal")
slot1 = {
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.AVERAGELIFE] = true
}

function slot0.setContext(slot0, slot1)
	slot0._context = slot1
end

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._hasRatio = not string.nilorempty(slot3[1])
	slot0._ratio = tonumber(slot3[1]) or 0

	for slot7, slot8 in ipairs(slot1.actEffectMOs) do
		if FightHelper.getEntity(slot8.targetId) then
			if uv0[slot8.effectType] then
				slot0:_playDefHeal(slot9, slot8)
			end
		else
			logNormal("defender heal fail, entity not exist: " .. slot8.targetId)
		end
	end

	slot0:_buildSkillEffect(slot3[2])
	slot0:_playSkillBehavior()
end

function slot0._playDefHeal(slot0, slot1, slot2)
	if slot2.effectType == FightEnum.EffectType.HEAL or slot2.effectType == FightEnum.EffectType.HEALCRIT then
		FightDataHelper.playEffectData(slot2)

		slot3 = slot0:_calcNum(slot2.clientId, slot2.targetId, slot2.effectNum, slot0._ratio)

		if slot1.nameUI then
			slot1.nameUI:addHp(slot3)
		end

		FightFloatMgr.instance:float(slot2.targetId, slot2.effectType == FightEnum.EffectType.HEAL and FightEnum.FloatType.heal or FightEnum.FloatType.crit_heal, slot3)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, slot3)
	elseif slot2.effectType == FightEnum.EffectType.AVERAGELIFE and not slot2.hasDoAverageLiveEffect then
		FightDataHelper.playEffectData(slot2)

		slot2.hasDoAverageLiveEffect = true
		slot5 = slot2.effectNum - (slot1.nameUI and slot1.nameUI:getHp() or 0)

		if slot1.nameUI then
			slot1.nameUI:addHp(slot5)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, slot5)
	end

	FightController.instance:dispatchEvent(FightEvent.OnTimelineHeal, slot2)
end

function slot0._calcNum(slot0, slot1, slot2, slot3, slot4)
	if slot0._hasRatio then
		slot0._context.healFloatNum = slot0._context.healFloatNum or {}
		slot0._context.healFloatNum[slot2] = slot0._context.healFloatNum[slot2] or {}
		slot0._context.healFloatNum[slot2][slot1] = slot0._context.healFloatNum[slot2][slot1] or {}
		slot6 = slot0._context.healFloatNum[slot2][slot1].ratio or 0
		slot7 = slot5.total or 0
		slot9 = math.floor((slot4 + slot6 < 1 and slot8 or 1) * slot3) - slot7
		slot5.ratio = slot4 + slot6
		slot5.total = slot7 + slot9

		return slot9
	else
		return 0
	end
end

function slot0._buildSkillEffect(slot0, slot1)
	slot0._behaviorTypeDict = nil
	slot6 = "#"

	for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot1, slot6)) do
		if lua_skill_effect.configDict[slot7] then
			for slot12 = 1, FightEnum.MaxBehavior do
				slot14 = FightStrUtil.instance:getSplitToNumberCache(slot8["behavior" .. slot12], "#")

				if slot14 and #slot14 > 0 then
					slot0._behaviorTypeDict = slot0._behaviorTypeDict or {}
					slot0._behaviorTypeDict[slot14[1]] = true
				end
			end
		else
			logError("技能调用效果不存在" .. slot7)
		end
	end
end

function slot0._playSkillBehavior(slot0)
	if not slot0._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(slot0._fightStepMO, slot0._behaviorTypeDict, true)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
