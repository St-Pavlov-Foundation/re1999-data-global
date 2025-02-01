module("modules.logic.rouge.map.model.mapmodel.RougePathSelectMapModel", package.seeall)

slot0 = class("RougePathSelectMapModel")

function slot0.initMap(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.layerCo = lua_rouge_layer.configDict[slot0.layerId]
	slot0.middleLayerId = slot1.middleLayerId
	slot0.middleLayerCo = lua_rouge_middle_layer.configDict[slot0.middleLayerId]

	slot0:initPieceInfo(slot1.pieceInfo)
	slot0:initNextLayerList()
	slot0:initPathSelectCo()
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

function slot0.initPathSelectCo(slot0)
	if #RougeMapConfig.instance:getPathSelectList(slot0.middleLayerId) == 1 then
		slot0.pathSelectId = slot1[1]
		slot0.pathSelectCo = lua_rouge_path_select.configDict[slot0.pathSelectId]

		return
	end

	for slot5, slot6 in ipairs(slot0.allLayerList) do
		if slot0.selectLayerId == slot6 then
			slot0.pathSelectId = slot1[slot5]
			slot0.pathSelectCo = lua_rouge_path_select.configDict[slot0.pathSelectId]

			return
		end
	end

	logError("路线选择层 一个可以选择的路线都没找到, 间隙层id : " .. tostring(slot0.middleLayerId))
end

function slot0.updateMapInfo(slot0, slot1)
end

function slot0.updateSimpleMapInfo(slot0, slot1)
	slot0:updateMapInfo(slot1)
end

function slot0.initNextLayerList(slot0)
	if not RougeMapConfig.instance:getNextLayerList(slot0.middleLayerId) then
		slot0.nextLayerList = nil
		slot0.selectLayerId = nil

		return
	end

	slot0.nextLayerList = {}
	slot0.allLayerList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = lua_rouge_layer.configDict[slot6]

		if RougeMapUnlockHelper.checkIsUnlock(slot7.unlockType, slot7.unlockParam) then
			slot0.selectLayerId = slot6

			table.insert(slot0.nextLayerList, slot6)
		end

		table.insert(slot0.allLayerList, slot6)
	end
end

function slot0.updateSelectLayerId(slot0, slot1)
	if slot0.selectLayerId == slot1 then
		return
	end

	slot0.selectLayerId = slot1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLayerChange, slot0.selectLayerId)
end

function slot0.getSelectLayerId(slot0)
	return slot0.selectLayerId
end

function slot0.getPieceList(slot0)
	return slot0.pieceList
end

function slot0.getNextLayerList(slot0)
	return slot0.nextLayerList
end

function slot0.clear(slot0)
	slot0.layerId = nil
	slot0.layerCo = nil
	slot0.middleLayerId = nil
	slot0.middleCo = nil
	slot0.pieceDict = nil
	slot0.pieceList = nil
end

return slot0
