module("modules.logic.story.model.StoryBgEffectTransModel", package.seeall)

slot0 = class("StoryBgEffectTransModel", BaseModel)

function slot0.onInit(slot0)
	slot0._transList = {}
end

function slot0.setStoryBgEffectTransList(slot0, slot1)
	slot0._transList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = StoryBgEffectTransMo.New()

		slot7:init(slot6, slot5)
		table.insert(slot0._transList, slot7)
	end
end

function slot0.getStoryBgEffectTransList(slot0)
	return slot0._transList
end

function slot0.getStoryBgEffectTransByType(slot0, slot1)
	for slot5, slot6 in pairs(slot0._transList) do
		if slot6.type == slot1 then
			return slot6
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
