module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessMapUtils", package.seeall)

slot0 = class("Va3ChessMapUtils")
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
	return Va3ChessConfig.instance:getInteractObjectCo(slot1, slot0[2]) and string.format(luaLang("chessgame_clear_interact_finish"), slot2.name) or string.format(luaLang("chessgame_clear_interact_finish"), slot0[2])
end

slot0.conditionDescFuncMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = slot0.getConditionDescRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = slot0.getConditionDescInteractFinish
}

function slot0.checkRoundLimit(slot0, slot1)
	if not Va3ChessGameModel.instance:getResult() then
		return false
	else
		return Va3ChessGameModel.instance:getRound() <= slot0[2]
	end
end

function slot0.checkInteractFinish(slot0, slot1)
	if slot1 == VersionActivity1_3Enum.ActivityId.Act304 then
		return Va3ChessGameModel.instance:isInteractFinish(slot0[2], true)
	end

	for slot5 = 2, #slot0 do
		if not Va3ChessGameModel.instance:isInteractFinish(slot0[slot5]) then
			return false
		end
	end

	return #slot0 > 1
end

function slot0.checkHpLimit(slot0, slot1)
	return slot0[2] <= Va3ChessGameModel.instance:getHp()
end

function slot0.checkAllInteractFinish(slot0, slot1)
	if Va3ChessGameModel.instance:getResult() == false then
		return false
	end

	for slot7 = 2, #slot0 do
		if not Va3ChessGameModel.instance:isInteractFinish(slot0[slot7]) then
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
	slot5 = Va3ChessEnum.DEFAULT_BULLET_FLY_TIME

	if slot1 and slot2 and slot3 and slot4 then
		slot5 = math.sqrt(math.pow(slot3 - slot1, 2) + math.pow(slot4 - slot2, 2)) / (slot0 or Va3ChessEnum.DEFAULT_BULLET_SPEED)
	end

	return slot5
end

slot0.conditionCheckMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = slot0.checkRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = slot0.checkInteractFinish,
	[Va3ChessEnum.ChessClearCondition.HpLimit] = slot0.checkHpLimit,
	[Va3ChessEnum.ChessClearCondition.InteractAllFinish] = slot0.checkAllInteractFinish
}

return slot0
