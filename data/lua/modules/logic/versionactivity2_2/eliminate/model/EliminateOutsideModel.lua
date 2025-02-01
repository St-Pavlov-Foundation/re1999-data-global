module("modules.logic.versionactivity2_2.eliminate.model.EliminateOutsideModel", package.seeall)

slot0 = class("EliminateOutsideModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._selectedEpisodeId = nil
	slot0._selectedCharacterId = nil
	slot0._selectedPieceId = nil
	slot0._totalStar = 0
	slot0._gainedTaskId = {}
	slot0._chapterList = {}
	slot0._ownedWarChessCharacterId = {}
	slot0._ownedWarChessPieceId = {}
	slot0._episodeInfo = {}
end

function slot0.initTaskInfo(slot0, slot1, slot2)
	slot0._totalStar = slot1
	slot0._gainedTaskId = {}

	for slot6, slot7 in ipairs(slot2) do
		slot0._gainedTaskId[slot7] = slot7
	end
end

function slot0.initMapInfo(slot0, slot1, slot2, slot3, slot4)
	slot0._ownedWarChessCharacterId = {}
	slot0._ownedWarChessPieceId = {}
	slot0._episodeInfo = {}
	slot0._unlockSlotNum = #slot4

	for slot8, slot9 in ipairs(slot1) do
		slot0._ownedWarChessCharacterId[slot9] = slot9
	end

	for slot8, slot9 in ipairs(slot2) do
		slot0._ownedWarChessPieceId[slot9] = slot9
	end

	for slot8, slot9 in ipairs(slot3) do
		slot10 = slot0._episodeInfo[slot9.id] or WarEpisodeInfo.New()

		slot10:init(slot9)

		slot0._episodeInfo[slot9.id] = slot10
	end

	slot0:_initChapterList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnUpdateEpisodeInfo)
end

function slot0._initChapterList(slot0)
	slot0._chapterList = {}

	for slot4, slot5 in ipairs(lua_eliminate_episode.configList) do
		slot6 = slot0._chapterList[slot5.chapterId] or {}
		slot0._chapterList[slot5.chapterId] = slot6
		slot7 = slot0._episodeInfo[slot5.id] or WarEpisodeInfo.New()

		slot7:initFromParam(slot5.id, slot7.star or 0)

		slot0._episodeInfo[slot7.id] = slot7

		table.insert(slot6, slot7)
	end
end

function slot0.getChapterList(slot0)
	return slot0._chapterList
end

function slot0.getUnlockSlotNum(slot0)
	return slot0._unlockSlotNum
end

function slot0.getTotalStar(slot0)
	return slot0._totalStar
end

function slot0.addGainedTask(slot0, slot1)
	if slot1 == 0 then
		for slot5, slot6 in ipairs(lua_eliminate_reward.configList) do
			if slot6.star <= slot0._totalStar then
				slot0._gainedTaskId[slot6.id] = slot6.id
			end
		end

		return
	end

	slot0._gainedTaskId[slot1] = slot1
end

function slot0.gainedTask(slot0, slot1)
	return slot0._gainedTaskId[slot1] ~= nil
end

function slot0.hasCharacter(slot0, slot1)
	return slot0._ownedWarChessCharacterId[slot1] ~= nil
end

function slot0.hasChessPiece(slot0, slot1)
	return slot0._ownedWarChessPieceId[slot1] ~= nil
end

function slot0.hasPassedEpisode(slot0, slot1)
	return slot0._episodeInfo[slot1] and slot2.star > 0
end

slot0.instance = slot0.New()

return slot0
