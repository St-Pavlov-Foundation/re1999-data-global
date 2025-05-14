module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaModel", package.seeall)

local var_0_0 = class("V2a4_WarmUpGachaModel", BaseModel)
local var_0_1 = table.insert

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._waveList = {}
	arg_2_0._s_RandomList = {}
end

function var_0_0.clean(arg_3_0)
	arg_3_0._waveList = {}
end

function var_0_0.curWaveIndex(arg_4_0)
	return #arg_4_0._waveList
end

function var_0_0.curWave(arg_5_0)
	local var_5_0 = arg_5_0:curWaveIndex()

	return arg_5_0._waveList[var_5_0]
end

function var_0_0.curRound(arg_6_0)
	local var_6_0 = arg_6_0:curWave()

	if not var_6_0 then
		return nil
	end

	return var_6_0:curRound()
end

function var_0_0.curRoundIndex(arg_7_0)
	local var_7_0 = arg_7_0:curRound()

	if not var_7_0 then
		return 0
	end

	return var_7_0:index()
end

function var_0_0.s_RdList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._s_RandomList[arg_8_1]

	if var_8_0 then
		return var_8_0
	end

	local var_8_1 = V2a4_WarmUpController.instance:config()
	local var_8_2 = var_8_1:getTextItemListCO(arg_8_1)
	local var_8_3 = var_8_1:getPhotoItemListCO(arg_8_1)
	local var_8_4 = {
		[V2a4_WarmUpEnum.AskType.Text] = var_8_2,
		[V2a4_WarmUpEnum.AskType.Photo] = var_8_3
	}

	assert(#var_8_4 == 2)

	arg_8_0._s_RandomList[arg_8_1] = var_8_4

	return var_8_4
end

function var_0_0.restart(arg_9_0, arg_9_1)
	arg_9_0:clean()

	local var_9_0 = arg_9_0:s_RdList(arg_9_1)

	SimpleRandomModel.instance:clean(var_9_0)
end

function var_0_0.genWave(arg_10_0, arg_10_1)
	local var_10_0 = V2a4_WarmUpController.instance:config()
	local var_10_1 = arg_10_0:s_RdList(arg_10_1)
	local var_10_2, var_10_3 = SimpleRandomModel.instance:getListIdxAndItemIdx(var_10_1)
	local var_10_4 = var_10_0:getLevelCO(arg_10_1).askCount
	local var_10_5 = arg_10_0:curWaveIndex() + 1
	local var_10_6 = var_10_1[var_10_2]
	local var_10_7 = V2a4_WarmUpGachaWaveMO.New(var_10_5, var_10_2)

	for iter_10_0 = 1, var_10_4 do
		var_10_7:genRound(var_10_6[var_10_3])
	end

	var_0_1(arg_10_0._waveList, var_10_7)

	return var_10_7
end

var_0_0.instance = var_0_0.New()

return var_0_0
