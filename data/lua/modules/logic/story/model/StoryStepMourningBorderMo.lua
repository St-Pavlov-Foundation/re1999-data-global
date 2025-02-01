module("modules.logic.story.model.StoryStepMourningBorderMo", package.seeall)

slot0 = pureTable("StoryStepMourningBorderMo")

function slot0.ctor(slot0)
	slot0.borderType = 0
	slot0.borderTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function slot0.init(slot0, slot1)
	slot0.borderType = slot1[1]
	slot0.borderTimes = slot1[2]
end

return slot0
