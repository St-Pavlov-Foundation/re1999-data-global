module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTeamChessWarMO", package.seeall)

slot0 = class("EliminateTeamChessWarMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.myCharacter = WarChessCharacterMO.New()
	slot0.enemyCharacter = WarChessCharacterMO.New()
	slot0.strongholds = {}
	slot0.winCondition = slot1.winCondition
	slot0.extraWinCondition = slot1.extraWinCondition

	slot0.myCharacter:init(slot1.myCharacter)
	slot0.enemyCharacter:init(slot1.enemyCharacter)
	slot0:updateInfo(slot1)
end

function slot0.updateInfo(slot0, slot1)
	slot0.round = slot1.round

	slot0.myCharacter:updateInfo(slot1.myCharacter)
	slot0.enemyCharacter:updateInfo(slot1.enemyCharacter)

	if slot1.stronghold then
		tabletool.clear(slot0.strongholds)

		slot0.strongholds = GameUtil.rpcInfosToList(slot1.stronghold, WarChessStrongholdMO)

		table.sort(slot0.strongholds, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end

	slot0.winCondition = slot1.winCondition
	slot0.extraWinCondition = slot1.extraWinCondition

	slot0:updateStar()
end

function slot0.updateCondition(slot0, slot1, slot2)
	slot0.winCondition = slot1
	slot0.extraWinCondition = slot2

	slot0:updateStar()

	return slot0.winCondition ~= slot1 or slot0.extraWinCondition ~= slot2
end

function slot0.updateStar(slot0)
	if slot0:winConditionIsFinish() then
		slot1 = 0 + 1
	end

	if slot0:extraWinConditionIsFinish() then
		slot1 = slot1 + 1
	end

	EliminateLevelModel.instance:setStar(slot1)
end

function slot0.updateForecastBehavior(slot0, slot1)
	slot0.enemyCharacter:updateForecastBehavior(slot1)
end

function slot0.getSlotIds(slot0)
	return slot0.myCharacter.slotIds
end

function slot0.getStrongholds(slot0)
	return slot0.strongholds
end

function slot0.getStronghold(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.strongholds) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.updateChessPower(slot0, slot1, slot2)
	if slot0.strongholds then
		for slot6 = 1, #slot0.strongholds do
			if slot0.strongholds[slot6]:updateChessPower(slot1, slot2) then
				return
			end
		end
	end
end

function slot0.updateSkillGrowUp(slot0, slot1, slot2, slot3)
	if slot0.strongholds then
		for slot7 = 1, #slot0.strongholds do
			if slot0.strongholds[slot7]:updateSkillGrowUp(slot1, slot2, slot3) then
				return
			end
		end
	end
end

function slot0.updateDisplacementState(slot0, slot1, slot2)
	if slot0.strongholds then
		for slot6 = 1, #slot0.strongholds do
			if slot0.strongholds[slot6]:updateDisplacementState(slot1, slot2) then
				return
			end
		end
	end
end

function slot0.updateStrongholdsScore(slot0, slot1, slot2, slot3)
	if slot0.strongholds then
		for slot7 = 1, #slot0.strongholds do
			if slot0.strongholds[slot7].id == slot1 then
				slot8:updateScore(slot2, slot3)

				return
			end
		end
	end
end

function slot0.updateMainCharacterHp(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot0.myCharacter:updateHp(slot2)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot0.enemyCharacter:updateHp(slot2)
	end
end

function slot0.updateMainCharacterPower(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot0.myCharacter:updatePower(slot2)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot0.enemyCharacter:updatePower(slot2)
	end
end

function slot0.updateResourceData(slot0, slot1, slot2)
	if slot0.myCharacter then
		slot0.myCharacter:updateDiamondInfo(slot1, slot2)
	end
end

function slot0.removeStrongholdChess(slot0, slot1, slot2)
	if slot0.strongholds then
		for slot6 = 1, #slot0.strongholds do
			if slot0.strongholds[slot6].id == slot1 then
				slot7:removeChess(slot2)

				return
			end
		end
	end
end

function slot0.getChess(slot0, slot1)
	if slot0.strongholds then
		for slot5 = 1, #slot0.strongholds do
			if slot0.strongholds[slot5]:getChess(slot1) then
				return slot7
			end
		end
	end

	return nil
end

function slot0.strongHoldSettle(slot0, slot1, slot2)
	if slot0.strongholds then
		for slot6 = 1, #slot0.strongholds do
			if slot0.strongholds[slot6].id == slot1 then
				slot7:updateStatus(slot2)

				return
			end
		end
	end
end

function slot0.diamondsIsEnough(slot0, slot1, slot2)
	if not slot0.myCharacter then
		return false
	end

	return slot0.myCharacter:diamondsIsEnough(slot1, slot2)
end

function slot0.winConditionIsFinish(slot0)
	return slot0.winCondition == 1
end

function slot0.extraWinConditionIsFinish(slot0)
	return slot0.extraWinCondition == 1
end

function slot0.diffTeamChess(slot0, slot1)
	slot2 = true

	if slot0.id ~= slot1.id then
		slot2 = false
	end

	if not slot0.myCharacter:diffData(slot1.myCharacter) then
		slot2 = false
	end

	if not slot0.enemyCharacter:diffData(slot1.enemyCharacter) then
		slot2 = false
	end

	if #slot0.strongholds ~= #slot1.strongholds then
		slot2 = false
	end

	if slot0.round ~= slot1.round then
		slot2 = false
	end

	for slot6 = 1, #slot0.strongholds do
		slot7 = slot0.strongholds[slot6]

		if not slot7:diffData(slot1:getStronghold(slot7.id)) then
			slot2 = false
		end
	end

	return slot2
end

return slot0
