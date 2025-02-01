module("modules.logic.meilanni.model.EpisodeInfoMO", package.seeall)

slot0 = pureTable("EpisodeInfoMO")

function slot0.init(slot0, slot1)
	slot0.episodeId = slot1.episodeId
	slot0.mapId = slot1.mapId
	slot0.isFinish = slot1.isFinish
	slot0.leftActPoint = slot1.leftActPoint
	slot0.confirm = slot1.confirm

	slot0:_initEvents(slot1)
	slot0:_initHistorylist(slot1)

	slot0.episodeConfig = lua_activity108_episode.configDict[slot0.episodeId]
end

function slot0._initEvents(slot0, slot1)
	slot0.events = {}
	slot0.eventMap = {}
	slot0.specialEventNum = 0

	for slot5, slot6 in ipairs(slot1.events) do
		slot7 = EpisodeEventMO.New()

		slot7:init(slot6)
		table.insert(slot0.events, slot7)

		slot0.eventMap[slot7.eventId] = slot7

		if not slot7.isFinish and slot7.config.type == 1 then
			slot0.specialEventNum = slot0.specialEventNum + 1
		end
	end
end

function slot0._initHistorylist(slot0, slot1)
	slot0.historylist = {}

	for slot7, slot8 in ipairs(slot1.historylist) do
		slot9 = EpisodeHistoryMO.New()

		slot9:init(slot8)
		table.insert(slot0.historylist, slot9)

		if slot8.eventId ~= nil then
			slot2 = slot8.eventId
			slot3 = 0 + 1
		end
	end

	slot0.historyLen = slot3
end

function slot0.getEventInfo(slot0, slot1)
	return slot0.eventMap[slot1]
end

function slot0.getEventByBattleId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.events) do
		if slot6:getConfigBattleId() == slot1 then
			return slot6
		end
	end
end

return slot0
