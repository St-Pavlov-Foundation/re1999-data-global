module("modules.logic.story.model.StoryStepModel", package.seeall)

slot0 = class("StoryStepModel", BaseModel)

function slot0.onInit(slot0)
	slot0._stepList = {}
end

function slot0.setStepList(slot0, slot1)
	slot0._stepList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			slot7 = StoryStepMo.New()

			slot7:init(slot6)
			table.insert(slot0._stepList, slot7)
		end
	end

	slot0:setList(slot0._stepList)
end

function slot0.getStepList(slot0)
	return slot0._stepList
end

function slot0.getStepListById(slot0, slot1)
	for slot5, slot6 in pairs(slot0._stepList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.getStepFavor(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getStepListById(slot1).optList) do
		if slot8.feedbackType == 1 then
			slot3 = 0 + slot8.feedbackValue
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
