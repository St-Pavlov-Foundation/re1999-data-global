module("modules.logic.fight.entity.comp.skill.FightTLEventSetTimelineTime", package.seeall)

slot0 = class("FightTLEventSetTimelineTime")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot5 = tonumber(slot3[1])

	if FightDataHelper.entityMgr:getById(slot1.fromId) and #string.splitToNumber(slot3[2], "#") > 0 then
		for slot11, slot12 in ipairs(slot7) do
			slot17 = slot6

			for slot16, slot17 in pairs(slot6.getBuffDic(slot17)) do
				if slot17.buffId == slot12 then
					slot5 = false

					break
				end
			end

			if not slot5 then
				break
			end
		end
	end

	if slot5 then
		slot0._binder:SetTime(slot4)
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
