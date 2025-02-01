module("modules.logic.chessgame.model.ChessGameModel", package.seeall)

slot0 = class("ChessGameModel", BaseModel)

function slot0.ctor(slot0)
	slot0.nowMapResPath = nil
	slot0.nowMapIndex = 1
end

function slot0.clear(slot0)
	slot0.nowMapResPath = nil
	slot0.nowMapIndex = 1
	slot0._completedCount = 1
	slot0._optList = {}
	slot0._catchObj = nil
	slot0._finishInteract = nil
	slot0._operations = {}
	slot0._result = nil
	slot0._isPlayingStory = nil
	slot0._catchList = nil
	slot0._isTalking = nil
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0._optList = {}
	slot0.currentmapCo = ChessGameConfig.instance:getMapCo(ChessConfig.instance:getEpisodeCo(slot1, slot2).mapIds)

	slot0:setNowMapResPath(slot0.currentmapCo[slot3].path)
end

function slot0.setNowMapResPath(slot0, slot1)
	slot0.nowMapResPath = slot1
end

function slot0.getNowMapResPath(slot0)
	return slot0.nowMapResPath
end

function slot0.setNowMapIndex(slot0, slot1)
	slot0.nowMapIndex = slot1
end

function slot0.getNowMapIndex(slot0)
	return slot0.nowMapIndex
end

function slot0.addOperations(slot0, slot1)
	table.insert(slot0._operations, slot1)
end

function slot0.getOperations(slot0)
	return slot0._operations
end

function slot0.cleanOperations(slot0)
	for slot4, slot5 in pairs(slot0._operations) do
		slot0._operations[slot4] = nil
	end
end

function slot0.setResult(slot0, slot1)
	slot0._result = slot1
end

function slot0.onInit(slot0)
	slot0._mapTileMOList = {}
end

function slot0.appendOpt(slot0, slot1)
	table.insert(slot0._optList, slot1)
end

function slot0.getOptList(slot0)
	return slot0._optList
end

function slot0.cleanOptList(slot0)
	for slot4, slot5 in pairs(slot0._optList) do
		slot0._optList[slot4] = nil
	end
end

function slot0.setCompletedCount(slot0, slot1)
	slot0._completedCount = slot1
end

function slot0.getCompletedCount(slot0)
	return slot0._completedCount
end

function slot0.addRollBackNum(slot0)
	if not slot0._rollbackNum then
		slot0._rollbackNum = 0
	end

	slot0._rollbackNum = slot0._rollbackNum + 1
end

function slot0.clearRollbackNum(slot0)
	slot0._rollbackNum = 0
end

function slot0.getRollBackNum(slot0)
	return slot0._rollbackNum
end

function slot0.getRound(slot0)
	return slot0._round or 0
end

function slot0.addRound(slot0)
	slot0._round = slot0._round and slot0._round + 1 or 1
end

function slot0.clearRound(slot0)
	slot0._round = 0
end

function slot0.setGameState(slot0, slot1)
	slot0._gameState = slot1
end

function slot0.getGameState(slot0)
	return slot0._gameState
end

function slot0.setPlayingStory(slot0, slot1)
	slot0._isPlayingStory = slot1
end

function slot0.getPlayingStory(slot0)
	return slot0._isPlayingStory
end

function slot0.setCatchObj(slot0, slot1)
	slot0._catchObj = slot1
end

function slot0.getCatchObj(slot0)
	return slot0._catchObj
end

function slot0.insertCatchObjCanWalkList(slot0, slot1)
	slot0._catchList = slot0._catchList or {}

	table.insert(slot0._catchList, slot1)
end

function slot0.checkPosCatchObjCanWalk(slot0, slot1)
	if not slot0._catchList then
		return false
	end

	for slot5, slot6 in ipairs(slot0._catchList) do
		if slot1.x == slot6.x and slot1.y == slot6.y then
			return true
		end
	end

	return false
end

function slot0.cleanCatchObjCanWalkList(slot0)
	slot0._catchList = nil
end

function slot0.setTalk(slot0, slot1)
	slot0._isTalking = slot1
end

function slot0.isTalking(slot0)
	return slot0._isTalking
end

slot0.instance = slot0.New()

return slot0
