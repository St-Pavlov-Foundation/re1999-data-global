module("modules.logic.fight.entity.comp.skill.FightTLEventAtkSpineLookDir", package.seeall)

slot0 = class("FightTLEventAtkSpineLookDir")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot8 = FightHelper.getEntity(slot1.fromId).spine:getLookDir()

	for slot12, slot13 in ipairs(slot0._getEntitys(slot1, string.nilorempty(slot3[2]) and "1" or slot3[2])) do
		if slot3[3] == "1" then
			if slot13.spine then
				slot13.spine:changeLookDir(FightHelper.getEntitySpineLookDir(slot13:getMO()))
			end
		else
			slot15 = slot13.spine:getLookDir()

			if slot3[1] == "1" then
				slot15 = 1
			elseif slot3[1] == "2" then
				slot15 = -1
			elseif slot3[1] == "3" then
				slot15 = slot8
			elseif slot3[1] == "4" then
				slot15 = -slot8
			end

			if slot15 ~= slot14 then
				slot13.spine:changeLookDir(slot15)
			end
		end
	end
end

function slot0._getEntitys(slot0, slot1)
	slot4 = FightHelper.getEntity(slot0.toId)

	if slot1 == "1" then
		table.insert({}, FightHelper.getEntity(slot0.fromId))
	elseif slot1 == "2" then
		slot5 = {}

		for slot9, slot10 in ipairs(slot0.actEffectMOs) do
			if FightHelper.getEntity(slot10.targetId) and slot11:getSide() ~= slot3:getSide() and not slot5[slot10.targetId] then
				table.insert(slot2, slot11)

				slot5[slot10.targetId] = true
			end
		end
	elseif slot1 == "3" then
		slot2 = FightHelper.getSideEntitys(slot3:getSide(), false)
	elseif slot1 == "4" then
		slot2 = FightHelper.getSideEntitys(slot4:getSide(), false)
	elseif slot1 == "5" then
		tabletool.addValues(slot2, FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false))
		tabletool.addValues(slot2, FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false))
	elseif slot1 == "6" then
		table.insert(slot2, slot4)
	else
		table.insert(slot2, GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot0.stepUid .. "_" .. slot1))
	end

	return slot2
end

return slot0
