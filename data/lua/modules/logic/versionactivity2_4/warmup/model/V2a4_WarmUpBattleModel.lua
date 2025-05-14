module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleModel", package.seeall)

local var_0_0 = class("V2a4_WarmUpBattleModel", BaseModel)
local var_0_1 = string.format
local var_0_2 = table.insert

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._levelId = 0
	arg_2_0._startTs = 0
	arg_2_0._endTs = -1
	arg_2_0._waveList = {}
end

function var_0_0.curWaveIndex(arg_3_0)
	return #arg_3_0._waveList
end

function var_0_0.curWave(arg_4_0)
	local var_4_0 = arg_4_0:curWaveIndex()

	return arg_4_0._waveList[var_4_0]
end

function var_0_0.curRound(arg_5_0)
	local var_5_0 = arg_5_0:curWave()

	if not var_5_0 then
		return nil, nil
	end

	return var_5_0:curRound(), var_5_0
end

function var_0_0.curRoundIndex(arg_6_0)
	local var_6_0 = arg_6_0:curRound()

	if not var_6_0 then
		return 0
	end

	return var_6_0:index()
end

function var_0_0.genWave(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:curWaveIndex() + 1
	local var_7_1 = V2a4_WarmUpBattleWaveMO.New(var_7_0, arg_7_1)
	local var_7_2 = arg_7_1:roundMOList()

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		var_7_1:genRound(iter_7_1)
	end

	var_0_2(arg_7_0._waveList, var_7_1)

	return var_7_1
end

function var_0_0.clean(arg_8_0)
	arg_8_0._levelId = 0
	arg_8_0._startTs = 0
	arg_8_0._endTs = 0
	arg_8_0._waveList = {}
end

function var_0_0.restart(arg_9_0, arg_9_1)
	arg_9_0:clean()

	arg_9_0._levelId = arg_9_1
	arg_9_0._startTs = ServerTime.now()
	arg_9_0._endTs = arg_9_0._startTs + V2a4_WarmUpConfig.instance:getDurationSec()
end

function var_0_0.levelId(arg_10_0)
	return arg_10_0._levelId
end

function var_0_0.isTimeout(arg_11_0)
	return arg_11_0._startTs > arg_11_0._endTs or ServerTime.now() >= arg_11_0._endTs
end

function var_0_0.getRemainTime(arg_12_0)
	return arg_12_0._endTs - ServerTime.now()
end

function var_0_0.isFirstWaveDone(arg_13_0)
	if arg_13_0:curWaveIndex() >= 2 then
		return true
	end

	local var_13_0 = arg_13_0:curWave()

	if not var_13_0 then
		return false
	end

	return var_13_0:isFinished()
end

function var_0_0.getResultInfo(arg_14_0)
	local var_14_0 = false
	local var_14_1 = 0
	local var_14_2 = 0
	local var_14_3 = 0
	local var_14_4 = 0
	local var_14_5 = 0
	local var_14_6 = 0
	local var_14_7 = arg_14_0:isFirstWaveDone()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._waveList) do
		local var_14_8 = iter_14_1:roundMOList()
		local var_14_9
		local var_14_10 = 0

		for iter_14_2, iter_14_3 in ipairs(var_14_8) do
			if iter_14_3:isFinished() then
				if iter_14_3:userAnsIsYes() then
					var_14_5 = var_14_5 + 1
				else
					var_14_6 = var_14_6 + 1
				end

				var_14_10 = var_14_10 + 1

				if iter_14_3:isWin() then
					var_14_4 = var_14_4 + 1

					if var_14_9 == nil then
						var_14_9 = true
					end
				else
					var_14_9 = false
				end
			else
				var_14_9 = false
			end
		end

		if var_14_10 == #var_14_8 then
			var_14_1 = var_14_1 + 1
		end

		var_14_2 = var_14_2 + var_14_10

		if var_14_9 then
			var_14_0 = true
			var_14_3 = var_14_3 + 1
		end
	end

	if not var_14_7 then
		var_14_0 = false
	end

	local var_14_11 = var_14_0 and var_14_2 == var_14_4
	local var_14_12 = var_14_2 - var_14_4

	return {
		isWin = var_14_0,
		isPerfectWin = var_14_11,
		sucHelpCnt = var_14_3,
		totValidWaveCnt = var_14_1,
		totValidRoundCnt = var_14_2,
		totBingoRoundCnt = var_14_4,
		totWrontRoundCnt = var_14_12,
		totWaveCnt = arg_14_0:curWaveIndex(),
		totAnsYesCnt = var_14_5,
		totAnsNoCnt = var_14_6
	}
end

function var_0_0.dump(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or 0

	local var_15_0 = string.rep("\t", arg_15_2)

	var_0_2(arg_15_1, var_15_0 .. var_0_1("level = %s (%s)s", arg_15_0._levelId, arg_15_0:getRemainTime()))

	local var_15_1 = arg_15_0._waveList

	var_0_2(arg_15_1, var_15_0 .. "Waves = {")

	for iter_15_0 = #var_15_1, 1, -1 do
		var_15_1[iter_15_0]:dump(arg_15_1, arg_15_2 + 1)
	end

	var_0_2(arg_15_1, var_15_0 .. "}")
end

var_0_0.instance = var_0_0.New()

return var_0_0
