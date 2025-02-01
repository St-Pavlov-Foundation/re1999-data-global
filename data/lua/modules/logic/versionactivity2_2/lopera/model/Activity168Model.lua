module("modules.logic.versionactivity2_2.lopera.model.Activity168Model", package.seeall)

slot0 = class("Activity168Model", BaseModel)

function slot0.onInit(slot0)
	slot0._passEpisodes = {}
	slot0._unlockEpisodes = {}
	slot0._episodeDatas = {}
	slot0._itemDatas = {}
	slot0._unLockCount = 0
	slot0._finishedCount = 0
	slot0._curActionPoint = 0
	slot0._curGameState = nil
end

function slot0.reInit(slot0)
	slot0._passEpisodes = {}
	slot0._unlockEpisodes = {}
	slot0._episodeDatas = {}
	slot0._itemDatas = {}
	slot0._unLockCount = 0
	slot0._finishedCount = 0
	slot0._curActionPoint = 0
	slot0._curGameState = nil
end

function slot0.setCurActId(slot0, slot1)
	slot0._curActId = slot1
end

function slot0.getCurActId(slot0)
	return slot0._curActId
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.setCurBattleEpisodeId(slot0, slot1)
	slot0._curBattleEpisodeId = slot1
end

function slot0.getCurBattleEpisodeId(slot0)
	return slot0._curBattleEpisodeId
end

function slot0.setCurActionPoint(slot0, slot1)
	slot0._curActionPoint = slot1
end

function slot0.getCurActionPoint(slot0)
	return slot0._curActionPoint
end

function slot0.setCurGameState(slot0, slot1)
	slot0._curGameState = slot1
end

function slot0.getCurGameState(slot0)
	return slot0._curGameState
end

function slot0.isEpisodeFinish(slot0, slot1)
	return slot0._passEpisodes[slot1]
end

function slot0.onGetActInfoReply(slot0, slot1)
	slot0._unLockCount = 0
	slot0._finishedCount = 0

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.episodeId
		slot0._episodeDatas[slot7] = slot6
		slot0._unlockEpisodes[slot7] = true
		slot0._unLockCount = slot0._unLockCount + 1

		if slot6.isFinished then
			slot0._passEpisodes[slot7] = true
			slot0._finishedCount = slot0._finishedCount + 1
		end

		if slot6.act168Game then
			slot0:onItemInfoUpdate(slot7, slot6.act168Game.act168Items)
		end
	end
end

function slot0.onEpisodeInfoUpdate(slot0, slot1)
	slot2 = slot1.episodeId
	slot0._episodeDatas[slot2] = slot1

	if not slot0._passEpisodes[slot2] and slot1.isFinished then
		slot0._passEpisodes[slot2] = true
		slot0._finishedCount = slot0._finishedCount + 1
	end

	if not slot0._unlockEpisodes[slot2] then
		slot0._unlockEpisodes[slot2] = true
		slot0._unLockCount = slot0._unLockCount + 1
	end

	if slot1.act168Game then
		slot0:onItemInfoUpdate(slot2, slot1.act168Game.act168Items)
	end
end

function slot0.getUnlockCount(slot0)
	return slot0._unLockCount and slot0._unLockCount or 10
end

function slot0.getFinishedCount(slot0)
	return slot0._finishedCount
end

function slot0.isEpisodeUnlock(slot0, slot1)
	return slot0._unlockEpisodes[slot1]
end

function slot0.isEpisodeFinished(slot0, slot1)
	return slot0._passEpisodes[slot1]
end

function slot0.getEpisodeData(slot0, slot1)
	return slot0._episodeDatas[slot1]
end

function slot0.getCurMoveCost(slot0, slot1)
	slot1 = slot1 or 1

	if slot0:getCurGameState() and slot2.buffs then
		for slot7, slot8 in ipairs(slot3) do
			slot1 = slot8.ext + slot1
		end
	end

	return slot1
end

function slot0.clearEpisodeItemInfo(slot0, slot1)
	slot0._itemDatas[slot1] = {}
end

function slot0.onItemInfoUpdate(slot0, slot1, slot2, slot3, slot4)
	slot0._itemChanged = slot0._itemChanged or {}
	slot0._itemDatas[slot1] = slot0._itemDatas[slot1] or {}
	slot5 = slot0._itemDatas[slot1]

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			slot5[slot11] = slot10.count

			if slot4 then
				slot0._itemChanged[slot11] = slot12 - (slot5[slot10.itemId] or 0)
			end
		end
	end

	if slot3 then
		for slot9, slot10 in ipairs(slot3) do
			slot11 = slot10.itemId

			if slot4 then
				slot0._itemChanged[slot11] = -slot10.count
			end

			slot5[slot11] = 0
		end
	end
end

function slot0.getItemCount(slot0, slot1)
	return slot0._itemDatas[slot0:getCurEpisodeId()] and slot0._itemDatas[slot2][slot1] or 0
end

function slot0.clearItemChangeDict(slot0)
	slot0._itemChanged = {}
end

function slot0.getItemChangeDict(slot0)
	return slot0._itemChanged
end

function slot0.getCurEpisodeItems(slot0)
	return slot0._itemDatas[slot0:getCurEpisodeId()]
end

slot0.instance = slot0.New()

return slot0
