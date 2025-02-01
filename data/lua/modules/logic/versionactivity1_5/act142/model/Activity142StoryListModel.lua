module("modules.logic.versionactivity1_5.act142.model.Activity142StoryListModel", package.seeall)

slot0 = class("Activity142StoryListModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in ipairs(Activity142Config.instance:getEpisodeStoryList(slot1, slot2)) do
		table.insert(slot3, {
			index = slot8,
			storyId = slot9.id
		})
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
