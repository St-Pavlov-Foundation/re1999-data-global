module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceMO", package.seeall)

slot0 = class("WarChessPieceMO")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.id = slot1.id
	slot0.battle = slot1.battle
	slot0.teamType = slot1.teamType
	slot0.displacementState = slot1.displacementState

	if slot1.skill then
		slot0.skill = GameUtil.rpcInfosToList(slot1.skill, WarChessPieceSkillMO)
	end
end

function slot0.updatePower(slot0, slot1)
	slot0.battle = math.max(slot0.battle + slot1, 0)
end

function slot0.updateDisplacementState(slot0, slot1)
	slot0.displacementState = slot1
end

function slot0.canActiveMove(slot0)
	if slot0.displacementState then
		slot1 = EliminateLevelModel.instance:getRoundNumber()
		slot2 = slot0.displacementState.totalUseCountLimit
		slot3 = slot0.displacementState.totalUseCount
		slot4 = slot0.displacementState.effectRound
		slot5 = 0

		if slot0.displacementState.roundUseCount then
			for slot9, slot10 in ipairs(slot0.displacementState.roundUseCount) do
				if slot10.round == slot1 then
					slot5 = slot10.count
				end
			end
		end

		if slot4 <= slot1 and slot5 < slot0.displacementState.perRoundUseCountLimit and slot3 < slot2 then
			return true
		end
	end

	return false
end

function slot0.getDisplacementState(slot0)
	return slot0.displacementState
end

function slot0.updateSkillGrowUp(slot0, slot1, slot2)
	if slot0.skill == nil then
		return false
	end

	for slot6 = 1, #slot0.skill do
		if slot0.skill[slot6].id == slot1 then
			slot7:updateSkillGrowUp(slot2)

			return true
		end
	end

	return false
end

function slot0.getSkill(slot0, slot1)
	if slot0.skill == nil then
		return nil
	end

	for slot5 = 1, #slot0.skill do
		if slot0.skill[slot5].id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.getActiveSkill(slot0)
	if slot0.skill ~= nil and #slot0.skill > 0 then
		return slot0.skill[1]
	end
end

function slot0.diffData(slot0, slot1)
	slot2 = true

	if slot0.battle ~= slot1.battle then
		slot2 = false
	end

	if slot0.teamType ~= slot1.teamType then
		slot2 = false
	end

	if slot0.uid ~= slot1.uid then
		slot2 = false
	end

	if slot0.id ~= slot1.id then
		slot2 = false
	end

	return slot2
end

return slot0
