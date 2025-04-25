module("modules.logic.versionactivity2_5.autochess.model.AutoChessGameModel", package.seeall)

slot0 = class("AutoChessGameModel", BaseModel)

function slot0.initTileNodes(slot0, slot1)
	slot0.viewType = slot1
	slot0.tileNodes = {}
	slot3 = nil
	slot3 = slot1 == AutoChessEnum.ViewType.All and AutoChessEnum.BoardSize.Column * 2 or AutoChessEnum.BoardSize.Column
	slot4 = AutoChessEnum.TileOffsetX[slot1]

	for slot8 = 1, AutoChessEnum.BoardSize.Row do
		slot10 = AutoChessEnum.TileStartPos[slot1][slot8]
		slot0.tileNodes[slot8] = slot0.tileNodes[slot8] or {}

		for slot14 = 1, slot3 do
			slot0.tileNodes[slot8][slot14] = Vector2(slot10.x + (slot14 - 1) * (AutoChessEnum.TileSize[slot1][slot8].x + slot4), slot10.y)
		end
	end

	return slot0.tileNodes
end

function slot0.getNearestTileXY(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.tileNodes) do
		slot8 = AutoChessEnum.TileSize[slot0.viewType][slot6]

		for slot12, slot13 in ipairs(slot7) do
			if math.abs(slot1 - slot13.x) < slot8.x / 2 and math.abs(slot2 - slot13.y) < slot8.y / 2 then
				return slot6, slot12
			end
		end
	end
end

function slot0.getChessLocation(slot0, slot1, slot2)
	return slot0.tileNodes[slot1][slot2] or slot3[slot2 - 5]
end

function slot0.getNearestLeader(slot0, slot1)
	if slot0.viewType == AutoChessEnum.ViewType.Player then
		slot2 = slot0:getLeaderLocation(AutoChessEnum.TeamType.Player)

		if math.abs(slot1.x - slot2.x) < 55 and math.abs(slot1.y - slot2.y) < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.mySideMaster
		end
	elseif slot0.viewType == AutoChessEnum.ViewType.Enemy then
		slot2 = slot0:getLeaderLocation(AutoChessEnum.TeamType.Enemy)

		if math.abs(slot1.x - slot2.x) < 55 and math.abs(slot1.y - slot2.y) < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.enemyMaster
		end
	end
end

function slot0.getLeaderLocation(slot0, slot1)
	return AutoChessEnum.LeaderPos[slot0.viewType][slot1]
end

function slot0.setChessAvatar(slot0, slot1)
	slot0.avatar = slot1
end

slot0.instance = slot0.New()

return slot0
