module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleLayerInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2PrevSettleLayerInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.platinumCupNum = arg_1_1.platinumCupNum

	local var_1_0 = lua_weekwalk_ver2.configDict[arg_1_0.layerId]

	arg_1_0.layerIndex = var_1_0 and var_1_0.layer or 0
end

return var_0_0
