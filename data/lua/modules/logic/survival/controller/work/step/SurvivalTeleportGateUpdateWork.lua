module("modules.logic.survival.controller.work.step.SurvivalTeleportGateUpdateWork", package.seeall)

local var_0_0 = class("SurvivalTeleportGateUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	var_1_0.sceneProp.teleportGate = arg_1_0._stepMo.paramInt[1] or 0
	var_1_0.sceneProp.teleportGateHex = arg_1_0._stepMo.position

	SurvivalMapHelper.instance:getScene().pointEffect:setTeleportGateEffect()
	arg_1_0:onDone(true)
end

return var_0_0
