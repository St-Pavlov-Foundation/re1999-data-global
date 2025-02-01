module("modules.logic.dungeon.model.DungeonMainStoryModel", package.seeall)

slot0 = class("DungeonMainStoryModel")

function slot0.setChapterList(slot0, slot1)
	slot0._list = {}

	for slot5, slot6 in ipairs(slot1) do
		slot8 = slot0._list[DungeonConfig.instance:getChapterDivideSectionId(slot6.id)] or {}

		table.insert(slot8, slot6)

		slot0._list[slot7] = slot8
	end
end

function slot0.getChapterList(slot0, slot1)
	return slot1 and slot0._list[slot1]
end

function slot0.setSectionSelected(slot0, slot1)
	slot0._selectedSectionId = slot1
end

function slot0.getSelectedSectionId(slot0)
	return slot0._selectedSectionId
end

function slot0.sectionIsSelected(slot0, slot1)
	return slot0._selectedSectionId == slot1
end

slot0.instance = slot0.New()

return slot0
