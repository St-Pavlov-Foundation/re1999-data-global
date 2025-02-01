module("modules.logic.rouge.config.RougeRewardConfig", package.seeall)

slot0 = class("RougeRewardConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_reward",
		"rouge_reward_stage"
	}
end

function slot0.onInit(slot0)
	slot0._rewardDict = {}
	slot0._rewardList = {}
	slot0._stageRewardDict = nil
	slot0._bigRewardToStage = {}
	slot0._stageToLayout = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_reward_stage" then
		slot0._stageRewardDict = slot2.configDict

		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.bigRewardId then
				if slot0._bigRewardToStage[slot7.bigRewardId] == nil then
					slot0._bigRewardToStage[slot7.bigRewardId] = {}
				end

				table.insert(slot0._bigRewardToStage[slot7.bigRewardId], slot7)
			end
		end
	end

	if slot1 == "rouge_reward" then
		for slot6, slot7 in ipairs(slot2.configList) do
			if slot7.stage then
				if slot0._rewardDict[slot7.stage] == nil then
					slot0._rewardDict[slot7.stage] = {}
				end

				table.insert(slot0._rewardDict[slot7.stage], slot7)
			end
		end

		slot0._rewardList = slot2.configDict
	end

	slot0:_buildRewardByLayout()
end

function slot0._buildRewardByLayout(slot0)
	for slot4, slot5 in ipairs(slot0._rewardDict) do
		if #slot5 ~= 0 then
			if slot0._stageToLayout[slot4] == nil then
				slot0._stageToLayout[slot4] = {}
			end

			for slot9, slot10 in ipairs(slot5) do
				if slot10.pos and slot10.pos ~= "" then
					if slot0._stageToLayout[slot4][tonumber(string.split(slot10.pos, "#")[1])] == nil then
						slot0._stageToLayout[slot4][slot12] = {}
					end

					if not tabletool.indexOf(slot0._stageToLayout[slot4][slot12], slot10) then
						table.insert(slot0._stageToLayout[slot4][slot12], slot10)
					end
				end
			end
		end
	end
end

function slot0.getStageToLayourConfig(slot0, slot1, slot2)
	return slot0._stageToLayout[slot1][slot2]
end

function slot0.getRewardDict(slot0)
	return slot0._rewardDict
end

function slot0.getConfigById(slot0, slot1, slot2)
	return slot0._rewardList[slot1][slot2]
end

function slot0.getRewardStageDictNum(slot0, slot1)
	return #slot0._rewardDict[slot1]
end

function slot0.getConfigByStage(slot0, slot1)
	if slot0._rewardDict and slot0._rewardDict[slot1] then
		return slot0._rewardDict[slot1]
	end
end

function slot0.getConfigByStageAndId(slot0, slot1, slot2)
	if slot0._rewardDict and slot0._rewardDict[slot1] then
		return slot0._rewardDict[slot1][slot2]
	end
end

function slot0.getBigRewardConfigByStage(slot0, slot1)
	if slot0._rewardDict and slot0._rewardDict[slot1] then
		for slot5, slot6 in ipairs(slot0._rewardDict[slot1]) do
			if slot6 and slot6.type == 1 then
				return slot6
			end
		end
	end
end

function slot0.getStageCount(slot0)
	return #slot0._rewardDict
end

function slot0.getStageLayoutCount(slot0, slot1)
	return #slot0._stageToLayout[slot1]
end

function slot0.getPointLimitByStage(slot0, slot1, slot2)
	return slot0:getStageRewardConfigById(slot1, slot2).pointLimit
end

function slot0.getNeedUnlockNum(slot0, slot1)
	slot3 = 0

	if slot0:getConfigByStage(slot1) then
		for slot7, slot8 in ipairs(slot2) do
			if slot8.type and slot8.type == 2 then
				slot3 = slot3 + 1
			end
		end
	end

	return slot3
end

function slot0.getCurStageBigRewardConfig(slot0, slot1)
	if not slot0:getConfigByStage(slot1) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7 and slot7.type == 1 then
			return slot7
		end
	end
end

function slot0.getStageRewardCount(slot0, slot1)
	return #slot0._stageRewardDict[slot1]
end

function slot0.getStageRewardConfig(slot0, slot1)
	return slot0._stageRewardDict[slot1]
end

function slot0.getStageRewardConfigById(slot0, slot1, slot2)
	return slot0._stageRewardDict[slot1][slot2]
end

function slot0.getBigRewardToStageConfigById(slot0, slot1)
	return slot0._bigRewardToStage[slot1]
end

function slot0.getBigRewardToStage(slot0)
	return slot0._bigRewardToStage
end

slot0.instance = slot0.New()

return slot0
