module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRotate", package.seeall)

slot0 = class("FightTLEventEntityRotate")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if not slot0._attacker then
		return
	end

	slot4 = string.splitToNumber(slot3[1], ",")
	slot6 = slot3[3] == "1"
	slot7 = {}

	if slot3[2] == "1" then
		table.insert({}, FightHelper.getEntity(slot1.fromId))
	elseif slot5 == "2" then
		slot7 = FightHelper.getSkillTargetEntitys(slot1)
	elseif slot5 == "3" then
		slot7 = FightHelper.getSideEntitys(slot0._attacker:getSide(), true)
	elseif slot5 == "4" then
		if FightHelper.getEntity(slot1.toId) then
			slot7 = FightHelper.getSideEntitys(slot8:getSide(), true)
		end
	elseif slot5 == "5" then
		tabletool.removeValue(FightHelper.getSkillTargetEntitys(slot1), FightHelper.getEntity(slot1.fromId))
	end

	if not string.nilorempty(slot3[4]) then
		for slot12, slot13 in ipairs(string.split(slot3[4], "#")) do
			if FightHelper.getEntity(slot1.stepUid .. "_" .. slot13) then
				table.insert(slot7 or {}, slot14)
			end
		end
	end

	slot8 = slot4[3]

	if slot3[5] == "1" then
		slot8 = slot0._attacker:isEnemySide() and -slot4[3] or slot4[3]
	end

	for slot12, slot13 in ipairs(slot7) do
		if not gohelper.isNil(slot13.spine and slot13.spine:getSpineTr()) then
			if slot6 then
				transformhelper.setLocalRotation(slot14, slot4[1], slot4[2], slot8)
			else
				slot0._tweenIdList = slot0._tweenIdList or {}

				table.insert(slot0._tweenIdList, ZProj.TweenHelper.DOLocalRotate(slot14, slot4[1], slot4[2], slot8, slot2))
			end
		end
	end
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	if slot0._tweenIdList then
		for slot4, slot5 in ipairs(slot0._tweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end

		slot0._tweenIdList = nil
	end
end

return slot0
