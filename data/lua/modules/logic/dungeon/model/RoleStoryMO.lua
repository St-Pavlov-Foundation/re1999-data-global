module("modules.logic.dungeon.model.RoleStoryMO", package.seeall)

local var_0_0 = pureTable("RoleStoryMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.progress = 0
	arg_1_0.getReward = false
	arg_1_0.cfg = RoleStoryConfig.instance:getStoryById(arg_1_1)
	arg_1_0.order = arg_1_0.cfg.order
	arg_1_0.maxProgress, arg_1_0.episodeCount = arg_1_0:caleMaxProgress()
	arg_1_0.hasUnlock = false
	arg_1_0.startTime = 0
	arg_1_0.endTime = 0
	arg_1_0.startTimeResident = 0
	arg_1_0.endTimeResident = 0
	arg_1_0.rewards = GameUtil.splitString2(arg_1_0.cfg.bonus, true)
	arg_1_0.getScoreBonus = {}
	arg_1_0.score = 0
	arg_1_0.addscore = 0
	arg_1_0.wave = 0
	arg_1_0.maxWave = 1
	arg_1_0.getChallengeReward = false

	arg_1_0:refreshOrder()

	arg_1_0.dispatchDict = {}
	arg_1_0._dispatchHeroDict = {}
end

function var_0_0.getCost(arg_2_0)
	if arg_2_0:isActTime() then
		local var_2_0 = string.splitToNumber(arg_2_0.cfg.unlock, "#")

		return var_2_0[1], var_2_0[2], var_2_0[3]
	end

	local var_2_1 = string.splitToNumber(arg_2_0.cfg.permanentUnlock, "#")

	return var_2_1[1], var_2_1[2], var_2_1[3]
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.progress = arg_3_1.progress
	arg_3_0.getReward = arg_3_1.getReward
	arg_3_0.hasUnlock = arg_3_1.unlock
	arg_3_0.getScoreBonus = {}

	arg_3_0:addScoreBonus(arg_3_1.getScoreBonus)

	arg_3_0.score = arg_3_1.score
	arg_3_0.wave = arg_3_1.challengeWave
	arg_3_0.maxWave = arg_3_1.challengeMaxWave
	arg_3_0.getChallengeReward = arg_3_1.getChallengeReward

	arg_3_0:refreshOrder()

	arg_3_0.dispatchDict = {}

	for iter_3_0 = 1, #arg_3_1.dispatchInfos do
		arg_3_0:updateDispatch(arg_3_1.dispatchInfos[iter_3_0])
	end

	arg_3_0:updateDispatchHeroDict()
end

function var_0_0.updateDispatch(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_1.id

	arg_4_0:getDispatchMo(var_4_0):updateInfo(arg_4_1)
end

function var_0_0.updateDispatchTime(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_1.dispatchId

	arg_5_0:getDispatchMo(var_5_0):updateTime(arg_5_1)

	for iter_5_0 = 1, #arg_5_1.dispatchInfos do
		arg_5_0:updateDispatch(arg_5_1.dispatchInfos[iter_5_0])
	end

	arg_5_0:updateDispatchHeroDict()
end

function var_0_0.resetDispatch(arg_6_0, arg_6_1)
	arg_6_0:getDispatchMo(arg_6_1.dispatchId):resetDispatch()
	arg_6_0:updateDispatchHeroDict()
end

function var_0_0.completeDispatch(arg_7_0, arg_7_1)
	arg_7_0:getDispatchMo(arg_7_1.dispatchId):completeDispatch()
	arg_7_0:updateDispatchHeroDict()
end

function var_0_0.updateTime(arg_8_0, arg_8_1)
	arg_8_0.startTime = arg_8_1.startTime
	arg_8_0.endTime = arg_8_1.endTime
	arg_8_0.startTimeResident = arg_8_1.startTimeResident
	arg_8_0.endTimeResident = arg_8_1.endTimeResident
end

function var_0_0.updateScore(arg_9_0, arg_9_1)
	arg_9_0.addscore = arg_9_1.score - arg_9_0.score
	arg_9_0.score = arg_9_1.score
	arg_9_0.wave = arg_9_1.wave
	arg_9_0.maxWave = arg_9_1.maxWave
end

function var_0_0.refreshOrder(arg_10_0)
	arg_10_0.getRewardOrder = arg_10_0.getReward and 0 or 1
	arg_10_0.getUnlockOrder = arg_10_0.hasUnlock and 0 or 1
	arg_10_0.hasRewardUnget = arg_10_0:canGetReward() and 1 or 0
end

function var_0_0.caleMaxProgress(arg_11_0)
	local var_11_0 = arg_11_0.cfg.chapterId
	local var_11_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_11_0)
	local var_11_2 = 0
	local var_11_3 = 0

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			var_11_2 = var_11_2 + 1
			var_11_3 = var_11_3 + 1
		end
	end

	return var_11_2, var_11_3
end

function var_0_0.canGetReward(arg_12_0)
	if not arg_12_0.hasUnlock then
		return false
	end

	if arg_12_0.getReward then
		return false
	end

	if arg_12_0.progress and arg_12_0.maxProgress then
		return arg_12_0.progress >= arg_12_0.maxProgress
	end

	return false
end

function var_0_0.getActTime(arg_13_0)
	return arg_13_0.startTime, arg_13_0.endTime
end

function var_0_0.getResidentTime(arg_14_0)
	return arg_14_0.startTimeResident, arg_14_0.endTimeResident
end

function var_0_0.isActTime(arg_15_0)
	local var_15_0 = ServerTime.now()

	return var_15_0 >= arg_15_0.startTime and var_15_0 <= arg_15_0.endTime
end

function var_0_0.isResidentTime(arg_16_0)
	local var_16_0 = ServerTime.now()

	return var_16_0 >= arg_16_0.startTimeResident and var_16_0 <= arg_16_0.endTimeResident
end

function var_0_0.addScoreBonus(arg_17_0, arg_17_1)
	if arg_17_1 then
		for iter_17_0 = 1, #arg_17_1 do
			arg_17_0.getScoreBonus[arg_17_1[iter_17_0]] = true
		end
	end
end

function var_0_0.isBonusHasGet(arg_18_0, arg_18_1)
	return arg_18_0.getScoreBonus[arg_18_1]
end

function var_0_0.getScore(arg_19_0)
	return arg_19_0.score
end

function var_0_0.getAddScore(arg_20_0)
	return arg_20_0.addscore
end

function var_0_0.hasScoreReward(arg_21_0)
	local var_21_0 = false
	local var_21_1 = RoleStoryConfig.instance:getRewardList(arg_21_0.id)

	if var_21_1 then
		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			if arg_21_0.score >= iter_21_1.score and not arg_21_0:isBonusHasGet(iter_21_1.id) then
				var_21_0 = true

				break
			end
		end
	end

	return var_21_0
end

function var_0_0.getDispatchMo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.dispatchDict[arg_22_1]

	if not var_22_0 then
		var_22_0 = RoleStoryDispatchMO.New()

		var_22_0:init(arg_22_1, arg_22_0.id)

		arg_22_0.dispatchDict[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.getDispatchState(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getDispatchMo(arg_23_1)

	if var_23_0 then
		return var_23_0:getDispatchState()
	end
end

function var_0_0.getNormalDispatchList(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.dispatchDict) do
		if iter_24_1.config.type == RoleStoryEnum.DispatchType.Normal then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.isScoreFull(arg_25_0)
	local var_25_0 = RoleStoryConfig.instance:getRewardList(arg_25_0.id)
	local var_25_1 = var_25_0 and var_25_0[#var_25_0]

	if not var_25_1 then
		return true
	end

	return arg_25_0.score >= var_25_1.score
end

function var_0_0.updateDispatchHeroDict(arg_26_0)
	arg_26_0._dispatchHeroDict = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.dispatchDict) do
		if iter_26_1:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
			for iter_26_2, iter_26_3 in pairs(iter_26_1.heroIds) do
				arg_26_0._dispatchHeroDict[iter_26_3] = true
			end
		end
	end
end

function var_0_0.isHeroDispatching(arg_27_0, arg_27_1)
	return arg_27_0._dispatchHeroDict[arg_27_1]
end

function var_0_0.hasNewDispatchFinish(arg_28_0)
	local var_28_0 = false

	for iter_28_0, iter_28_1 in pairs(arg_28_0.dispatchDict) do
		if iter_28_1:isNewFinish() then
			var_28_0 = true
		end
	end

	return var_28_0
end

function var_0_0.canPlayNormalDispatchUnlockAnim(arg_29_0)
	local var_29_0 = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, arg_29_0.id)

	return PlayerPrefsHelper.getNumber(var_29_0, 0) == 0
end

function var_0_0.setPlayNormalDispatchUnlockAnimFlag(arg_30_0)
	local var_30_0 = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, arg_30_0.id)

	PlayerPrefsHelper.setNumber(var_30_0, 1)
end

return var_0_0
