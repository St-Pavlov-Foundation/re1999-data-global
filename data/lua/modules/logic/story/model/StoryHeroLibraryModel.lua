module("modules.logic.story.model.StoryHeroLibraryModel", package.seeall)

slot0 = class("StoryHeroLibraryModel", BaseModel)

function slot0.onInit(slot0)
	slot0._herolibrary = {}
end

function slot0.setStoryHeroLibraryList(slot0, slot1)
	slot0._herolibrary = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = StoryHeroLibraryMo.New()

		slot7:init(slot6, slot5)
		table.insert(slot0._herolibrary, slot7)
	end

	slot0:setList(slot0._herolibrary)
end

function slot0.getStoryHeroLibraryList(slot0)
	return slot0._herolibrary
end

function slot0.getStoryLibraryHeroByIndex(slot0, slot1)
	for slot5, slot6 in pairs(slot0._herolibrary) do
		if slot6.index == slot1 then
			return slot6
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
