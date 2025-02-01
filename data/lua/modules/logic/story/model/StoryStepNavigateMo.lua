module("modules.logic.story.model.StoryStepNavigateMo", package.seeall)

slot0 = pureTable("StoryStepNavigateMo")

function slot0.ctor(slot0)
	slot0.navigateType = 1
	slot0.navigateTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.navigateChapterEn = ""
	slot0.navigateLogo = ""
end

function slot0.init(slot0, slot1)
	slot0.navigateType = slot1[1]
	slot0.navigateTxts = slot1[2]
	slot0.navigateChapterEn = slot1[3]
	slot0.navigateLogo = slot1[4]
end

return slot0
