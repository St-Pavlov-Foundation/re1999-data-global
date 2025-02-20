module("modules.logic.fight.entity.comp.skill.FightTLEventDefFreeze", package.seeall)

slot0 = class("FightTLEventDefFreeze")
slot1 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.BUFFADD] = true,
	[FightEnum.EffectType.BUFFUPDATE] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot4 = slot2 * FightModel.instance:getSpeed()
	slot0._action = slot3[1]
	slot5 = tonumber(slot3[2]) or 0
	slot0._defenders = slot0:_getDefenders(slot1, slot3[3])

	if not string.nilorempty(slot0._action) then
		for slot9, slot10 in ipairs(slot0._defenders) do
			slot10.spine:play(slot0._action, false, true)
		end
	end

	if slot5 < slot4 then
		if slot5 == 0 then
			slot0:_startFreeze()
		else
			TaskDispatcher.runDelay(slot0._startFreeze, slot0, slot5 / FightModel.instance:getSpeed())
		end
	else
		logWarn("Skill Freeze param invalid, startTime >= duration")
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_onDurationEnd()
end

function slot0._getDefenders(slot0, slot1, slot2)
	slot3 = 2
	slot4 = {}

	if not string.nilorempty(slot2) then
		slot3 = tonumber(string.split(slot2, "#")[1])
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot1.actEffectMOs) do
		if uv0[slot10.effectType] then
			if slot3 == 1 then
				slot11 = FightHelper.getEntity(slot1.fromId)
				slot4[slot11.id] = slot11
			elseif slot3 == 2 then
				if FightHelper.getEntity(slot1.fromId):getSide() ~= FightHelper.getEntity(slot10.targetId):getSide() then
					slot4[slot12.id] = slot12
				end
			elseif slot3 == 3 then
				slot11 = FightHelper.getEntity(slot1.fromId)
				slot16 = slot11

				for slot16, slot17 in ipairs(FightHelper.getSideEntitys(slot11.getSide(slot16))) do
					slot4[slot17.id] = slot17
				end
			elseif slot3 == 4 then
				slot11 = FightHelper.getEntity(slot1.toId)
				slot16 = slot11

				for slot16, slot17 in ipairs(FightHelper.getSideEntitys(slot11.getSide(slot16))) do
					slot4[slot17.id] = slot17
				end
			elseif slot3 == 5 then
				for slot15, slot16 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)) do
					slot4[slot16.id] = slot16
				end

				for slot15, slot16 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
					slot4[slot16.id] = slot16
				end
			elseif slot3 == 6 then
				slot11 = FightHelper.getEntity(slot1.toId)
				slot4[slot11.id] = slot11
			elseif slot3 == 7 then
				for slot15 = 2, #string.splitToNumber(slot2, "#") do
					slot16 = FightHelper.getEntity(slot11[slot15])
					slot4[slot16.id] = slot16
				end
			end
		end
	end

	for slot9, slot10 in pairs(slot4) do
		table.insert(slot5, slot10)
	end

	return slot5
end

function slot0._startFreeze(slot0)
	for slot4, slot5 in ipairs(slot0._defenders) do
		slot5.spine:setFreeze(true)
	end
end

function slot0._onDurationEnd(slot0)
	for slot4, slot5 in ipairs(slot0._defenders) do
		if slot5.spine:getAnimState() == slot0._action then
			slot5:resetAnimState()
		end
	end

	slot0:reset()
end

function slot0.reset(slot0)
	if slot0._defenders then
		for slot4, slot5 in ipairs(slot0._defenders) do
			slot5.spine:setFreeze(false)
		end
	end

	slot0._defenders = nil

	TaskDispatcher.cancelTask(slot0._startFreeze, slot0)
end

function slot0.dispose(slot0)
	slot0:reset()
end

return slot0
