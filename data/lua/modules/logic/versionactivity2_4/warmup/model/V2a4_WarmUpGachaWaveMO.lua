module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaWaveMO", package.seeall)

local var_0_0 = math.randomseed
local var_0_1 = table.insert
local var_0_2 = string.format
local var_0_3 = class("V2a4_WarmUpGachaWaveMO")

function var_0_3.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._index = arg_1_1
	arg_1_0._type = arg_1_2
	arg_1_0._roundMOList = {}
end

function var_0_3._getYesOrNo(arg_2_0)
	local var_2_0 = arg_2_0.__rdIdxList or {}
	local var_2_1 = arg_2_0.__curRdIdx or 0

	arg_2_0.__rdSet = arg_2_0.__rdSet or {}

	if var_2_1 < #var_2_0 then
		local var_2_2, var_2_3 = arg_2_0:_nextRandomYesNo()
		local var_2_4 = 10

		while arg_2_0.__rdSet[var_2_3] do
			var_2_4 = var_2_4 - 1

			if var_2_4 < 0 then
				logError("[V2a4_WarmUpGachaWaveMO - _getYesOrNo] stack overflow")

				break
			end

			var_2_2, var_2_3 = arg_2_0:_nextRandomYesNo()
		end

		if arg_2_0.__curRdIdx <= #var_2_0 then
			arg_2_0.__rdSet[var_2_3] = true

			return var_2_2, var_2_3
		end

		arg_2_0.__rdSet = {}
	end

	local var_2_5 = V2a4_WarmUpConfig.instance:getYesAndNoMaxCount(arg_2_0._type)

	if isDebugBuild then
		assert(var_2_5 > 0, var_0_2("unsupported V2a4_WarmUpEnum.AskType.xxx = %s", arg_2_0._type))
	end

	for iter_2_0 = #var_2_0 + 1, var_2_5 do
		var_0_1(var_2_0, iter_2_0)
	end

	var_0_0(os.time())

	arg_2_0.__rdIdxList = GameUtil.randomTable(var_2_0)
	arg_2_0.__curRdIdx = 0

	local var_2_6, var_2_7 = arg_2_0:_nextRandomYesNo()

	arg_2_0.__rdSet[var_2_7] = true

	return var_2_6, var_2_7
end

function var_0_3._nextRandomYesNo(arg_3_0)
	local var_3_0 = arg_3_0.__curRdIdx + 1
	local var_3_1 = arg_3_0.__rdIdxList[var_3_0]
	local var_3_2 = var_3_1 % 2 == 0
	local var_3_3 = math.ceil(var_3_1 / 2)

	arg_3_0.__curRdIdx = var_3_0

	return var_3_2, var_3_3
end

function var_0_3.index(arg_4_0)
	return arg_4_0._index
end

function var_0_3.type(arg_5_0)
	return arg_5_0._type
end

function var_0_3.roundCount(arg_6_0)
	return #arg_6_0._roundMOList
end

function var_0_3.roundMOList(arg_7_0)
	return arg_7_0._roundMOList
end

function var_0_3.isAllAskYes(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._roundMOList) do
		if iter_8_1:ansIsYes() then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0 > 0 and var_8_0 == arg_8_0:roundCount()
end

function var_0_3.genRound(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0:_getYesOrNo()
	local var_9_2 = arg_9_0:roundCount() + 1
	local var_9_3 = V2a4_WarmUpGachaRoundMO.New(arg_9_0, var_9_2, arg_9_1, var_9_0, var_9_1)

	var_0_1(arg_9_0._roundMOList, var_9_3)

	return var_9_3
end

return var_0_3
