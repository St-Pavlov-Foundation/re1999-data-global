module("modules.logic.story.model.StoryStepEffectMo", package.seeall)

slot0 = pureTable("StoryStepEffectMo")

function slot0.ctor(slot0)
	slot0.effect = ""
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
	slot0.inType = 0
	slot0.inTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.outType = 0
	slot0.outTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.pos = {}
	slot0.layer = 9
end

function slot0.init(slot0, slot1)
	slot0.effect = slot1[1]
	slot0.delayTimes = slot1[2]
	slot0.orderType = slot1[3]
	slot0.inType = slot1[4]
	slot0.inTimes = slot1[5]
	slot0.outType = slot1[6]
	slot0.outTimes = slot1[7]
	slot0.pos = {
		slot1[8],
		slot1[9]
	}
	slot0.layer = slot1[10]
end

return slot0
