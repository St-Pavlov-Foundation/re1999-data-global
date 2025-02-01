module("modules.logic.story.model.StoryProcessInfoMo", package.seeall)

slot0 = pureTable("StoryProcessInfoMo")

function slot0.ctor(slot0)
	slot0.storyId = nil
	slot0.stepId = nil
	slot0.favor = nil
end

function slot0.init(slot0, slot1)
	slot0.storyId = slot1.storyId
	slot0.stepId = slot1.stepId
	slot0.favor = slot1.favor
end

return slot0
