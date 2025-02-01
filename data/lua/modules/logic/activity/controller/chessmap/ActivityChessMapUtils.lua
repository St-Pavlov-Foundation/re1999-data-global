module("modules.logic.activity.controller.chessmap.ActivityChessMapUtils", package.seeall)

slot0 = class("ActivityChessMapUtils")

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

function slot0.getClearConditionDesc(slot0, slot1)
	return uv0.conditionDescFuncMap[slot0[1]] and slot3(slot0, slot1) or ""
end

function slot0.isClearConditionFinish(slot0, slot1)
	if uv0.conditionCheckMap[slot0[1]] then
		return slot3(slot0, slot1)
	end

	return false
end

function slot0.getConditionDescRoundLimit(slot0, slot1)
	return string.format(luaLang("chessgame_clear_round_limit"), slot0[2])
end

function slot0.getConditionDescInteractFinish(slot0, slot1)
	return Activity109Config.instance:getInteractObjectCo(slot1, slot0[2]) and string.format(luaLang("chessgame_clear_interact_finish"), slot2.name) or string.format(luaLang("chessgame_clear_interact_finish"), slot0[2])
end

slot0.conditionDescFuncMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = slot0.getConditionDescRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = slot0.getConditionDescInteractFinish
}

function slot0.checkRoundLimit(slot0, slot1)
	if not ActivityChessGameModel.instance:getResult() then
		return false
	else
		return ActivityChessGameModel.instance:getRound() <= slot0[2]
	end
end

function slot0.checkInteractFinish(slot0, slot1)
	if ActivityChessGameModel.instance:getResult() == false then
		return false
	end

	return ActivityChessGameModel.instance:isInteractFinish(slot0[2])
end

slot0.conditionCheckMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = slot0.checkRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = slot0.checkInteractFinish
}

return slot0
