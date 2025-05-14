module("modules.logic.summon.model.SummonPoolHistoryModel", package.seeall)

local var_0_0 = class("SummonPoolHistoryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._dataList = {}
	arg_1_0._allMaxNum = 0
	arg_1_0._getNextTime = 0
	arg_1_0._typeNums = {}
	arg_1_0._requestPools = {}
	arg_1_0._token = nil
	arg_1_0._tokenEndTime = 0
	arg_1_0._summonShowTypeDic = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._dataList = {}
	arg_2_0._allMaxNum = 0
	arg_2_0._getNextTime = 0
	arg_2_0._typeNums = {}
	arg_2_0._requestPools = {}
	arg_2_0._token = nil
	arg_2_0._tokenEndTime = 0
	arg_2_0._summonShowTypeDic = nil
end

function var_0_0.isDataValidity(arg_3_0)
	if arg_3_0._getNextTime > Time.time then
		return true
	end

	return false
end

function var_0_0.onGetInfo(arg_4_0, arg_4_1)
	if arg_4_1 == nil or arg_4_1.pageData == nil or #arg_4_1.pageData < 1 then
		if arg_4_0._allMaxNum > 0 then
			arg_4_0:reInit()
		end

		return
	end

	arg_4_0._dataList = arg_4_1.pageData

	local var_4_0 = 0
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._dataList) do
		iter_4_1.gainIds = iter_4_1.gainIds or {}
		iter_4_1.gainHeroList = iter_4_1.gainHeroList or {}

		if iter_4_1.luckyBagIds ~= nil and #iter_4_1.luckyBagIds > 0 then
			iter_4_1.luckyBagIdSet = {}

			for iter_4_2, iter_4_3 in ipairs(iter_4_1.luckyBagIds) do
				iter_4_1.luckyBagIdSet[iter_4_3] = true
			end
		end

		local var_4_2 = arg_4_0:_getShowPoolType(iter_4_1.poolId, iter_4_1.poolType)

		if var_4_2 then
			var_4_0 = var_4_0 + #iter_4_1.gainIds

			if not var_4_1[var_4_2] then
				var_4_1[var_4_2] = 0
			end

			var_4_1[var_4_2] = var_4_1[var_4_2] + #iter_4_1.gainIds
		end
	end

	arg_4_0._allMaxNum = var_4_0
	arg_4_0._typeNums = var_4_1
	arg_4_0._getNextTime = Time.time + 600
end

function var_0_0.getShowPoolTypeByPoolId(arg_5_0, arg_5_1)
	local var_5_0 = SummonConfig.instance:getSummonPool(arg_5_1)

	return var_5_0 and arg_5_0:_getShowPoolType(arg_5_1, var_5_0.type)
end

