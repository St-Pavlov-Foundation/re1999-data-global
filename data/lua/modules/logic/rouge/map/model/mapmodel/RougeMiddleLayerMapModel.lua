module("modules.logic.rouge.map.model.mapmodel.RougeMiddleLayerMapModel", package.seeall)

slot0 = class("RougeMiddleLayerMapModel")

function slot0.initMap(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.layerCo = lua_rouge_layer.configDict[slot0.layerId]
	slot0.middleLayerId = slot1.middleLayerId
	slot0.middleCo = lua_rouge_middle_layer.configDict[slot0.middleLayerId]
	slot0.curPosIndex = slot1.positionIndex

	slot0:initPieceInfo(slot1.pieceInfo)
end

function slot0.updateMapInfo(slot0, slot1)
	slot0.curPosIndex = slot1.positionIndex

	for slot5, slot6 in ipairs(slot1.pieceInfo) do
		slot0:updateOnePieceInfo(slot6)
	end
end

function slot0.updateSimpleMapInfo(slot0, slot1)
	slot0:updateMapInfo(slot1)
end

function slot0.initPieceInfo(slot0, slot1)
	slot0.pieceDict = {}
	slot0.pieceList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RougePieceInfoMO.New()

		slot7:init(slot6)

		slot0.pieceDict[slot7.index] = slot7

		table.insert(slot0.pieceList, slot7)
	end
end

function slot0.updateOnePieceInfo(slot0, slot1)
	slot2 = slot0.pieceDict[slot1.index]

	if not slot1 then
		logError("update a not exist piece .. " .. tostring(slot1.index))

		return
	end

	slot2:update(slot1)
end

function slot0.getPieceList(slot0)
	return slot0.pieceList
end

function slot0.getMiddleLayerPosByIndex(slot0, slot1)
	return slot0.middleCo.pointPos[slot1]
end

function slot0.getPathIndex(slot0, slot1)
	return slot0:getMiddleLayerPosByIndex(slot1).z
end

function slot0.getMiddleLayerPathPos(slot0, slot1)
	return slot0:getMiddleLayerPathPosByPathIndex(slot0:getPathIndex(slot1))
end

function slot0.getMiddleLayerPathPosByPathIndex(slot0, slot1)
	return slot0.middleCo.pathPointPos[slot1]
end

function slot0.getCurPosIndex(slot0)
	return slot0.curPosIndex
end

function slot0.getMiddleLayerLeavePos(slot0)
	if not slot0.middleCo.leavePos then
		logError(string.format("间隙层地图id ：%s， 没有配置出口位置", slot0.middleCo.id))

		return 5.68, 0.41
	end

	return slot1.x, slot1.y
end

function slot0.hadLeavePos(slot0)
	return slot0.middleCo and slot0.middleCo.leavePos
end

function slot0.getMiddleLayerLeavePathIndex(slot0)
	return slot0.middleCo.leavePos.z
end

function slot0.getPieceMo(slot0, slot1)
	return slot0.pieceDict[slot1]
end

function slot0.getCurPieceMo(slot0)
	return slot0:getPieceMo(slot0:getCurPosIndex())
end

function slot0.clear(slot0)
	slot0.layerId = nil
	slot0.layerCo = nil
	slot0.middleLayerId = nil
	slot0.middleCo = nil
	slot0.curPosition = nil
	slot0.pieceDict = nil
	slot0.pieceList = nil
end

return slot0
