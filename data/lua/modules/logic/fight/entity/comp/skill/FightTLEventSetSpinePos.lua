module("modules.logic.fight.entity.comp.skill.FightTLEventSetSpinePos", package.seeall)

slot0 = class("FightTLEventSetSpinePos")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot5 = nil

	if slot3[1] == "1" then
		table.insert({}, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot5 = FightHelper.getSkillTargetEntitys(slot1)
	elseif slot4 == "3" then
		slot5 = FightHelper.getSideEntitys(FightHelper.getEntity(slot1.fromId):getSide(), true)
	elseif slot4 == "4" then
		slot5 = FightHelper.getSideEntitys(FightHelper.getEntity(slot1.toId):getSide(), true)
	elseif slot4 == "5" then
		for slot10, slot11 in ipairs(FightHelper.getSideEntitys(FightHelper.getEntity(slot1.fromId):getSide(), true)) do
			if slot11.id == slot1.fromId then
				table.remove(slot5, slot10)

				break
			end
		end
	end

	if not string.nilorempty(slot3[4]) then
		for slot11, slot12 in pairs(GameSceneMgr.instance:getCurScene().deadEntityMgr._entityDic) do
			if slot12:getMO() and tabletool.indexOf(string.splitToNumber(slot3[4], "#"), slot13.skin) then
				table.insert({}, slot12)
			end
		end
	end

	slot6 = string.splitToNumber(slot3[2], "#")
	slot7 = slot3[3] == "1"

	if #slot5 > 0 then
		for slot11, slot12 in ipairs(slot5) do
			if slot12.spine and slot13:getSpineTr() then
				if slot7 then
					transformhelper.setLocalPos(slot14, 0, 0, 0)
				else
					transformhelper.setLocalPos(slot14, slot6[1] or 0, slot6[2] or 0, slot6[3] or 0)
				end
			end
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
