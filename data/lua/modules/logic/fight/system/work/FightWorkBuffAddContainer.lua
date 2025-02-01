module("modules.logic.fight.system.work.FightWorkBuffAddContainer", package.seeall)

slot0 = class("FightWorkBuffAddContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.BUFFADD] = true
}
slot2 = 0.15
slot3 = 0.05

function slot0.onStart(slot0)
	slot2 = slot0:com_registWorkDoneFlowParallel()
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:getAdjacentSameEffectList(uv0, true)) do
		if slot8.effect.buff then
			slot11 = lua_skill_buff.configDict[slot10.buffId]

			if slot11 and lua_skill_bufftype.configDict[slot11.typeId] then
				if not slot3[slot9.targetId] then
					slot3[slot9.targetId] = {}
				end

				table.insert(slot13, slot8)
			end
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		for slot13, slot14 in ipairs(slot9) do
			slot15 = slot14.stepMO
			slot16 = slot14.effect
			slot19 = lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot16.buff.buffId].typeId]

			if not slot4[slot16.targetId] then
				slot4[slot16.targetId] = slot2:registWork(FightWorkFlowSequence)
			end

			if slot18.isNoShow == 1 then
				slot20:registWork(FightWorkStepBuff, slot15, slot16)
			elseif slot19.skipDelay == 1 then
				slot20:registWork(FightWorkStepBuff, slot15, slot16)
			elseif lua_fight_stacked_buff_combine.configDict[slot18.id] then
				if slot9[slot13 + 1] and slot21.buff and slot21.buff.buffId == slot17 then
					slot20:registWork(FightWorkFunction, slot0._lockEntityBuffFloat, slot0, {
						true,
						entityId = slot16.targetId
					})
				else
					slot20:registWork(FightWorkFunction, slot0._lockEntityBuffFloat, slot0, {
						false,
						entityId = slot16.targetId
					})
				end

				slot20:registWork(FightWorkStepBuff, slot15, slot16)
			elseif slot18.effect ~= "0" and not string.nilorempty(slot18.effect) then
				slot20:registWork(FightWorkStepBuff, slot15, slot16)
				slot20:registWork(FightWorkDelayTimer, uv1 / FightModel.instance:getSpeed())
			else
				slot20:registWork(FightWorkStepBuff, slot15, slot16)
				slot20:registWork(FightWorkDelayTimer, uv2 / FightModel.instance:getSpeed())
			end
		end
	end

	slot2:start()
end

function slot0._lockEntityBuffFloat(slot0, slot1)
	if FightHelper.getEntity(slot1.entityId) and slot2.buff then
		slot2.buff.lockFloat = slot1.state
	end
end

function slot0.clearWork(slot0)
end

return slot0
