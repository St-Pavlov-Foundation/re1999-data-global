module("modules.logic.versionactivity2_1.activity165.config.Activity165Config", package.seeall)

slot0 = class("Activity165Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._storyCoDic = nil
	slot0._storyEndCoDic = nil
	slot0._keywordsCoDic = nil
	slot0._stepCoDic = nil
	slot0._rewardCoDic = nil
	slot0._storyStepCoDic = nil
	slot0._storyEndingCoDic = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity165_ending",
		"activity165_keyword",
		"activity165_step",
		"activity165_story",
		"activity165_reward"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity165_ending" then
		slot0._storyEndCoDic = slot2

		slot0:initEndingConfig()
	elseif slot1 == "activity165_keyword" then
		slot0._keywordsCoDic = slot2
	elseif slot1 == "activity165_step" then
		slot0._stepCoDic = slot2

		slot0:initStepCofig()
	elseif slot1 == "activity165_story" then
		slot0._storyCoDic = slot2
		slot0._storyCoMap = {}
		slot0._storyElementList = {}
	elseif slot1 == "activity165_reward" then
		slot0._rewardCoDic = slot2
	end
end

function slot0.initStepCofig(slot0)
	slot0._storyStepCoDic = {}

	for slot4, slot5 in pairs(slot0._stepCoDic.configList) do
		if not slot0._storyStepCoDic[slot5.belongStoryId] then
			slot0._storyStepCoDic[slot5.belongStoryId] = {}
		end

		table.insert(slot6, slot5)
	end
end

function slot0.initEndingConfig(slot0)
	slot0._storyEndingCoDic = {}

	for slot4, slot5 in pairs(slot0._storyEndCoDic.configList) do
		if not slot0._storyEndingCoDic[slot5.belongStoryId] then
			slot0._storyEndingCoDic[slot5.belongStoryId] = {}
		end

		slot6[tonumber(slot5.finalStepId)] = slot5
	end
end

function slot0.getStoryCo(slot0, slot1, slot2)
	return slot0._storyCoDic.configDict[slot1] and slot0._storyCoDic.configDict[slot1][slot2]
end

function slot0.getAllStoryCoList(slot0, slot1)
	if not slot0._storyCoMap[slot1] then
		slot2 = {}

		for slot7, slot8 in pairs(slot0._storyCoDic.configDict[slot1] or {}) do
			table.insert(slot2, slot8)
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.storyId < slot1.storyId
		end)

		slot0._storyCoMap[slot1] = slot2
	end

	return slot2
end

function slot0.getStoryElements(slot0, slot1, slot2)
	if not slot0._storyElementList[slot2] then
		slot0._storyElementList[slot2] = string.splitToNumber(slot0:getStoryCo(slot1, slot2).unlockElementIds1, "#") or {}
	end

	return slot4
end

function slot0.getStepCo(slot0, slot1, slot2)
	return slot0._stepCoDic.configDict[slot2]
end

function slot0.getStoryStepCoList(slot0, slot1, slot2)
	return slot0._storyStepCoDic[slot2]
end

function slot0.getKeywordCo(slot0, slot1, slot2)
	return slot0._keywordsCoDic.configDict[slot2]
end

function slot0.getEndingCo(slot0, slot1, slot2)
	return slot0._storyEndCoDic.configDict[slot2]
end

function slot0.getStoryKeywordCoList(slot0, slot1, slot2)
	slot4 = {}

	if slot0._keywordsCoDic.configList then
		for slot8, slot9 in pairs(slot3) do
			if slot9.belongStoryId == slot2 then
				table.insert(slot4, slot9)
			end
		end
	end

	return slot4
end

function slot0.getEndingCoByFinalStep(slot0, slot1, slot2, slot3)
	if slot0._storyEndingCoDic and slot0._storyEndingCoDic[slot2] and slot0._storyEndingCoDic[slot2][slot3] then
		return slot4
	end
end

function slot0.getEndingCosByStoryId(slot0, slot1, slot2)
	if slot0._storyEndingCoDic then
		return slot0._storyEndingCoDic[slot2]
	end
end

function slot0.getStoryRewardCo(slot0, slot1, slot2, slot3)
	return slot0._rewardCoDic.configDict[slot2][slot3]
end

function slot0.getStoryRewardCoList(slot0, slot1, slot2)
	return slot0._rewardCoDic.configDict[slot2]
end

slot0.instance = slot0.New()

return slot0
