module("modules.logic.story.model.StoryStepHeroMo", package.seeall)

slot0 = pureTable("StoryStepHeroMo")

function slot0.ctor(slot0)
	slot0.heroIndex = 0
	slot0.heroDir = 1
	slot0.heroPos = {
		0,
		0
	}
	slot0.heroScale = 1
	slot0.isFollow = false
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
	slot0.effs = {
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
	slot0.heroIndex = slot1[1]
	slot0.heroDir = slot1[2]

	if StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(slot1[1]) then
		slot3 = ""

		if slot1[2] == 0 then
			slot3 = slot2.type == 0 and slot2.leftParam or slot2.live2dLeftParam
		elseif slot1[2] == 1 then
			slot3 = slot2.type == 0 and slot2.midParam or slot2.live2dMidParam
		elseif slot1[2] == 2 then
			slot3 = slot2.type == 0 and slot2.rightParam or slot2.live2dRightParam
		end

		slot4 = string.split(slot3, "#")
		slot0.heroPos = {
			tonumber(slot4[1]),
			tonumber(slot4[2])
		}
		slot0.heroScale = tonumber(slot4[3])
	end

	slot0.isFollow = slot1[3]
	slot0.mouses = slot1[4]
	slot0.anims = slot1[5]
	slot0.expressions = slot1[6]
	slot0.effs = slot1[7]
end

return slot0
