module("modules.logic.common.model.SimpleRandomModel", package.seeall)

local var_0_0 = class("SimpleRandomModel", BaseModel)
local var_0_1 = math.random
local var_0_2 = math.randomseed
local var_0_3 = table.insert
local var_0_4 = string.format

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._rdHashSet = {}
end

function var_0_0.getListIdxAndItemIdx(arg_3_0, arg_3_1)
	if isDebugBuild then
		assert(#arg_3_1 > 0)
	end

	local var_3_0
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_1 = var_3_1 + #iter_3_1

		if iter_3_0 == 1 then
			arg_3_0._rdHashSet[iter_3_1] = arg_3_0._rdHashSet[iter_3_1] or {}
			var_3_0 = arg_3_0._rdHashSet[iter_3_1]
		else
			var_3_0[iter_3_1] = var_3_0[iter_3_1] or {}
			var_3_0 = var_3_0[iter_3_1]
		end
	end

	if isDebugBuild then
		assert(type(var_3_0) == "table", "never happen")
		assert(var_3_1 > 0, "empty reqLists")
	end

	local var_3_2 = var_3_0.curRdIdx or 0
	local var_3_3 = var_3_0.rdIdxList or {}
	local var_3_4 = var_3_0.rdIdx2RealIdxPairDict or {}

	if var_3_2 < #var_3_3 then
		local var_3_5 = var_3_2 + 1

		var_3_0.curRdIdx = var_3_5

		local var_3_6 = var_3_0.rdIdx2RealIdxPairDict[var_3_5]

		return var_3_6.whichList, var_3_6.whichItem
	end

	for iter_3_2 = #var_3_3 + 1, var_3_1 do
		var_0_3(var_3_3, iter_3_2)
		var_0_3(var_3_4, {})
	end

	local var_3_7 = 1

	var_0_2(os.time())

	local var_3_8 = GameUtil.randomTable(var_3_3)
	local var_3_9 = {
		[0] = 0
	}

	for iter_3_3, iter_3_4 in ipairs(arg_3_1) do
		var_3_9[iter_3_3] = var_3_9[iter_3_3 - 1] + #iter_3_4
	end

	for iter_3_5, iter_3_6 in ipairs(var_3_8) do
		local var_3_10 = var_3_4[iter_3_5]

		for iter_3_7 = 1, #var_3_9 do
			if iter_3_6 <= var_3_9[iter_3_7] then
				local var_3_11 = var_3_9[iter_3_7 - 1]

				var_3_10.whichList = iter_3_7
				var_3_10.whichItem = iter_3_6 - var_3_11

				break
			end
		end
	end

	var_3_0.rdIdxList = var_3_8
	var_3_0.curRdIdx = var_3_7
	var_3_0.rdIdx2RealIdxPairDict = var_3_4

	local var_3_12 = var_3_0.rdIdx2RealIdxPairDict[var_3_7]

	return var_3_12.whichList, var_3_12.whichItem
end

function var_0_0.getRateIndex(arg_4_0, arg_4_1)
	var_0_2(os.time())

	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1 > 0 then
			var_4_1 = var_4_1 + iter_4_1
		end
	end

	local var_4_2 = var_0_1(1, var_4_1)

	for iter_4_2, iter_4_3 in ipairs(arg_4_1) do
		var_4_0 = var_4_0 + 1

		if iter_4_3 > 0 then
			if var_4_2 <= iter_4_3 then
				return var_4_0
			end

			var_4_2 = var_4_2 - iter_4_3
		end
	end

	if isDebugBuild and false then
		local var_4_3 = {}

		var_0_3("[SimpleRandomModel - getRateIndex] =========== begin")
		var_0_3("tot: " .. var_4_1)
		var_0_3("result index: " .. var_4_0)

		for iter_4_4, iter_4_5 in ipairs(arg_4_1) do
			var_0_3(var_0_4("\t[%s]: %s", iter_4_4, iter_4_5))
		end

		var_0_3("[SimpleRandomModel - getRateIndex] =========== end")
		logError(table.concat(var_4_3, "\n"))
	end

	return var_4_0
end

function var_0_0.clean(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		if var_5_0 == nil then
			var_5_0 = arg_5_0._rdHashSet[iter_5_1]
			arg_5_0._rdHashSet[iter_5_1] = nil
		else
			local var_5_1 = var_5_0

			var_5_0 = var_5_0[iter_5_1]
			var_5_1[iter_5_1] = nil

			if not var_5_0 then
				break
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
