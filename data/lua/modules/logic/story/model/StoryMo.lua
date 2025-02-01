module("modules.logic.story.model.StoryMo", package.seeall)

slot0 = pureTable("StoryMo")

function slot0.ctor(slot0)
	slot0.finishList = nil
	slot0.processList = nil
end

function slot0.init(slot0, slot1)
	slot0.finishList = {}

	if slot1.finishList then
		for slot5, slot6 in ipairs(slot1.finishList) do
			slot0.finishList[slot6] = true
		end
	end

	slot0.processList = slot1.processingList and slot0:_getListInfo(slot1.processingList, StoryProcessInfoMo) or {}
end

function slot0.update(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot0.processList) do
		if slot7.storyId == slot1.storyId then
			slot7.stepId = slot1.stepId
			slot7.favor = slot1.favor
			slot2 = true
		end
	end

	if not slot2 then
		slot3 = StoryProcessInfoMo.New()
		slot3.storyId = slot1.storyId
		slot3.stepId = slot1.stepId
		slot3.favor = slot1.favor

		table.insert(slot0.processList, slot3)
	end
end

function slot0._getListInfo(slot0, slot1, slot2)
	if not slot1 then
		return {}
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot8

		if slot2 then
			slot2.New():init(slot8)
		end

		table.insert(slot3, slot9)
	end

	return slot3
end

return slot0
