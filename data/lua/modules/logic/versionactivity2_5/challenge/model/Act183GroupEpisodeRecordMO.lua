module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeRecordMO", package.seeall)

slot0 = pureTable("Act183GroupEpisodeRecordMO")

function slot0.init(slot0, slot1)
	slot0._playerName = slot1.playerName
	slot0._portrait = slot1.portrait
	slot0._groupId = slot1.groupId
	slot0._allRound = slot1.allRound

	slot0:_onEpisodeListInfoLoaded(slot1.episodeList)

	slot0._finishedTime = slot1.finishedTime
end

function slot0._onEpisodeListInfoLoaded(slot0, slot1)
	slot0._episodeList = {}
	slot0._episodeTypeMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = Act183EpisodeRecordMO.New()

		slot7:init(slot6)
		table.insert(slot0._episodeList, slot7)

		slot0._episodeTypeMap[slot8] = slot0._episodeTypeMap[slot7:getEpisodeType()] or {}

		table.insert(slot0._episodeTypeMap[slot8], slot7)
	end

	slot0._groupType = slot0._episodeList[1] and slot2:getGroupType()

	table.sort(slot0._episodeList, slot0._sortEpisodeByPassOrder)

	for slot6, slot7 in pairs(slot0._episodeTypeMap) do
		table.sort(slot7, slot0._sortEpisodeByPassOrder)
	end
end

function slot0.getUserName(slot0)
	return slot0._playerName
end

function slot0.getPortrait(slot0)
	return slot0._portrait
end

function slot0.getFinishedTime(slot0)
	return slot0._finishedTime
end

function slot0.getAllRound(slot0)
	return slot0._allRound
end

function slot0.getEpisodeListByType(slot0, slot1)
	return slot0._episodeTypeMap and slot0._episodeTypeMap[slot1]
end

function slot0.getBossEpisode(slot0)
	return slot0:getEpisodeListByType(Act183Enum.EpisodeType.Boss) and slot1[1]
end

function slot0.getEpusideListByTypeAndPassOrder(slot0, slot1)
	return slot0:getEpisodeListByType(slot1)
end

function slot0._sortEpisodeByPassOrder(slot0, slot1)
	return slot0:getPassOrder() < slot1:getPassOrder()
end

function slot0.getGroupType(slot0)
	return slot0._groupType
end

function slot0.getGroupId(slot0)
	return slot0._groupId
end

function slot0.getBossEpisodeConditionStatus(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._episodeList) do
		if slot7:getEpisodeType() ~= Act183Enum.EpisodeType.Boss then
			tabletool.addValues(slot1, slot7:getConditionIds())
			tabletool.addValues(slot2, slot7:getPassConditions())
		end
	end

	return slot1, slot2, slot0:getBossEpisode() and slot3:getPassConditions(), slot3 and slot3:getChooseConditions()
end

return slot0
