module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStrongholdMO", package.seeall)

slot0 = class("WarChessStrongholdMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.mySidePiece = {}
	slot0.enemySidePiece = {}

	slot0:updateInfo(slot1)
end

function slot0.updateInfo(slot0, slot1)
	slot0.myScore = slot1.myScore or 0
	slot0.enemyScore = slot1.enemyScore or 0
	slot0.status = slot1.status

	if slot1.mySidePiece then
		slot0.mySidePiece = GameUtil.rpcInfosToList(slot1.mySidePiece, WarChessPieceMO)
	end

	if slot1.enemySidePiece then
		slot0.enemySidePiece = GameUtil.rpcInfosToList(slot1.enemySidePiece, WarChessPieceMO)
	end
end

function slot0.updatePiece(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot3 = WarChessPieceMO.New()

		slot3:init(slot2)
		table.insert(slot0.enemySidePiece, slot3)

		return #slot0.enemySidePiece
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot3 = WarChessPieceMO.New()

		slot3:init(slot2)
		table.insert(slot0.mySidePiece, slot3)

		return #slot0.mySidePiece
	end
end

function slot0.addTempPiece(slot0, slot1, slot2)
	slot4 = WarChessPieceMO.New()
	slot4.id = slot2
	slot4.teamType = slot1
	slot4.battle = EliminateConfig.instance:getSoldierChessConfig(slot2).defaultPower
	slot4.uid = EliminateTeamChessEnum.tempPieceUid

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		table.insert(slot0.enemySidePiece, slot4)

		return slot4, #slot0.enemySidePiece
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		table.insert(slot0.mySidePiece, slot4)

		return slot4, #slot0.mySidePiece
	end
end

function slot0.updateChessPower(slot0, slot1, slot2)
	if slot0.mySidePiece then
		for slot6 = 1, #slot0.mySidePiece do
			if slot0.mySidePiece[slot6].uid == slot1 then
				slot7:updatePower(slot2)

				return true
			end
		end
	end

	if slot0.enemySidePiece then
		for slot6 = 1, #slot0.enemySidePiece do
			if slot0.enemySidePiece[slot6].uid == slot1 then
				slot7:updatePower(slot2)

				return true
			end
		end
	end

	return false
end

function slot0.updateSkillGrowUp(slot0, slot1, slot2, slot3)
	if slot0.mySidePiece then
		for slot7 = 1, #slot0.mySidePiece do
			if slot0.mySidePiece[slot7].uid == slot1 and slot8:updateSkillGrowUp(slot2, slot3) then
				return true
			end
		end
	end

	if slot0.enemySidePiece then
		for slot7 = 1, #slot0.enemySidePiece do
			if slot0.enemySidePiece[slot7].uid == slot1 and slot8:updateSkillGrowUp(slot2, slot3) then
				return true
			end
		end
	end

	return false
end

function slot0.updateDisplacementState(slot0, slot1, slot2)
	if slot0.mySidePiece then
		for slot6 = 1, #slot0.mySidePiece do
			if slot0.mySidePiece[slot6].uid == slot1 then
				slot7:updateDisplacementState(slot2)

				return true
			end
		end
	end

	if slot0.enemySidePiece then
		for slot6 = 1, #slot0.enemySidePiece do
			if slot0.enemySidePiece[slot6].uid == slot1 then
				slot7:updateDisplacementState(slot2)

				return true
			end
		end
	end

	return false
end

function slot0.updateScore(slot0, slot1, slot2)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot0.myScore = math.max(slot0.myScore + slot2, 0)
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot0.enemyScore = math.max(slot0.enemyScore + slot2, 0)
	end
end

function slot0.updateStatus(slot0, slot1)
	slot0.status = slot1
end

function slot0.getChess(slot0, slot1)
	for slot5 = 1, #slot0.mySidePiece do
		if slot0.mySidePiece[slot5].uid == slot1 then
			return slot6
		end
	end

	for slot5 = 1, #slot0.enemySidePiece do
		if slot0.enemySidePiece[slot5].uid == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.removeChess(slot0, slot1)
	for slot5 = 1, #slot0.mySidePiece do
		if slot0.mySidePiece[slot5].uid == slot1 then
			table.remove(slot0.mySidePiece, slot5)

			return
		end
	end

	for slot5 = 1, #slot0.enemySidePiece do
		if slot0.enemySidePiece[slot5].uid == slot1 then
			table.remove(slot0.enemySidePiece, slot5)

			return
		end
	end
end

function slot0.getPlayerSoliderCount(slot0)
	return slot0.mySidePiece and #slot0.mySidePiece or 0
end

function slot0.getEnemySoliderCount(slot0)
	return slot0.enemySidePiece and #slot0.enemySidePiece or 0
end

function slot0.isFull(slot0, slot1)
	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		return slot0:getStrongholdConfig().friendCapacity == #slot0.mySidePiece
	end

	if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		return slot2.enemyCapacity == #slot0.enemySidePiece
	end
end

function slot0.diffData(slot0, slot1)
	slot2 = true

	if slot0.id ~= slot1.id then
		slot2 = false
	end

	if slot0.myScore ~= slot1.myScore then
		slot2 = false
	end

	if slot0.enemyScore ~= slot1.enemyScore then
		slot2 = false
	end

	if slot0.status ~= slot1.status then
		slot2 = false
	end

	if slot0.mySidePiece and slot1.mySidePiece then
		for slot6 = 1, #slot0.mySidePiece do
			if not slot0.mySidePiece[slot6]:diffData(slot1.mySidePiece[slot6]) then
				slot2 = false
			end
		end
	end

	if slot0.enemySidePiece and slot1.enemySidePiece then
		for slot6 = 1, #slot0.enemySidePiece do
			if not slot0.enemySidePiece[slot6]:diffData(slot1.enemySidePiece[slot6]) then
				slot2 = false
			end
		end
	end

	return slot2
end

function slot0.getStrongholdConfig(slot0)
	if slot0.config == nil then
		slot0.config = EliminateConfig.instance:getStrongHoldConfig(slot0.id)
	end

	return slot0.config
end

function slot0.getMySideIndexByUid(slot0, slot1)
	if slot0.mySidePiece then
		for slot5 = 1, #slot0.mySidePiece do
			if slot0.mySidePiece[slot5].uid == slot1 then
				return slot5
			end
		end
	end

	return -1
end

function slot0.getEnemySideIndexByUid(slot0, slot1)
	if slot0.enemySidePiece then
		for slot5 = 1, #slot0.enemySidePiece do
			if slot0.enemySidePiece[slot5].uid == slot1 then
				return slot5
			end
		end
	end

	return -1
end

function slot0.getEnemySideByUid(slot0, slot1)
	if slot0.enemySidePiece then
		for slot5 = 1, #slot0.enemySidePiece do
			if slot0.enemySidePiece[slot5].uid == slot1 then
				return slot6
			end
		end
	end

	return nil
end

function slot0.getMySideByUid(slot0, slot1)
	if slot0.mySidePiece then
		for slot5 = 1, #slot0.mySidePiece do
			if slot0.mySidePiece[slot5].uid == slot1 then
				return slot6
			end
		end
	end

	return nil
end

return slot0
