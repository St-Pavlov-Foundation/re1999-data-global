module("modules.logic.story.model.StoryStepMainHeroMo", package.seeall)

slot0 = pureTable("StoryStepMainHeroMo")

function slot0.ctor(slot0)
	slot0.mouses = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.anims = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.expressions = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
end

function slot0.init(slot0, slot1)
	slot0.mouses = slot1[1]
	slot0.anims = slot1[2]
	slot0.expressions = slot1[3]
end

return slot0
