module("modules.logic.dungeon.config.RoleStoryConfig", package.seeall)

slot0 = class("RoleStoryConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._roleStoryConfig = nil
	slot0._roleStoryScoreDict = {}
	slot0._roleStoryRewardDict = {}
	slot0._roleStoryRewardConfig = nil
	slot0._roleStoryDispatchDict = {}
	slot0._roleStoryDispatchConfig = nil
	slot0._roleStoryDispatchTalkConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"hero_story",
		"hero_story_score",
		"hero_story_score_reward",
		"hero_story_dispatch",
		"hero_story_dispatch_talk"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "hero_story" then
		slot0._roleStoryConfig = slot2
	elseif slot1 == "hero_story_score" then
		slot0._roleStoryScoreDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._roleStoryScoreDict[slot7.storyId] then
				slot0._roleStoryScoreDict[slot7.storyId] = {}
			end

			slot8 = string.splitToNumber(slot7.wave, "#")

			if slot8[#slot8] then
				table.insert(slot0._roleStoryScoreDict[slot7.storyId], {
					wave = slot8[#slot8],
					score = slot7.score
				})
			end
		end

		for slot6, slot7 in pairs(slot0._roleStoryScoreDict) do
			table.sort(slot7, SortUtil.keyLower("wave"))
		end
	elseif slot1 == "hero_story_score_reward" then
		slot0._roleStoryRewardDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._roleStoryRewardDict[slot7.storyId] then
				slot0._roleStoryRewardDict[slot7.storyId] = {}
			end

			table.insert(slot0._roleStoryRewardDict[slot7.storyId], slot7)
		end

		for slot6, slot7 in pairs(slot0._roleStoryRewardDict) do
			table.sort(slot7, SortUtil.keyLower("score"))
		end

		slot0._roleStoryRewardConfig = slot2
	elseif slot1 == "hero_story_dispatch" then
		slot0._roleStoryDispatchDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._roleStoryDispatchDict[slot7.heroStoryId] then
				slot0._roleStoryDispatchDict[slot7.heroStoryId] = {}
			end

			if not slot0._roleStoryDispatchDict[slot7.heroStoryId][slot7.type] then
				slot0._roleStoryDispatchDict[slot7.heroStoryId][slot7.type] = {}
			end

			table.insert(slot0._roleStoryDispatchDict[slot7.heroStoryId][slot7.type], slot7)
		end

		for slot6, slot7 in pairs(slot0._roleStoryDispatchDict) do
			for slot11, slot12 in pairs(slot7) do
				table.sort(slot12, SortUtil.keyLower("id"))
			end
		end

		slot0._roleStoryDispatchConfig = slot2
	elseif slot1 == "hero_story_dispatch_talk" then
		slot0._roleStoryDispatchTalkConfig = slot2
	end
end

function slot0.getStoryList(slot0)
	return slot0._roleStoryConfig.configList
end

function slot0.getStoryById(slot0, slot1)
	return slot0._roleStoryConfig.configDict[slot1]
end

function slot0.getScoreConfig(slot0, slot1)
	return slot0._roleStoryScoreDict[slot1]
end

function slot0.getRewardList(slot0, slot1)
	return slot0._roleStoryRewardDict[slot1]
end

function slot0.getRewardConfig(slot0, slot1)
	return slot0._roleStoryRewardConfig.configDict[slot1]
end

function slot0.getStoryIdByActivityId(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in pairs(slot0:getStoryList()) do
		if slot8.activityId == slot1 then
			slot3 = slot8.id

			break
		end
	end

	return slot3
end

function slot0.getStoryIdByChapterId(slot0, slot1)
	if slot0:getStoryList() then
		for slot6, slot7 in pairs(slot2) do
			if slot7.chapterId == slot1 then
				return slot7.id
			end
		end
	end
end

function slot0.getDispatchList(slot0, slot1, slot2)
	return slot0._roleStoryDispatchDict[slot1] and slot0._roleStoryDispatchDict[slot1][slot2]
end

function slot0.getDispatchConfig(slot0, slot1)
	return slot0._roleStoryDispatchConfig.configDict[slot1]
end

function slot0.getTalkConfig(slot0, slot1)
	return slot0._roleStoryDispatchTalkConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
