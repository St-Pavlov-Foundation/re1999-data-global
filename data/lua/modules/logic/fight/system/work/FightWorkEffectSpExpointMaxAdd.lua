module("modules.logic.fight.system.work.FightWorkEffectSpExpointMaxAdd", package.seeall)

slot0 = class("FightWorkEffectSpExpointMaxAdd", FightEffectBase)

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if not slot2:getMO() then
		slot0:onDone(true)

		return
	end

	if not slot3:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		slot0:onDone(true)

		return
	end

	slot4 = string.splitToNumber(slot0._actEffectMO.reserveStr, "#")

	slot3:changeExpointMaxAdd(slot4[1] - slot3:getExpointMaxAddNum())
	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, slot1, slot0._actEffectMO.effectNum)
	slot3:changeServerUniqueCost(slot4[2] - slot3:getExpointCostOffsetNum())
	FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, slot1, slot3:getUniqueSkillPoint(), slot3:getUniqueSkillPoint())
	slot0:onDone(true)
end

return slot0
