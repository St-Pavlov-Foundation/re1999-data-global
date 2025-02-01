module("modules.logic.story.model.StoryStepConversationMo", package.seeall)

slot0 = pureTable("StoryStepConversationMo")

function slot0.ctor(slot0)
	slot0.type = 0
	slot0.delayTimes = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	slot0.isAuto = false
	slot0.effType = 0
	slot0.effLv = 0
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
	slot0.showList = {}
	slot0.nameShow = false
	slot0.nameEnShow = false
	slot0.heroNames = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.iconShow = false
	slot0.heroIcon = ""
	slot0.audios = {}
	slot0.audioDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.diaTexts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	slot0.showTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	slot0.keepTimes = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}
end

function slot0.init(slot0, slot1)
	slot0.type = slot1[1]
	slot0.delayTimes = slot1[2]
	slot0.isAuto = slot1[3]
	slot0.effType = slot1[4]
	slot0.effLv = slot1[5]
	slot0.effDelayTimes = slot1[6]
	slot0.effTimes = slot1[7]
	slot0.effRate = slot1[8]
	slot0.showList = slot1[9]
	slot0.nameShow = slot1[10]
	slot0.nameEnShow = slot1[11]
	slot0.heroNames = slot1[12]
	slot0.iconShow = slot1[13]
	slot0.heroIcon = slot1[14]
	slot0.audios = string.split(slot1[15], "#")[1] == "" and {
		0
	} or string.splitToNumber(slot2[1], "&")

	if slot2[2] then
		for slot7 = 1, #string.splitToNumber(slot2[2], "|") do
			slot0.audioDelayTimes[slot7] = slot3[slot7]
		end
	end

	slot0.diaTexts = slot1[16]
	slot0.showTimes = slot1[17]
	slot0.keepTimes = slot1[18]
end

return slot0
