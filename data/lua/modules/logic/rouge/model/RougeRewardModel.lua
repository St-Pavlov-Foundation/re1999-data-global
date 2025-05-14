module("modules.logic.rouge.model.RougeRewardModel", package.seeall)

local var_0_0 = class("RougeRewardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setReward(arg_3_0, arg_3_1)
	if not arg_3_0._season then
		arg_3_0._season = RougeOutsideModel.instance:season()
	end

	if arg_3_1.point then
		arg_3_0.point = arg_3_1.point
	end

	if arg_3_1.bonus then
		if #arg_3_1.bonus.bonusStages > 0 then
			local var_3_0 = arg_3_1.bonus.bonusStages

			arg_3_0:_initStageInfo(var_3_0)
		end

		arg_3_0._isNewStage = arg_3_1.bonus.isNewStage
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function var_0_0.updateReward(arg_4_0, arg_4_1)
	if arg_4_1 and next(arg_4_1) then
		arg_4_0:_updateStageInfo(arg_4_1)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function var_0_0._initStageInfo(arg_5_0, arg_5_1)
	if not arg_5_0._stageInfo then
		arg_5_0._stageInfo = {}
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0:_updateStageInfo(iter_5_1)
	end
end

function var_0_0._updateStageInfo(arg_6_0, arg_6_1)
	if not arg_6_0._stageInfo then
		arg_6_0._stageInfo = {}
	end

	if not arg_6_0._stageInfo[arg_6_1.stage] then
		arg_6_0._stageInfo[arg_6_1.stage] = {}
	end

	arg_6_0._stageInfo[arg_6_1.stage] = arg_6_1.bonusIds
end

function var_0_0.checkCanGetBigReward(arg_7_0, arg_7_1)
	if RougeRewardConfig.instance:getNeedUnlockNum(arg_7_1) > arg_7_0:getLastRewardCounter(arg_7_1) then
		return false
	end

	return true
end

function var_0_0.getRewardPoint(arg_8_0)
	return arg_8_0.point or 0
end

function var_0_0.checkIsNewStage(arg_9_0)
	return arg_9_0._isNewStage
end

function var_0_0.setNewStage(arg_10_0, arg_10_1)
	arg_10_0._isNewStage = arg_10_1
end

function var_0_0.checkRewardCanGet(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0:isStageUnLock(arg_11_1) then
		return
	end

	local var_11_0 = RougeRewardConfig.instance:getConfigById(arg_11_0._season, arg_11_2)

	if var_11_0.type == 3 then
		return true
	end

	local var_11_1 = var_11_0.preId

	if not arg_11_0:checkRewardGot(arg_11_1, var_11_1) then
		return false
	end

	return true
end

function var_0_0.checkRewardGot(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._stageInfo or not next(arg_12_0._stageInfo) then
		return
	end

	if not arg_12_0:isStageUnLock(arg_12_1) then
		return false
	end

	local var_12_0 = arg_12_0._stageInfo[arg_12_1]

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if arg_12_2 == iter_12_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getHadConsumeRewardPoint(arg_13_0)
	local var_13_0 = 0

	if not arg_13_0._stageInfo or #arg_13_0._stageInfo == 0 then
		return 0
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._stageInfo) do
		local var_13_1 = false

		if arg_13_0:checkBigRewardGot(iter_13_0) then
			var_13_1 = true
		end

		if iter_13_1 and #iter_13_1 > 0 then
			var_13_0 = var_13_0 + #iter_13_1
		end

		if var_13_1 and var_13_0 > 0 then
			var_13_0 = var_13_0 - 1
		end
	end

	return var_13_0
end

function var_0_0.getHadGetRewardPoint(arg_14_0)
	local var_14_0 = arg_14_0:getHadConsumeRewardPoint()
	local var_14_1 = var_14_0
	local var_14_2 = arg_14_0:getLastOpenStage()
	local var_14_3 = RougeRewardConfig.instance:getPointLimitByStage(arg_14_0._season, var_14_2)

	if arg_14_0.point then
		local var_14_4 = var_14_0 + arg_14_0.point

		var_14_1 = var_14_3 < var_14_4 and var_14_3 or var_14_4
	end

	return var_14_1
end

function var_0_0.isStageOpen(arg_15_0, arg_15_1)
	if arg_15_1 == 1 or arg_15_1 == 2 then
		return true
	end

	if not arg_15_0._season then
		arg_15_0._season = RougeOutsideModel.instance:season()
	end

	local var_15_0 = RougeRewardConfig.instance:getStageRewardConfigById(arg_15_0._season, arg_15_1)
	local var_15_1 = ServerTime.now()

	if not string.nilorempty(var_15_0.openTime) then
		return var_15_1 >= TimeUtil.stringToTimestamp(var_15_0.openTime)
	end

	return false
end

function var_0_0.setNextUnlockStage(arg_16_0)
	local var_16_0 = RougeRewardConfig.instance:getBigRewardToStage()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1) do
			if not arg_16_0:isStageOpen(iter_16_3.stage) then
				arg_16_0.nextstage = iter_16_3.stage

				break
			end
		end
	end
end

function var_0_0.isShowNextStageTag(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0.nextstage then
		return true
	end

	return false
end

function var_0_0.isStageUnLock(arg_18_0, arg_18_1)
	if not arg_18_0._season then
		arg_18_0._season = RougeOutsideModel.instance:season()
	end

	if arg_18_1 == 1 then
		return true
	end

	if not arg_18_0:isStageOpen(arg_18_1) then
		return false
	end

	local var_18_0 = RougeRewardConfig.instance:getStageRewardConfigById(arg_18_0._season, arg_18_1).preStage

	if arg_18_0:isStageClear(var_18_0) then
		return true
	else
		return false
	end
end

function var_0_0.isStageClear(arg_19_0, arg_19_1)
	if not arg_19_0._stageInfo or #arg_19_0._stageInfo == 0 then
		return
	end

	local var_19_0 = arg_19_0._stageInfo[arg_19_1]

	if not var_19_0 then
		return false
	end

	if RougeRewardConfig.instance:getRewardStageDictNum(arg_19_1) > #var_19_0 then
		return false
	end

	return true
end

function var_0_0.getLastOpenStage(arg_20_0)
	local var_20_0 = RougeOutsideModel.instance:season()
	local var_20_1 = RougeRewardConfig.instance:getStageRewardCount(var_20_0)
	local var_20_2 = 1

	for iter_20_0 = 1, var_20_1 do
		if arg_20_0:isStageOpen(iter_20_0) then
			var_20_2 = iter_20_0
		else
			return var_20_2
		end
	end

	return var_20_2
end

function var_0_0.getLastUnlockStage(arg_21_0)
	local var_21_0 = RougeOutsideModel.instance:season()
	local var_21_1 = RougeRewardConfig.instance:getStageRewardCount(var_21_0)
	local var_21_2 = 1

	for iter_21_0 = 1, var_21_1 do
		if arg_21_0:isStageUnLock(iter_21_0) then
			var_21_2 = iter_21_0
		else
			return var_21_2
		end
	end

	return var_21_2
end

function var_0_0.checkOpenStage(arg_22_0, arg_22_1)
	local var_22_0 = RougeRewardConfig.instance:getBigRewardToStageConfigById(arg_22_1)
	local var_22_1 = false
	local var_22_2

	if arg_22_1 == 1 then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			if arg_22_0:isStageUnLock(iter_22_1.stage) then
				var_22_1 = true
				var_22_2 = iter_22_1.stage
			end
		end
	else
		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			if arg_22_0:isStageOpen(iter_22_3.stage) then
				var_22_1 = true
				var_22_2 = iter_22_3.stage
			end
		end
	end

	if var_22_1 then
		return var_22_2
	end
end

function var_0_0.getLastRewardCounter(arg_23_0, arg_23_1)
	local var_23_0 = 0

	if not arg_23_0._stageInfo or #arg_23_0._stageInfo == 0 then
		return var_23_0
	end

	local var_23_1 = arg_23_0._stageInfo[arg_23_1]

	if not var_23_1 then
		return var_23_0
	end

	local var_23_2 = RougeRewardConfig.instance:getConfigByStage(arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			if iter_23_3.id == iter_23_1 and iter_23_3.type == 2 then
				var_23_0 = var_23_0 + 1
			end
		end
	end

	return var_23_0
end

function var_0_0.checShowBigRewardGot(arg_24_0, arg_24_1)
	local var_24_0 = RougeRewardConfig.instance:getBigRewardToStageConfigById(arg_24_1)
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if arg_24_0:checkBigRewardGot(iter_24_1.stage) then
			var_24_1 = var_24_1 + 1
		end
	end

	if #var_24_0 == var_24_1 then
		return true
	end

	return false
end

function var_0_0.checkBigRewardGot(arg_25_0, arg_25_1)
	if not arg_25_0._stageInfo or #arg_25_0._stageInfo == 0 then
		return false
	end

	local var_25_0 = arg_25_0._stageInfo[arg_25_1]

	if not var_25_0 then
		return false
	end

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if RougeRewardConfig.instance:getConfigById(arg_25_0._season, iter_25_1).type == 1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
