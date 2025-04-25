module("modules.logic.fight.entity.comp.skill.FightTLEventSetTimelineTime", package.seeall)

slot0 = class("FightTLEventSetTimelineTime")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot5 = tonumber(slot3[1])

	if FightDataHelper.entityMgr:getById(slot1.fromId) and #string.splitToNumber(slot3[2], "#") > 0 then
		for slot11, slot12 in ipairs(slot7) do
			for slot16, slot17 in pairs(slot6:getBuffDic()) do
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

	if not string.nilorempty(slot3[3]) then
		slot8 = false

		for slot12, slot13 in ipairs(string.splitToNumber(slot3[3], "#")) do
			if slot13 == slot1.actId then
				slot8 = true
			end
		end

		if not slot8 then
			slot5 = false
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
