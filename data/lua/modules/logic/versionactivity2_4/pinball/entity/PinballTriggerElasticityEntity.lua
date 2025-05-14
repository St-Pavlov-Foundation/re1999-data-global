module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerElasticityEntity", package.seeall)

local var_0_0 = class("PinballTriggerElasticityEntity", PinballTriggerEntity)

function var_0_0.onInit(arg_1_0)
	var_0_0.super.onInit(arg_1_0)
end

function var_0_0.onInitByCo(arg_2_0)
	arg_2_0.force = (tonumber(arg_2_0.spData) or 1000) / 1000
	arg_2_0.baseForceX = arg_2_0.force
	arg_2_0.baseForceY = arg_2_0.force
end

return var_0_0
