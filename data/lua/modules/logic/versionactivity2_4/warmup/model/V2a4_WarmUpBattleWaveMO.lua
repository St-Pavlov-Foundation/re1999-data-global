module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleWaveMO", package.seeall)

local var_0_0 = class("V2a4_WarmUpBattleWaveMO")
local var_0_1 = string.format
local var_0_2 = table.insert

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._index = arg_1_1
	arg_1_0._gachaMO = arg_1_2
	arg_1_0._isFinished = false
	arg_1_0._isWin = false
	arg_1_0._isPerfectWin = false
	arg_1_0._curRound = 0
	arg_1_0._roundMOList = {}
end

function var_0_0.genRound(arg_2_0, arg_2_1)
	if arg_2_0._isFinished then
		return
	end

	local var_2_0 = arg_2_0:roundCount() + 1
	local var_2_1 = V2a4_WarmUpBattleRoundMO.New(arg_2_0, var_2_0, arg_2_1)

	table.insert(arg_2_0._roundMOList, var_2_1)

	return var_2_1
end

function var_0_0.index(arg_3_0)
	return arg_3_0._index
end

function var_0_0.type(arg_4_0)
	return arg_4_0._gachaMO:type()
end

function var_0_0.isRound_Text(arg_5_0)
	return arg_5_0:type() == V2a4_WarmUpEnum.AskType.Text
end

function var_0_0.isRound_Photo(arg_6_0)
	return arg_6_0:type() == V2a4_WarmUpEnum.AskType.Photo
end

function var_0_0.roundMOList(arg_7_0)
	return arg_7_0._roundMOList
end

function var_0_0.roundCount(arg_8_0)
	return #arg_8_0._roundMOList
end

function var_0_0.validRoundCount(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._roundMOList) do
		if iter_9_1:isFinished() then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.isLastRound(arg_10_0)
	return arg_10_0:roundCount() == arg_10_0._curRound
end

function var_0_0.isFirstRound(arg_11_0)
	return arg_11_0._curRound == 1
end

function var_0_0.isWin(arg_12_0)
	return arg_12_0._isWin
end

function var_0_0.isPerfectWin(arg_13_0)
	return arg_13_0._isPerfectWin
end

function var_0_0.isFinished(arg_14_0)
	return arg_14_0._isFinished
end

function var_0_0.nextRound(arg_15_0)
	if arg_15_0._isFinished then
		return false
	end

	local var_15_0 = arg_15_0._curRound + 1

	if var_15_0 > arg_15_0:roundCount() then
		arg_15_0:_onFinish()

		return false
	end

	arg_15_0._curRound = var_15_0

	return true
end

function var_0_0._onFinish(arg_16_0)
	if arg_16_0._isFinished then
		return
	end

	arg_16_0._isFinished = true
	arg_16_0._curRound = arg_16_0:roundCount()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._roundMOList) do
		arg_16_0._isWin = iter_16_1:isWin()

		if arg_16_0._isWin then
			break
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0._roundMOList) do
		arg_16_0._isPerfectWin = iter_16_3:isWin()

		if not arg_16_0._isPerfectWin then
			break
		end
	end
end

function var_0_0.curRound(arg_17_0)
	return arg_17_0._roundMOList[arg_17_0._curRound]
end

function var_0_0.winRoundCount(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._roundMOList) do
		if iter_18_1:isWin() then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.isFirstWave(arg_19_0)
	return arg_19_0._index == 1
end

function var_0_0.isAllAskYes(arg_20_0)
	return arg_20_0._gachaMO:isAllAskYes()
end

function var_0_0.s_type(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(V2a4_WarmUpEnum.AskType) do
		if arg_21_0 == iter_21_1 then
			return iter_21_0
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function var_0_0.dump(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or 0

	local var_22_0 = string.rep("\t", arg_22_2)

	var_0_2(arg_22_1, var_22_0 .. var_0_1("index = %s", arg_22_0._index))
	var_0_2(arg_22_1, var_22_0 .. var_0_1("isFinished = %s", arg_22_0._isFinished))
	var_0_2(arg_22_1, var_22_0 .. var_0_1("isWin = %s", arg_22_0._isWin))
	var_0_2(arg_22_1, var_22_0 .. var_0_1("type = %s", var_0_0.s_type(arg_22_0:type())))
	var_0_2(arg_22_1, var_22_0 .. var_0_1("Cur Round Index = %s --> ", arg_22_0._curRound))

	local var_22_1 = arg_22_0._roundMOList

	var_0_2(arg_22_1, var_22_0 .. "Rounds = {")

	for iter_22_0 = 1, #var_22_1 do
		var_22_1[iter_22_0]:dump(arg_22_1, arg_22_2 + 1)
	end

	var_0_2(arg_22_1, var_22_0 .. "}")
end

return var_0_0
