module("modules.logic.rouge.map.model.mapmodel.RougeLayerMapModel", package.seeall)

slot0 = class("RougeLayerMapModel")

function slot0.initMap(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.layerCo = lua_rouge_layer.configDict[slot0.layerId]
	slot0.curEpisodeId = RougeMapHelper.getEpisodeIndex(slot1.curStage)
	slot0.curNodeId = slot1.curNode

	slot0:initNodeInfo(slot1.nodeInfo)
end

function slot0.updateMapInfo(slot0, slot1)
	slot0.curEpisodeId = RougeMapHelper.getEpisodeIndex(slot1.curStage)
	slot0.curNodeId = slot1.curNode

	slot0:updateNodeInfo(slot1.nodeInfo)
end

function slot0.updateSimpleMapInfo(slot0, slot1)
	slot0:updateMapInfo(slot1)
end

function slot0.initNodeInfo(slot0, slot1)
	slot0.episodeList = {}
	slot0.nodeDict = {}
	slot2 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(slot1) do
		if 0 < RougeMapHelper.getEpisodeIndex(slot9.stage) then
			slot3 = slot10
		end

		if slot4 < slot9.nodeId then
			slot4 = slot9.nodeId
		end

		if not slot0.episodeList[slot10] then
			slot11 = RougeEpisodeMO.New()

			slot11:init(slot10)
			table.insert(slot0.episodeList, slot11)

			slot2 = 0
		end

		slot2 = slot2 + 1
		slot12 = RougeNodeInfoMO.New()

		slot12:init(slot9)
		slot11:addNode(slot12)

		slot0.nodeDict[slot12.nodeId] = slot12
	end

	slot5 = slot3 + 1
	slot0.endNodeId = slot4 + 1
	slot6 = {}
	slot7 = slot0.episodeList[slot3]
	slot12 = slot7

	for slot11, slot12 in ipairs(slot7.getNodeMoList(slot12)) do
		table.insert(slot6, slot12.nodeId)
	end

	slot8 = RougeEpisodeMO.New()

	slot8:init(slot5)
	slot8:setIsEnd(true)

	slot9 = RougeNodeInfoMO.New()

	slot8:addNode(slot9)

	slot14 = slot5

	slot9:initEnd(slot0.layerId, slot14, slot0.endNodeId, slot6)

	slot13 = slot8

	table.insert(slot0.episodeList, slot13)

	slot0.nodeDict[slot0.endNodeId] = slot9

	for slot13, slot14 in ipairs(slot0.episodeList) do
		slot14:sortNode()
		slot14:updateNodeArriveStatus()
	end

	slot0:initNodeFogInfo()
end

function slot0.updateNodeInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0.nodeDict[slot6.nodeId] then
			logError("update node info fail, not found nodeId : " .. tostring(slot6.nodeId))
		else
			slot7:updateInfo(slot6)
		end
	end

	if slot0:getNode(slot0.endNodeId) then
		slot2.fog = slot2:checkIsEndFog()
	end

	for slot6, slot7 in ipairs(slot0.episodeList) do
		slot7:sortNode()
		slot7:updateNodeArriveStatus()
	end

	slot0:initNodeFogInfo()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeArriveStatusChange)
end

function slot0.getEpisodeList(slot0)
	return slot0.episodeList
end

function slot0.getCurEpisodeId(slot0)
	return slot0.curEpisodeId
end

function slot0.getCurNode(slot0)
	return slot0:getNode(slot0.curNodeId)
end

function slot0.getNodeDict(slot0)
	return slot0.nodeDict
end

function slot0.getNode(slot0, slot1)
	if not slot0.nodeDict[slot1] then
		logError("not found nodeId : " .. tostring(slot1))

		return nil
	end

	return slot2
end

function slot0.getEndNodeId(slot0)
	return slot0.endNodeId
end

function slot0.initNodeFogInfo(slot0)
	slot0._fogNodeList = {}
	slot0._holeNodeList = {}
	slot0._fogNodeMap = {}
	slot0._holeNodeMap = {}
	slot1 = false

	for slot5, slot6 in ipairs(slot0.episodeList or {}) do
		slot8 = {}

		for slot12, slot13 in ipairs(slot6:getNodeMoList() or {}) do
			if slot13.fog then
				slot1 = true
				slot0._fogNodeMap[slot13.nodeId] = slot13

				table.insert(slot0._fogNodeList, slot13)
			else
				table.insert(slot8, slot13)
			end
		end

		for slot12, slot13 in ipairs(slot8) do
			if slot1 then
				slot0._holeNodeMap[slot13.nodeId] = slot13

				table.insert(slot0._holeNodeList, slot13)
			end
		end
	end
end

function slot0.getFogNodeList(slot0)
	return slot0._fogNodeList
end

function slot0.getHoleNodeList(slot0)
	return slot0._holeNodeList
end

function slot0.isHoleNode(slot0, slot1)
	return slot0._holeNodeMap and slot0._holeNodeMap[slot1] ~= nil
end

function slot0.clear(slot0)
	slot0.episodeList = nil
	slot0.nodeDict = nil
	slot0.layerId = nil
	slot0.layerCo = nil
	slot0.curEpisodeId = nil
	slot0.curNodeId = nil
end

return slot0
