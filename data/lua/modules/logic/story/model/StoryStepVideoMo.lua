module("modules.logic.story.model.StoryStepVideoMo", package.seeall)

slot0 = pureTable("StoryStepVideoMo")

function slot0.ctor(slot0)
	slot0.video = ""
	slot0.delayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.orderType = 0
	slot0.loop = false
	slot0.layer = 6
end

function slot0.init(slot0, slot1)
	slot0.video = slot1[1]
	slot0.delayTimes = slot1[2]
	slot0.orderType = slot1[3]
	slot0.loop = slot1[4]
	slot0.layer = slot1[5]
end

return slot0
