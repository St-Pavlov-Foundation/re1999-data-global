module("modules.logic.story.model.StorySelectMo", package.seeall)

slot0 = pureTable("StorySelectMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.name = ""
	slot0.index = 0
	slot0.stepId = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.name = slot1.name
	slot0.index = slot1.index
	slot0.stepId = slot1.stepId
end

return slot0
