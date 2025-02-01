module("modules.logic.story.model.StoryStepOptionMo", package.seeall)

slot0 = pureTable("StoryStepOptionMo")

function slot0.ctor(slot0)
	slot0.condition = false
	slot0.conditionType = 0
	slot0.conditionValue = ""
	slot0.conditionValue2 = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.branchTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.type = 0
	slot0.feedbackType = 0
	slot0.feedbackValue = 0
	slot0.back = false
	slot0.id = 0
	slot0.followId = 0
end

function slot0.init(slot0, slot1)
	slot0.condition = slot1[1]
	slot0.conditionType = slot1[2]
	slot0.conditionValue = slot1[3]
	slot0.conditionValue2 = slot1[4]
	slot0.branchTxts = slot1[5]
	slot0.type = slot1[6]
	slot0.feedbackType = slot1[7]
	slot0.feedbackValue = slot1[8]
	slot0.back = slot1[9]
	slot0.id = slot1[10]
	slot0.followId = slot1[11]
end

return slot0
