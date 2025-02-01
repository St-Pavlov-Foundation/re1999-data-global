module("modules.logic.story.model.StorySelectListModel", package.seeall)

slot0 = class("StorySelectListModel", ListScrollModel)

function slot0.setSelectList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = StorySelectMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
