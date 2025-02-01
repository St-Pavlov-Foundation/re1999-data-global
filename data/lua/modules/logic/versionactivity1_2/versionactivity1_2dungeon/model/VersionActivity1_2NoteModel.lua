module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2NoteModel", package.seeall)

slot0 = class("VersionActivity1_2NoteModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onReceiveGet121InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot0:_setData(slot2)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, slot1)
end

function slot0.getNotes(slot0)
	return slot0._notes
end

function slot0.getNote(slot0, slot1)
	return slot0._notes and slot0._notes[slot1]
end

function slot0.setNote(slot0, slot1)
	slot0._notes = slot0._notes or {}
	slot0._notes[slot1] = slot1
end

function slot0.getBonusFinished(slot0, slot1)
	return slot0._getBonusStory and slot0._getBonusStory[slot1]
end

function slot0._setData(slot0, slot1)
	slot0._notes = {}

	for slot5, slot6 in ipairs(slot1.info.notes) do
		slot0._notes[slot6] = slot6
	end

	slot0._getBonusStory = {}

	for slot5, slot6 in ipairs(slot1.info.getBonusStory) do
		slot0._getBonusStory[slot6] = slot6
	end
end

function slot0.onReceiveGet121BonusReply(slot0, slot1)
	slot0._getBonusStory = slot0._getBonusStory or {}
	slot0._getBonusStory[slot1.storyId] = slot1.storyId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, slot1.storyId)
end

function slot0.onReceiveAct121UpdatePush(slot0, slot1)
	slot0:_setData(slot1)

	for slot6, slot7 in pairs(slot0._notes or {}) do
		if not tabletool.copy(slot0._notes or {})[slot7] and #string.splitToNumber(lua_activity121_note.configDict[slot7].fightId, "#") == 0 then
			slot0.showClueData = slot0.showClueData or {}

			table.insert(slot0.showClueData, {
				showPaper = true,
				id = slot7
			})
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush)
end

function slot0.getClueData(slot0)
	return slot0.showClueData
end

function slot0.isCollectedAllNote(slot0)
	return VersionActivity1_2NoteConfig.instance:getAllNoteCount() <= (slot0._notes and tabletool.len(slot0._notes) or 0)
end

function slot0.isAllBonusFinished(slot0)
	return tabletool.len(slot0._getBonusStory) == tabletool.len(VersionActivity1_2NoteConfig.instance:getStoryList())
end

slot0.instance = slot0.New()

return slot0
