module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerEntity", package.seeall)

local var_0_0 = class("PinballTriggerEntity", PinballColliderEntity)

function var_0_0.onHitEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	var_1_0:setDelayDispose(2)

	var_1_0.x = arg_1_2
	var_1_0.y = arg_1_3

	var_1_0:tick(0)
	var_1_0:playAnim("hit")
end

return var_0_0
