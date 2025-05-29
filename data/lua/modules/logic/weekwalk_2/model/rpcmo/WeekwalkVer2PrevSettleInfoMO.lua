module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2PrevSettleInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.maxLayerId = arg_1_1.maxLayerId
	arg_1_0.maxBattleId = arg_1_1.maxBattleId
	arg_1_0.maxBattleIndex = arg_1_1.maxBattleIndex
	arg_1_0.show = arg_1_1.show
	arg_1_0.layerInfos = GameUtil.rpcInfosToMap(arg_1_1.layerInfos, WeekwalkVer2PrevSettleLayerInfoMO, "layerIndex")
end

function var_0_0.getLayerPlatinumCupNum(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.layerInfos[arg_2_1]

	return var_2_0 and var_2_0.platinumCupNum
end

function var_0_0.getTotalPlatinumCupNum(arg_3_0)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.layerInfos) do
		var_3_0 = var_3_0 + iter_3_1.platinumCupNum
	end

	return var_3_0
end

return var_0_0
