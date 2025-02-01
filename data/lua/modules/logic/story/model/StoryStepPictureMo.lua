module("modules.logic.story.model.StoryStepPictureMo", package.seeall)

slot0 = pureTable("StoryStepPictureMo")

function slot0.ctor(slot0)
	slot0.picType = 0
	slot0.cirRadius = 0
	slot0.picColor = "#000000"
	slot0.picture = ""
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
	slot0.effType = 0
	slot0.effDegree = 0
	slot0.effDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.effTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.effRate = 1
end

function slot0.init(slot0, slot1)
	slot0.picType = slot1[1]
	slot0.cirRadius = slot1[2]
	slot0.picColor = slot1[3]
	slot0.picture = slot1[4]
	slot0.delayTimes = slot1[5]
	slot0.orderType = slot1[6]
	slot0.inType = slot1[7]
	slot0.inTimes = slot1[8]
	slot0.outType = slot1[9]
	slot0.outTimes = slot1[10]
	slot0.pos = {
		slot1[11],
		slot1[12]
	}
	slot0.layer = slot1[13]
	slot0.effType = slot1[14]
	slot0.effDegree = slot1[15]
	slot0.effDelayTimes = slot1[16]
	slot0.effTimes = slot1[17]
	slot0.effRate = slot1[18]
end

return slot0
