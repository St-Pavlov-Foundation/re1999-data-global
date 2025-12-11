module("modules.logic.survival.model.map.SurvivalScenePropMo", package.seeall)

local var_0_0 = pureTable("SurvivalScenePropMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.magmaStatus = arg_1_1.magmaStatus
	arg_1_0.radarPosition = SurvivalHexNode.New(arg_1_1.radarHex.q, arg_1_1.radarHex.r)
	arg_1_0.teleportGate = arg_1_1.teleportGate
	arg_1_0.teleportGateHex = SurvivalHexNode.New(arg_1_1.teleportGateHex.q, arg_1_1.teleportGateHex.r)
end

return var_0_0
