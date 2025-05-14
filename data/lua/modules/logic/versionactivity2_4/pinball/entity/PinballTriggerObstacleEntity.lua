module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerObstacleEntity", package.seeall)

local var_0_0 = class("PinballTriggerObstacleEntity", PinballTriggerEntity)

function var_0_0.onInitByCo(arg_1_0)
	arg_1_0.force = (tonumber(arg_1_0.spData) or 1000) / 1000
	arg_1_0.baseForceX = arg_1_0.force
	arg_1_0.baseForceY = arg_1_0.force
end

return var_0_0
