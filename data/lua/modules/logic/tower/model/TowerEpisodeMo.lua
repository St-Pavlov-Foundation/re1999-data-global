module("modules.logic.tower.model.TowerEpisodeMo", package.seeall)

slot0 = pureTable("TowerEpisodeMo")

function slot0.init(slot0, slot1, slot2)
	slot0.towerType = slot1

	slot0:initEpisode(slot2)
end

function slot0.initEpisode(slot0, slot1)
	slot0.episodeList = {}
	slot0.preEpisodeDict = {}
	slot0.normalEpisodeCountDict = {}
	slot0.configDict = slot1.configDict
	slot2 = nil

	for slot6, slot7 in pairs(slot1.configList) do
		if not slot0.preEpisodeDict[slot7.towerId] then
			slot0.preEpisodeDict[slot2] = {}
		end

		slot8[slot7.preLayerId] = slot7.layerId
	end

	slot3, slot4, slot5 = nil

	for slot9, slot10 in pairs(slot0.preEpisodeDict) do
		if not slot0.episodeList[slot9] then
			slot0.episodeList[slot9] = {}
		end

		slot4 = slot10[0]
		slot5 = slot0:getEpisodeDict(slot9)

		while slot4 ~= nil do
			if slot5[slot4].openRound > 0 and slot0.normalEpisodeCountDict[slot9] == nil then
				slot0.normalEpisodeCountDict[slot9] = #slot11
			end

			table.insert(slot11, slot4)

			slot4 = slot10[slot4]
		end

		if slot0.normalEpisodeCountDict[slot9] == nil then
			slot0.normalEpisodeCountDict[slot9] = #slot11
		end
	end
end

function slot0.getEpisodeList(slot0, slot1)
	return slot0.episodeList[slot1]
end

function slot0.getEpisodeDict(slot0, slot1)
	return slot0.configDict[slot1]
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	if (slot0:getEpisodeDict(slot1) and slot3[slot2]) == nil and slot2 ~= 0 then
		logError(string.format("episode config is nil, towerType:%s,towerId:%s,layer:%s", slot0.towerType, slot1, slot2))
	end

	return slot4
end

function slot0.getNextEpisodeLayer(slot0, slot1, slot2)
	return slot0.preEpisodeDict[slot1] and slot3[slot2]
end

function slot0.getEpisodeIndex(slot0, slot1, slot2, slot3)
	if not slot0:getEpisodeConfig(slot1, slot2) then
		return 0
	end

	if not slot3 then
		slot7 = tabletool.indexOf(slot0:getEpisodeList(slot1), slot2) - (slot4.openRound > 0 and slot0.normalEpisodeCountDict[slot1] or 0)
	end

	return slot7
end

function slot0.getSpEpisodes(slot0, slot1)
	slot2 = {}

	if slot0.normalEpisodeCountDict[slot1] then
		for slot8 = slot3 + 1, #slot0:getEpisodeList(slot1) do
			table.insert(slot2, slot4[slot8])
		end
	end

	return slot2
end

function slot0.getLayerCount(slot0, slot1, slot2)
	if slot2 then
		slot3 = #slot0:getEpisodeList(slot1) - (slot0.normalEpisodeCountDict[slot1] or 0)
	end

	return slot3
end

function slot0.isPassAllUnlockLayers(slot0, slot1)
	if not slot0:getNextEpisodeLayer(slot1, TowerModel.instance:getTowerInfoById(slot0.towerType, slot1) and slot2.passLayerId or 0) then
		return true
	end

	if not slot0:getEpisodeConfig(slot1, slot4) then
		return true
	end

	if not (slot5.openRound > 0) then
		return false
	end

	return not slot2:isSpLayerOpen(slot4)
end

return slot0
