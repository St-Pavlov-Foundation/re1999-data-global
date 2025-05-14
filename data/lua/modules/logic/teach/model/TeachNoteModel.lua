module("modules.logic.teach.model.TeachNoteModel", package.seeall)

local var_0_0 = class("TeachNoteModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._topicId = 0
	arg_1_0._topicIndex = 0
	arg_1_0._teachNoteInfos = {}
	arg_1_0._isJumpEnter = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._topicId = 0
	arg_2_0._topicIndex = 0
	arg_2_0._teachNoteInfos = {}
	arg_2_0._isJumpEnter = false
end

function var_0_0.setTeachNoticeTopicId(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._topicId = arg_3_1
	arg_3_0._topicIndex = arg_3_2
end

function var_0_0.getTeachNoticeTopicId(arg_4_0)
	return arg_4_0._topicId, arg_4_0._topicIndex
end

function var_0_0.getTopicLevelCos(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if iter_5_1.topicId == arg_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = var_0_0.instance:isLevelUnlock(arg_6_0.id)
		local var_6_1 = var_0_0.instance:isLevelUnlock(arg_6_1.id)

		if var_6_0 and not var_6_1 then
			return true
		elseif not var_6_0 and var_6_1 then
			return false
		end

		return arg_6_0.id < arg_6_1.id
	end)

	return var_5_0
end

function var_0_0.setTeachNoteInfo(arg_7_0, arg_7_1)
	arg_7_0._teachNoteInfos = TeachNoteInfoMo.New()

	arg_7_0._teachNoteInfos:init(arg_7_1)
end

function var_0_0.isFinalRewardGet(arg_8_0)
	return arg_8_0._teachNoteInfos.getFinalReward
end

function var_0_0.getNewOpenIndex(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = arg_9_0:getNewOpenTopics()

	if #var_9_1 > 0 then
		var_9_0 = var_9_1[#var_9_1]
	end

	local var_9_2 = 0
	local var_9_3 = arg_9_0:getNewOpenTopicLevels(var_9_0)

	if #var_9_3 > 0 then
		local var_9_4 = var_9_3[#var_9_3]
		local var_9_5 = arg_9_0:getTopicLevelCos(var_9_0)

		for iter_9_0, iter_9_1 in ipairs(var_9_5) do
			if iter_9_1.id == var_9_4 then
				var_9_2 = math.floor(0.5 * (iter_9_0 - 1))
			end
		end
	end

	return var_9_0, var_9_2
end

function var_0_0.isEpisodeOpen(arg_10_0, arg_10_1)
	local var_10_0 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1.episodeId == arg_10_1 then
			for iter_10_2, iter_10_3 in pairs(arg_10_0._teachNoteInfos.openIds) do
				if iter_10_1.id == iter_10_3 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.isTopicNew(arg_11_0, arg_11_1)
	if not arg_11_0:isTopicUnlock(arg_11_1) then
		return false
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0._teachNoteInfos.openIds) do
		if TeachNoteConfig.instance:getInstructionLevelCO(iter_11_1).topicId == arg_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return #var_11_0 < 1
end

function var_0_0.getNewOpenTopics(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = TeachNoteConfig.instance:getInstructionTopicCos()

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if arg_12_0:isTopicNew(iter_12_1.id) then
			table.insert(var_12_0, iter_12_1.id)
		end
	end

	table.sort(var_12_0)

	return var_12_0
end

function var_0_0.getNewOpenTopicLevels(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getNewOpenLevels()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if TeachNoteConfig.instance:getInstructionLevelCO(iter_13_1).topicId == arg_13_1 then
			table.insert(var_13_1, iter_13_1)
		end
	end

	table.sort(var_13_1)

	return var_13_1
end

function var_0_0.getNewOpenLevels(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = TeachNoteConfig.instance:getInstructionLevelCos()

	if #arg_14_0._teachNoteInfos.openIds == 0 then
		return arg_14_0._teachNoteInfos.unlockIds
	else
		for iter_14_0, iter_14_1 in pairs(arg_14_0._teachNoteInfos.unlockIds) do
			local var_14_2 = false

			for iter_14_2, iter_14_3 in pairs(arg_14_0._teachNoteInfos.openIds) do
				if iter_14_1 == iter_14_3 then
					var_14_2 = true
				end
			end

			if not var_14_2 then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0
end

function var_0_0.isLevelNewUnlock(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getNewOpenLevels()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1 == arg_15_1 then
			return true
		end
	end

	return false
end

function var_0_0._getUnlockLevelsByTopicId(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = arg_16_0:getTopicLevelCos(arg_16_1)

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		if arg_16_0:isLevelUnlock(iter_16_1.id) then
			table.insert(var_16_0, iter_16_1.id)
		end
	end

	return var_16_0
end

function var_0_0.isTopicRewardGet(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._teachNoteInfos.getRewardIds) do
		if iter_17_1 == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0.isTopicUnlock(arg_18_0, arg_18_1)
	local var_18_0 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if iter_18_1.topicId == arg_18_1 and arg_18_0:isLevelUnlock(iter_18_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.isRewardCouldGet(arg_19_0, arg_19_1)
	if not arg_19_0:isTopicUnlock(arg_19_1) then
		return false
	end

	local var_19_0 = var_0_0.instance:getTeachNoteTopicLevelCount(arg_19_1)

	if var_0_0.instance:getTeachNoteTopicFinishedLevelCount(arg_19_1) == var_19_0 and not var_0_0.instance:isTopicRewardGet(arg_19_1) then
		return true
	else
		return false
	end
end

function var_0_0.hasRewardCouldGet(arg_20_0)
	local var_20_0 = TeachNoteConfig.instance:getInstructionTopicCos()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if arg_20_0:isTopicUnlock(iter_20_1.id) and arg_20_0:isRewardCouldGet(iter_20_1.id) then
			return true
		end
	end

	if arg_20_0:isTeachNoteFinalRewardCouldGet() then
		return true
	end

	return false
end

function var_0_0.isLevelUnlock(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._teachNoteInfos.unlockIds) do
		if iter_21_1 == arg_21_1 then
			return true
		end
	end

	return false
end

function var_0_0.isTeachNoteUnlock(arg_22_0)
	return arg_22_0._teachNoteInfos and arg_22_0._teachNoteInfos.unlockIds and #arg_22_0._teachNoteInfos.unlockIds > 0 and not arg_22_0:isFinalRewardGet()
end

function var_0_0.isTeachNoteLevelPass(arg_23_0, arg_23_1)
	local var_23_0 = TeachNoteConfig.instance:getInstructionLevelCO(arg_23_1).episodeId

	return (DungeonModel.instance:hasPassLevel(var_23_0))
end

function var_0_0.getTeachNoteTopicUnlockLevelCount(arg_24_0, arg_24_1)
	local var_24_0 = 0
	local var_24_1 = arg_24_0:getTopicLevelCos(arg_24_1)

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		if arg_24_0:isLevelUnlock(iter_24_1.id) then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_0.getTeachNoteTopicFinishedLevelCount(arg_25_0, arg_25_1)
	local var_25_0 = 0
	local var_25_1 = arg_25_0:getTopicLevelCos(arg_25_1)

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		if arg_25_0:isTeachNoteLevelPass(iter_25_1.id) then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function var_0_0.getTeachNoteTopicLevelCount(arg_26_0, arg_26_1)
	return #arg_26_0:getTopicLevelCos(arg_26_1)
end

function var_0_0.isTeachNoteChapter(arg_27_0, arg_27_1)
	local var_27_0 = TeachNoteConfig.instance:getInstructionTopicCos()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1.chapterId == arg_27_1 then
			return true
		end
	end

	return false
end

function var_0_0.isTeachNoteEpisode(arg_28_0, arg_28_1)
	local var_28_0 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if iter_28_1.episodeId == arg_28_1 then
			return true
		end
	end

	return false
end

function var_0_0.getTeachNoteInstructionLevelCo(arg_29_0, arg_29_1)
	local var_29_0 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if iter_29_1.episodeId == arg_29_1 then
			return iter_29_1
		end
	end

	return var_29_0[101]
end

function var_0_0.getTeachNoteEpisodeTopicId(arg_30_0, arg_30_1)
	local var_30_0 = TeachNoteConfig.instance:getInstructionLevelCos()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if iter_30_1.episodeId == arg_30_1 then
			return iter_30_1.topicId
		end
	end

	return 1
end

function var_0_0.isTeachNoteFinalRewardCouldGet(arg_31_0)
	local var_31_0 = TeachNoteConfig.instance:getInstructionTopicCos()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		if not arg_31_0:isTopicRewardGet(iter_31_1.id) then
			return false
		end
	end

	return not arg_31_0:isFinalRewardGet()
end

function var_0_0.isTeachNoteEnterFight(arg_32_0)
	return arg_32_0._isTeachEnter
end

function var_0_0.setTeachNoteEnterFight(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._isTeachEnter = arg_33_1
	arg_33_0._isDetailEnter = arg_33_2
end

function var_0_0.isFinishLevelEnterFight(arg_34_0)
	return arg_34_0._isFinishedEnter
end

function var_0_0.isDetailEnter(arg_35_0)
	return arg_35_0._isDetailEnter
end

function var_0_0.setLevelEnterFightState(arg_36_0, arg_36_1)
	arg_36_0._isFinishedEnter = arg_36_1
end

function var_0_0.isJumpEnter(arg_37_0)
	return arg_37_0._isJumpEnter
end

function var_0_0.setJumpEnter(arg_38_0, arg_38_1)
	arg_38_0._isJumpEnter = arg_38_1
end

function var_0_0.setJumpEpisodeId(arg_39_0, arg_39_1)
	arg_39_0._jumpEpisodeId = arg_39_1
end

function var_0_0.getJumpEpisodeId(arg_40_0)
	return arg_40_0._jumpEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
