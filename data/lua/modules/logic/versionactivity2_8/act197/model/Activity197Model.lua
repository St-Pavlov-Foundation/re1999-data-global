module("modules.logic.versionactivity2_8.act197.model.Activity197Model", package.seeall)

local var_0_0 = class("Activity197Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._poolDict = {}
	arg_1_0._poolList = {}
	arg_1_0._gainIdsDict = {}
	arg_1_0._poolGetBigList = {}
	arg_1_0._currentPoolId = 1
	arg_1_0._rummageTimes = 0
	arg_1_0._exploreTimes = 0
	arg_1_0._showBubbleVx = false
	arg_1_0._currentBubbleCount = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.setActInfo(arg_3_0, arg_3_1)
	arg_3_0._actId = arg_3_1.activityId

	local var_3_0 = arg_3_1.hasGain

	if var_3_0 and #var_3_0 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			table.insert(arg_3_0._poolList, iter_3_1.poolId)

			arg_3_0._gainIdsDict[iter_3_1.poolId] = iter_3_1.gainIds

			arg_3_0:setGetBigRewardList(iter_3_1)
		end
	end

	arg_3_0:_initCurrency()
end

function var_0_0.setGetBigRewardList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.gainIds

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if Activity197Enum.BigGainId == iter_4_1 then
			arg_4_0._poolGetBigList[arg_4_1.poolId] = true
			arg_4_0._currentPoolId = iter_4_1
		end
	end
end

function var_0_0.checkPoolGetBigReward(arg_5_0, arg_5_1)
	if #arg_5_0._poolGetBigList > 0 and arg_5_0._poolGetBigList[arg_5_1] then
		return true
	end

	return false
end

function var_0_0.updatePool(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._gainIdsDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = {}
		arg_6_0._gainIdsDict[arg_6_1] = var_6_0
	end

	table.insert(var_6_0, arg_6_2)

	if Activity197Enum.BigGainId == arg_6_2 then
		arg_6_0._poolGetBigList[arg_6_1] = true
	end

	arg_6_0:_initCurrency()
	Activity197Controller.instance:dispatchEvent(Activity197Event.UpdateSingleItem, {
		poolId = arg_6_1,
		gainId = arg_6_2
	})
end

function var_0_0.checkRewardReceied(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._gainIdsDict[arg_7_1]

	if not var_7_0 then
		return false
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 == arg_7_2 then
			return true
		end
	end

	return false
end

function var_0_0.checkPoolGetAllReward(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._gainIdsDict[arg_8_1]

	if not var_8_0 then
		return false
	end

	if Activity197Config.instance:getPoolRewardCount(arg_8_1) > #var_8_0 then
		return false
	end

	return true
end

function var_0_0.getLastOpenPoolId(arg_9_0)
	local var_9_0 = Activity197Config.instance:getPoolList()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if arg_9_0:checkPoolOpen(iter_9_1) then
			var_9_1 = var_9_1 + 1
		end
	end

	return var_9_1
end

function var_0_0.checkPoolOpen(arg_10_0, arg_10_1)
	if arg_10_1 == 1 then
		return true
	end

	local var_10_0 = arg_10_1 - 1

	if arg_10_0:checkPoolGetBigReward(var_10_0) and arg_10_1 <= Activity197Config.instance:getPoolCount() then
		return true
	end

	return false
end

function var_0_0.setCurrentPoolId(arg_11_0, arg_11_1)
	arg_11_0._currentPoolId = arg_11_1
end

function var_0_0.getCurrentPoolId(arg_12_0)
	return arg_12_0._currentPoolId or 1
end

function var_0_0.getCurrentPool(arg_13_0)
	return arg_13_0._gainIdsDict[arg_13_0._currentPoolId]
end

function var_0_0._initCurrency(arg_14_0)
	local var_14_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.KeyCurrency)
	local var_14_1 = var_14_0 and var_14_0.quantity or 0
	local var_14_2 = Activity197Config.instance:getRummageConsume()

	arg_14_0._rummageTimes = var_14_1 >= tonumber(var_14_2) and math.floor(var_14_1 / tonumber(var_14_2)) or 0

	local var_14_3 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.BulbCurrency)
	local var_14_4 = var_14_3 and var_14_3.quantity or 0

	if not arg_14_0._currentBubbleCount then
		arg_14_0._currentBubbleCount = var_14_4
	elseif var_14_4 > arg_14_0._currentBubbleCount then
		arg_14_0._showBubbleVx = true
		arg_14_0._currentBubbleCount = var_14_4
	end

	local var_14_5 = Activity197Config.instance:getExploreConsume()

	arg_14_0._exploreTimes = var_14_4 >= tonumber(var_14_5) and math.floor(var_14_4 / tonumber(var_14_5)) or 0
end

function var_0_0.canRummage(arg_15_0)
	return arg_15_0._rummageTimes > 0
end

function var_0_0.canExplore(arg_16_0)
	return arg_16_0._exploreTimes > 0
end

function var_0_0.getExploreTimes(arg_17_0)
	return arg_17_0._exploreTimes
end

function var_0_0.getOnceExploreKeyCount(arg_18_0)
	return arg_18_0._exploreTimes * Activity197Config.instance:getExploreGetCount()
end

function var_0_0.checkStageOpen(arg_19_0, arg_19_1)
	local var_19_0 = Activity197Config.instance:getStageConfig(arg_19_1, 1)
	local var_19_1 = var_19_0 and var_19_0.startTime or 0
	local var_19_2 = var_19_0 and var_19_0.endTime or 0
	local var_19_3 = TimeUtil.stringToTimestamp(var_19_1)
	local var_19_4 = TimeUtil.stringToTimestamp(var_19_2)
	local var_19_5 = ServerTime.now()

	return var_19_3 <= var_19_5 and var_19_5 <= var_19_4
end

function var_0_0.checkBigRewardHasGet(arg_20_0)
	local var_20_0 = Activity197Config.instance:getStageConfig(arg_20_0._actId, 1)
	local var_20_1 = var_20_0 and var_20_0.globalTaskId or 0
	local var_20_2 = TaskModel.instance:getTaskById(var_20_1)

	return var_20_2 and var_20_2:isClaimed()
end

function var_0_0.checkBigRewardCanGet(arg_21_0)
	local var_21_0 = Activity197Config.instance:getStageConfig(arg_21_0._actId, 1)
	local var_21_1 = var_21_0 and var_21_0.globalTaskId or 0
	local var_21_2 = TaskModel.instance:getTaskById(var_21_1)

	return var_21_2 and var_21_2:isClaimable()
end

function var_0_0.isTaskReceive(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return false
	end

	return arg_22_1.finishCount > 0 and arg_22_1.progress >= arg_22_1.config.maxProgress
end

function var_0_0.getStageProgress(arg_23_0, arg_23_1)
	local var_23_0 = Activity197Config.instance:getStageConfig(arg_23_1, 1)
	local var_23_1 = var_23_0 and var_23_0.globalTaskActivityId or 0
	local var_23_2 = var_23_0 and var_23_0.globalTaskId or 0
	local var_23_3 = TaskModel.instance:getTaskById(var_23_2)
	local var_23_4 = var_23_3 and var_23_3.progress or 0
	local var_23_5 = Activity173Config.instance:getGlobalVisibleTaskStagesByActId(var_23_1)
	local var_23_6 = var_23_5 and #var_23_5 or 0
	local var_23_7 = 0
	local var_23_8 = 1 / (var_23_6 - 1)
	local var_23_9

	for iter_23_0 = 1, var_23_6 do
		local var_23_10 = var_23_5[iter_23_0]
		local var_23_11 = var_23_10.endValue
		local var_23_12 = var_23_5[iter_23_0 - 1] or var_23_10
		local var_23_13 = var_23_12 and var_23_12.endValue or 0
		local var_23_14 = var_23_4 - var_23_13
		local var_23_15 = var_23_11 - var_23_13

		var_23_7 = var_23_7 + (var_23_15 ~= 0 and GameUtil.clamp(var_23_14 / var_23_15, 0, 1) or 0) * var_23_8
	end

	return var_23_7
end

function var_0_0.getLastStageEndTime(arg_24_0, arg_24_1)
	local var_24_0 = Activity197Config.instance:getStageConfig(arg_24_1, 1)
	local var_24_1 = var_24_0 and var_24_0.globalTaskActivityId or 0
	local var_24_2 = var_24_0 and var_24_0.globalTaskId or 0
	local var_24_3 = TaskModel.instance:getTaskById(var_24_2)
	local var_24_4 = var_24_3 and var_24_3.progress or 0
	local var_24_5 = Activity173Config.instance:getGlobalVisibleTaskStagesByActId(var_24_1)
	local var_24_6 = var_24_5 and #var_24_5 or 0
	local var_24_7 = 0

	for iter_24_0 = 1, var_24_6 do
		local var_24_8 = var_24_5[iter_24_0]

		if var_24_4 < var_24_8.endValue then
			var_24_7 = var_24_8.endTime
		end
	end

	return TimeUtil.stringToTimestamp(var_24_7)
end

function var_0_0.getShowBubbleVx(arg_25_0)
	return arg_25_0._showBubbleVx
end

function var_0_0.resetShowBubbleVx(arg_26_0)
	arg_26_0._showBubbleVx = false
end

function var_0_0.checkAllPoolRewardGet(arg_27_0)
	local var_27_0 = Activity197Config.instance:getPoolList()

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if not arg_27_0:checkPoolGetAllReward(iter_27_1) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
