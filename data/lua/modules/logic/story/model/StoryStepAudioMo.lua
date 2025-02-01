module("modules.logic.story.model.StoryStepAudioMo", package.seeall)

slot0 = pureTable("StoryStepAudioMo")

function slot0.ctor(slot0)
	slot0.audio = 0
	slot0.audioState = 0
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
	slot0.volume = 1
	slot0.transTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.count = 1
end

function slot0.init(slot0, slot1)
	slot0.audio = slot1[1]
	slot0.audioState = slot1[2]
	slot0.delayTimes = slot1[3]
	slot0.orderType = slot1[4]
	slot0.volume = slot1[5]
	slot0.transTimes = slot1[6]
	slot0.count = slot1[7]
end

return slot0