function var_0_0._getShowPoolType(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._summonShowTypeDic then
		arg_6_0._summonShowTypeDic = {}

		local var_6_0 = SummonConfig.instance:getSummonPoolList()

		for iter_6_0 = 1, #var_6_0 do
			local var_6_1 = var_6_0[iter_6_0]

			if var_6_1.historyShowType and var_6_1.historyShowType ~= 0 and SummonConfig.instance:getPoolDetailConfig(var_6_1.historyShowType) then
				arg_6_0._summonShowTypeDic[var_6_1.id] = var_6_1.historyShowType
			end
		end
	end

	return arg_6_0._summonShowTypeDic[arg_6_1] or arg_6_2
end

function var_0_0.getNumByPoolId(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return 0
	end

	return arg_7_0._typeNums[arg_7_1] or 0
end

function var_0_0.updateSummonResult(arg_8_0, arg_8_1)
	if arg_8_1 and #arg_8_1 > 0 then
		local var_8_0 = Time.time + 300

		if arg_8_0._getNextTime == nil or var_8_0 < arg_8_0._getNextTime then
			arg_8_0._getNextTime = var_8_0
		end
	end
end

function var_0_0.getHistoryListByIndexOf(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._dataList) do
		if arg_9_3 == arg_9_0:_getShowPoolType(iter_9_1.poolId, iter_9_1.poolType) then
			if arg_9_1 <= var_9_1 then
				arg_9_0:_addHistoryToList(var_9_0, iter_9_1, 1 - arg_9_1, arg_9_2 - #var_9_0)
			elseif var_9_1 < arg_9_1 and arg_9_1 <= var_9_1 + #iter_9_1.gainIds then
				arg_9_0:_addHistoryToList(var_9_0, iter_9_1, arg_9_1 - var_9_1, arg_9_2 - #var_9_0)
			end

			var_9_1 = var_9_1 + #iter_9_1.gainIds
		end

		if arg_9_2 <= #var_9_0 then
			break
		end
	end

	return var_9_0
end

function var_0_0._addHistoryToList(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_2.gainIds or #arg_10_2.gainIds < 1 then
		return
	end

	local var_10_0 = #arg_10_2.gainIds

	arg_10_1 = arg_10_1 or {}
	arg_10_3 = math.max(1, arg_10_3)

	local var_10_1 = arg_10_3 + arg_10_4
	local var_10_2 = math.min(var_10_1, var_10_0)

	for iter_10_0 = arg_10_3, var_10_2 do
		local var_10_3 = var_10_0 - iter_10_0 + 1
		local var_10_4 = arg_10_2.gainIds[var_10_3]
		local var_10_5 = {
			createTime = arg_10_2.createTime,
			summonType = arg_10_2.summonType,
			poolName = arg_10_2.poolName,
			gainId = var_10_4,
			poolId = arg_10_2.poolId,
			poolType = arg_10_2.poolType
		}

		if SummonConfig.poolTypeIsLuckyBag(arg_10_2.poolType) and arg_10_2.luckyBagIdSet and arg_10_2.luckyBagIdSet[var_10_4] then
			var_10_5.isLuckyBag = true
		end

		table.insert(arg_10_1, var_10_5)
	end

	return arg_10_1
end

function var_0_0.getHistoryValidPools(arg_11_0)
	local var_11_0 = arg_11_0._typeNums
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = SummonConfig.instance:getPoolDetailConfigList()

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		if iter_11_1.historyShowType == 1 then
			arg_11_0:_addHistoryValidPools(var_11_1, var_11_2, iter_11_1.id)
		end
	end

	local var_11_4 = SummonMainModel.getValidPools()

	for iter_11_2, iter_11_3 in ipairs(var_11_4) do
		local var_11_5 = arg_11_0:_getShowPoolType(iter_11_3.id, iter_11_3.type)

		arg_11_0:_addHistoryValidPools(var_11_1, var_11_2, var_11_5)
	end

	local var_11_6 = Time.time

	for iter_11_4, iter_11_5 in pairs(arg_11_0._requestPools) do
		if var_11_6 <= iter_11_5 then
			local var_11_7 = SummonConfig.instance:getSummonPool(iter_11_4)

			if var_11_7 then
				local var_11_8 = arg_11_0:_getShowPoolType(var_11_7.id, var_11_7.type)

				arg_11_0:_addHistoryValidPools(var_11_1, var_11_2, var_11_8)
			else
				logNormal(string.format("配置表找不到id为%s的卡池", iter_11_4))
			end
		end
	end

	for iter_11_6, iter_11_7 in pairs(var_11_0) do
		arg_11_0:_addHistoryValidPools(var_11_1, var_11_2, iter_11_6)
	end

	if #var_11_1 > 1 then
		table.sort(var_11_1, function(arg_12_0, arg_12_1)
			if arg_12_0.order ~= arg_12_1.order then
				return arg_12_0.order < arg_12_1.order
			end
		end)
	end

	return var_11_1
end

function var_0_0._addHistoryValidPools(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 == nil or arg_13_2[arg_13_3] then
		return
	end

	local var_13_0 = SummonConfig.instance:getPoolDetailConfig(arg_13_3)

	if arg_13_0:isCanShowByPoolTypeId(arg_13_3) then
		arg_13_2[arg_13_3] = true

		table.insert(arg_13_1, var_13_0)
	end
end

function var_0_0.isCanShowByPoolTypeId(arg_14_0, arg_14_1)
	local var_14_0 = SummonConfig.instance:getPoolDetailConfig(arg_14_1)

	if var_14_0 and var_14_0.historyShowType ~= 99 and (var_14_0.openId == nil or var_14_0.openId == 0 or OpenModel.instance:isFunctionUnlock(var_14_0.openId)) then
		return true
	end

	return false
end

function var_0_0.addRequestHistoryPool(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_0._requestPools[arg_15_1] = Time.time + 3600
end

function var_0_0.getToken(arg_16_0, arg_16_1)
	return arg_16_0._token
end

function var_0_0.setToken(arg_17_0, arg_17_1)
	arg_17_0._token = arg_17_1
	arg_17_0._tokenEndTime = Time.time + 300 - 10
end

function var_0_0.isTokenValidity(arg_18_0)
	return arg_18_0._tokenEndTime > Time.time
end

var_0_0.instance = var_0_0.New()

return var_0_0
