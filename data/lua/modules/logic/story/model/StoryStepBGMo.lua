module("modules.logic.story.model.StoryStepBGMo", package.seeall)

slot0 = pureTable("StoryStepBGMo")

function slot0.ctor(slot0)
	slot0.bgType = 0
	slot0.bgImg = ""
	slot0.transType = 0
	slot0.darkTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.waitTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.fadeTimes = {
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5
	}
	slot0.offset = {}
	slot0.angle = 0
	slot0.scale = 1
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
	slot0.bgType = slot1[1]

	if slot1[2] ~= "" then
		slot0.bgImg = StoryBgZoneModel.instance:getRightBgZonePath(string.find(slot1[2], "/") and slot1[2] or "bg/" .. slot1[2])
	end

	slot0.transType = slot1[3]
	slot0.darkTimes = slot1[4]
	slot0.waitTimes = slot1[5]
	slot0.fadeTimes = slot1[6]
	slot0.offset = {
		slot1[7],
		slot1[8]
	}
	slot0.angle = slot1[9]
	slot0.scale = slot1[10]
	slot0.transTimes = slot1[11]
	slot0.effType = slot1[12]
	slot0.effDegree = slot1[13]
	slot0.effDelayTimes = slot1[14]
	slot0.effTimes = slot1[15]
	slot0.effRate = slot1[16]
end

return slot0
