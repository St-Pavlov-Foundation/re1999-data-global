module("modules.logic.fight.system.work.FightWorkExSkillPointChange", package.seeall)

slot0 = class("FightWorkExSkillPointChange", FightEffectBase)

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		logError("EXSKILLPOINTCHANGE fail, entity not exist: " .. slot1)
		slot0:_onDone()

		return
	end

	if slot2:getMO() then
		slot3:changeServerUniqueCost(slot0._actEffectMO.effectNum)

		if slot3:getUniqueSkillPoint() ~= slot3:getUniqueSkillPoint() then
			FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, slot0._actEffectMO.targetId, slot4, slot5)
		end
	end

	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
