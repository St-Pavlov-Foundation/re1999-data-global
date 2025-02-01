module("modules.logic.chessgame.controller.ChessGameHelper", package.seeall)

slot0 = class("ChessGameHelper")

function slot0.isNodeWalkable(slot0, slot1, slot2)
	if not ChessGameNodeModel.instance:getNode(slot0, slot1) then
		return false
	end

	return slot3:isCanWalk(slot2)
end

function slot0.nodePosToWorldPos(slot0)
	slot1 = Vector3.New()
	slot1.x = (slot0.x + slot0.y) * ChessGameEnum.NodeXOffset
	slot1.y = (slot0.y - slot0.x) * ChessGameEnum.NodeYOffset
	slot1.z = (slot0.y - slot0.x) * ChessGameEnum.NodeZOffset

	return slot1
end

function slot0.worldPosToNodePos(slot0)
	slot1 = Vector3.New()
	slot2 = slot0.x / ChessGameEnum.NodeXOffset
	slot3 = slot0.y / ChessGameEnum.NodeYOffset
	slot1.x = Mathf.Round((slot2 - slot3) / 2)
	slot1.y = Mathf.Round((slot2 + slot3) / 2)

	return slot1
end

function slot0.getMap()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.ChessGame then
		return
	end

	return GameSceneMgr.instance:getCurScene().map
end

slot1 = 8

function slot0.ToDirection(slot0, slot1, slot2, slot3)
	if slot2 < slot0 then
		if slot3 < slot1 then
			return 1
		elseif slot1 < slot3 then
			return 7
		else
			return 4
		end
	elseif slot0 < slot2 then
		if slot3 < slot1 then
			return 3
		elseif slot1 < slot3 then
			return 9
		else
			return 6
		end
	elseif slot3 < slot1 then
		return 2
	elseif slot1 < slot3 then
		return 8
	else
		return 5
	end
end

function slot0.CalNextCellPos(slot0, slot1, slot2)
	if slot2 == 2 then
		return slot0, slot1 - 1
	elseif slot2 == 8 then
		return slot0, slot1 + 1
	elseif slot2 == 6 then
		return slot0 + 1, slot1
	elseif slot2 == 4 then
		return slot0 - 1, slot1
	end
end

function slot0.CalOppositeDir(slot0)
	if slot0 == 2 then
		return 8
	elseif slot0 == 8 then
		return 2
	elseif slot0 == 6 then
		return 4
	elseif slot0 == 4 then
		return 6
	end
end

function slot0.IsEdgeTile(slot0, slot1)
	return slot1 == uv0 - 1
end

function slot0.getClearConditionDesc(slot0, slot1)
	return uv0.conditionDescFuncMap[slot0[1]] and slot3(slot0, slot1) or ""
end

function slot0.isClearConditionFinish(slot0, slot1)
	if uv0.conditionCheckMap[slot0[1]] then
		return slot3(slot0, slot1)
	end

	return false
end

function slot0.calPosIndex(slot0, slot1)
	return slot0 + slot1 * uv0
end

function slot0.calPosXY(slot0)
	return slot0 % uv0, math.floor(slot0 / uv0)
end

function slot0.getConditionDescRoundLimit(slot0, slot1)
	return string.format(luaLang("chessgame_clear_round_limit"), slot0[2])
end

function slot0.getConditionDescInteractFinish(slot0, slot1)
	return ChessGameConfig.instance:getInteractObjectCo(slot1, slot0[2]) and string.format(luaLang("chessgame_clear_interact_finish"), slot2.name) or string.format(luaLang("chessgame_clear_interact_finish"), slot0[2])
end

function slot0.checkRoundLimit(slot0, slot1)
	if not ChessGameModel.instance:getResult() then
		return false
	else
		return ChessGameModel.instance:getRound() <= slot0[2]
	end
end

function slot0.checkInteractFinish(slot0, slot1)
	for slot5 = 2, #slot0 do
		if not ChessGameInteractModel.instance:checkInteractFinish(slot0[slot5]) then
			return false
		end
	end

	return #slot0 > 1
end

function slot0.checkHpLimit(slot0, slot1)
	return slot0[2] <= ChessGameModel.instance:getHp()
end

function slot0.checkAllInteractFinish(slot0, slot1)
	if ChessGameModel.instance:getResult() == false then
		return false
	end

	for slot7 = 2, #slot0 do
		if not ChessGameModel.instance:isInteractFinish(slot0[slot7]) then
			slot3 = 0 + 1
		end
	end

	if slot3 > 0 then
		return false, slot3
	else
		return true
	end
end

function slot0.calBulletFlyTime(slot0, slot1, slot2, slot3, slot4)
	slot5 = ChessGameEnum.DEFAULT_BULLET_FLY_TIME

	if slot1 and slot2 and slot3 and slot4 then
		slot5 = math.sqrt(math.pow(slot3 - slot1, 2) + math.pow(slot4 - slot2, 2)) / (slot0 or ChessGameEnum.DEFAULT_BULLET_SPEED)
	end

	return slot5
end

slot0.conditionCheckMap = {
	[ChessGameEnum.ChessClearCondition.InteractFinish] = slot0.checkInteractFinish,
	[ChessGameEnum.ChessClearCondition.InteractAllFinish] = slot0.checkAllInteractFinish
}

return slot0
