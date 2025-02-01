module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2NoteConfig", package.seeall)

slot0 = class("VersionActivity1_2NoteConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity121_note",
		"activity121_story",
		"activity121_clue"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity121_note" then
		slot0:_initNoteConfig()
	elseif slot1 == "activity121_story" then
		slot0:_initStoryConfig()
	end
end

function slot0._initNoteConfig(slot0)
	slot0._episodeId2Config = {}
	slot0._noteCount = 0

	for slot4, slot5 in ipairs(lua_activity121_note.configList) do
		if not slot0._episodeId2Config[slot5.episodeId] then
			slot0._episodeId2Config[slot5.episodeId] = {}
		end

		table.insert(slot0._episodeId2Config[slot5.episodeId], slot5)

		slot0._noteCount = slot0._noteCount + 1
	end
end

function slot0.getConfigList(slot0, slot1)
	return slot0._episodeId2Config and slot0._episodeId2Config[slot1]
end

function slot0._initStoryConfig(slot0)
	slot0._storyList = {}

	for slot4, slot5 in ipairs(lua_activity121_story.configList) do
		slot0._storyList[slot5.id] = slot5
	end

	table.sort(slot0._storyList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
end

function slot0.getStoryList(slot0)
	return slot0._storyList
end

function slot0.getAllNoteCount(slot0)
	return slot0._noteCount
end

slot0.instance = slot0.New()

return slot0
