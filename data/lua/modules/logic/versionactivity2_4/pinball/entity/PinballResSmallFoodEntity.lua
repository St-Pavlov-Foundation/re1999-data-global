module("modules.logic.versionactivity2_4.pinball.entity.PinballResSmallFoodEntity", package.seeall)

local var_0_0 = class("PinballResSmallFoodEntity", PinballResEntity)

function var_0_0.initByCo(arg_1_0, arg_1_1)
	var_0_0.super.initByCo(arg_1_0, arg_1_1)

	arg_1_0._initDt = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.onHitCount(arg_2_0)
	PinballModel.instance:addGameRes(arg_2_0.resType, arg_2_0.resNum)
	PinballEntityMgr.instance:addNumShow(arg_2_0.resNum, arg_2_0.x + arg_2_0.width, arg_2_0.y + arg_2_0.height)
	PinballEntityMgr.instance:removeEntity(arg_2_0.id)
end

return var_0_0
