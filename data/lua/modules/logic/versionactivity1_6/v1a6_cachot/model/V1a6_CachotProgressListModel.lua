module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListModel", package.seeall)

local var_0_0 = class("V1a6_CachotProgressListModel", MixScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._totalScore = nil
	arg_1_0._weekScore = nil
	arg_1_0._curStage = nil
	arg_1_0._nextStageSecond = nil
	arg_1_0._canReceiveRewardList = nil
	arg_1_0._totalRewardCount = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initDatas(arg_3_0)
	arg_3_0:onInit()
	arg_3_0:buildProgressData()
	arg_3_0:buildScrollList()
	arg_3_0:checkDoubleStoreRefreshRed()
	arg_3_0:checkRewardStageChangeRed()
end

function var_0_0.buildProgressData(arg_4_0)
	local var_4_0 = V1a6_CachotModel.instance:getRogueStateInfo()

	arg_4_0._totalScore = var_4_0 and var_4_0.totalScore or 0
	arg_4_0._weekScore = var_4_0 and var_4_0.weekScore or 0
	arg_4_0._curStage = var_4_0 and var_4_0.stage or 0
	arg_4_0._nextStageSecond = var_4_0 and tonumber(var_4_0.nextStageSecond) or 0
	arg_4_0._rewardStateMap = arg_4_0:buildRewardsStateMap(var_4_0)
end

function var_0_0.buildRewardsStateMap(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = arg_5_1 and arg_5_1.getRewards

	arg_5_0._canReceiveRewardList = {}
	arg_5_0._totalRewardCount = 0
	arg_5_0._unLockedRewardCount = 0

	local var_5_2 = V1a6_CachotScoreConfig.instance:getConfigList()

	if var_5_2 then
		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			local var_5_3 = V1a6_CachotEnum.MilestonesState.Locked

			if arg_5_0._curStage >= iter_5_1.stage then
				if iter_5_1.score <= arg_5_0._totalScore then
					local var_5_4 = tabletool.indexOf(var_5_1, iter_5_1.id) ~= nil

					var_5_3 = var_5_4 and V1a6_CachotEnum.MilestonesState.HasReceived or V1a6_CachotEnum.MilestonesState.CanReceive

					if not var_5_4 then
						table.insert(arg_5_0._canReceiveRewardList, iter_5_1.id)
					end
				else
					var_5_3 = V1a6_CachotEnum.MilestonesState.UnFinish
				end

				arg_5_0._unLockedRewardCount = arg_5_0._unLockedRewardCount + 1
			end

			var_5_0[iter_5_1.id] = var_5_3
			arg_5_0._totalRewardCount = arg_5_0._totalRewardCount + 1
		end
	end

	return var_5_0
end

function var_0_0.buildScrollList(arg_6_0)
	local var_6_0 = V1a6_CachotScoreConfig.instance:getConfigList()

	if var_6_0 then
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_2 = arg_6_0:getRewardState(iter_6_1.id) == V1a6_CachotEnum.MilestonesState.Locked
			local var_6_3 = V1a6_CachotProgressListMO.New()

			var_6_3:init(iter_6_0, iter_6_1.id, var_6_2)
			table.insert(var_6_1, var_6_3)

			if var_6_2 then
				break
			end
		end

		arg_6_0:setList(var_6_1)
	end
end

local var_0_1 = {
	Unlocked = 2,
	Locked = 1
}

function var_0_0.getInfoList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = iter_7_1.isLocked and var_0_1.Locked or var_0_1.Unlocked
		local var_7_3 = SLFramework.UGUI.MixCellInfo.New(var_7_2, iter_7_1:getLineWidth(), iter_7_0)

		table.insert(var_7_0, var_7_3)
	end

	return var_7_0
end

function var_0_0.getCurGetTotalScore(arg_8_0)
	return arg_8_0._totalScore or 0
end

function var_0_0.getWeekScore(arg_9_0)
	return arg_9_0._weekScore or 0
end

function var_0_0.getCurrentStage(arg_10_0)
	return arg_10_0._curStage or 0
end

function var_0_0.getRewardState(arg_11_0, arg_11_1)
	if arg_11_0._rewardStateMap then
		return arg_11_0._rewardStateMap[arg_11_1] or V1a6_CachotEnum.MilestonesState.Locked
	end
end

function var_0_0.getCurFinishRewardCount(arg_12_0)
	local var_12_0 = V1a6_CachotModel.instance:getRogueStateInfo()
	local var_12_1 = 0
	local var_12_2 = arg_12_0._canReceiveRewardList and #arg_12_0._canReceiveRewardList or 0

	if var_12_0 and var_12_0.getRewards then
		var_12_1 = #var_12_0.getRewards
	end

	return var_12_2 + var_12_1
end

function var_0_0.getTotalRewardCount(arg_13_0)
	return arg_13_0._totalRewardCount or 0
end

function var_0_0.getUnLockedRewardCount(arg_14_0)
	return arg_14_0._unLockedRewardCount or 0
end

function var_0_0.isAllRewardUnLocked(arg_15_0)
	return arg_15_0:getTotalRewardCount() <= arg_15_0:getUnLockedRewardCount()
end

function var_0_0.getHasFinishedMoList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = arg_16_0:getList()

	if var_16_1 then
		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			if arg_16_0:getRewardState(iter_16_1.id) == V1a6_CachotEnum.MilestonesState.HasReceived then
				table.insert(var_16_0, iter_16_1)
			end
		end
	end

	return var_16_0
end

function var_0_0.getCanReceivePartIdList(arg_17_0)
	return arg_17_0._canReceiveRewardList
end

function var_0_0.getUnLockNextStageRemainTime(arg_18_0)
	return arg_18_0._nextStageSecond
end

function var_0_0.updateUnLockNextStageRemainTime(arg_19_0, arg_19_1)
	if arg_19_0._nextStageSecond then
		arg_19_1 = tonumber(arg_19_1) or 0
		arg_19_0._nextStageSecond = arg_19_0._nextStageSecond - arg_19_1
	end
end

function var_0_0.checkRed(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}
	local var_20_1 = arg_20_2(arg_20_0)

	table.insert(var_20_0, {
		id = arg_20_1,
		value = var_20_1 and 1 or 0
	})

	if arg_20_3 then
		table.insert(var_20_0, {
			id = arg_20_3,
			value = var_20_1 and 1 or 0
		})
	end

	return var_20_0
end

function var_0_0.checkRewardStageChangeRed(arg_21_0)
	local var_21_0 = arg_21_0:checkRed(RedDotEnum.DotNode.V1a6RogueRewardStage, arg_21_0.checkRewardStageChange) or {}

	RedDotRpc.instance:clientAddRedDotGroupList(var_21_0, true)
end

function var_0_0.checkRewardStageChange(arg_22_0)
	local var_22_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage
	local var_22_1 = PlayerPrefsHelper.getNumber(var_22_0, 0)

	if arg_22_0._curStage ~= nil then
		if var_22_1 == 0 then
			PlayerPrefsHelper.setNumber(var_22_0, arg_22_0._curStage)
		elseif var_22_1 < arg_22_0._curStage then
			return true
		end
	end

	return false
end

function var_0_0.checkDoubleStoreRefreshRed(arg_23_0)
	local var_23_0 = arg_23_0:checkRed(RedDotEnum.DotNode.V1a6RogueDoubleScore, arg_23_0.checkDoubleStoreRefresh) or {}

	RedDotRpc.instance:clientAddRedDotGroupList(var_23_0, true)
end

function var_0_0.checkDoubleStoreRefresh(arg_24_0)
	local var_24_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore
	local var_24_1 = ServerTime.now()
	local var_24_2 = PlayerPrefsHelper.getString(var_24_0, "")

	if arg_24_0._weekScore ~= nil then
		if var_24_2 == "" then
			PlayerPrefsHelper.setNumber(var_24_0, var_24_1)
		else
			local var_24_3 = TimeUtil.OneDaySecond * 7 + var_24_2

			if arg_24_0._weekScore == 0 and var_24_3 < var_24_1 then
				return true
			end
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
