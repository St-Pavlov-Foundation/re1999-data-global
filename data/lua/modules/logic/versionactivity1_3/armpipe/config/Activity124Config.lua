module("modules.logic.versionactivity1_3.armpipe.config.Activity124Config", package.seeall)

slot0 = class("Activity124Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act124Map = nil
	slot0._act124Episode = nil
	slot0._episodeListDict = {}
	slot0._chapterIdListDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity124_map",
		"activity124_episode"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity124_map" then
		slot0._act124Map = slot2
	elseif slot1 == "activity124_episode" then
		slot0._act124Episode = slot2
	end
end

function slot0.getMapCo(slot0, slot1, slot2)
	if slot0._act124Map.configDict[slot1] then
		return slot0._act124Map.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	if slot0._act124Episode.configDict[slot1] then
		return slot0._act124Episode.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeList(slot0, slot1)
	if slot0._episodeListDict[slot1] then
		return slot0._episodeListDict[slot1]
	end

	slot0._episodeListDict[slot1] = {}

	if slot0._act124Episode and slot0._act124Episode.configDict[slot1] then
		for slot6, slot7 in pairs(slot0._act124Episode.configDict[slot1]) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, uv0.sortEpisode)
	end

	return slot2
end

function slot0.sortEpisode(slot0, slot1)
	if slot0.episodeId ~= slot1.episodeId then
		return slot0.episodeId < slot1.episodeId
	end
end

slot0.instance = slot0.New()

return slot0
