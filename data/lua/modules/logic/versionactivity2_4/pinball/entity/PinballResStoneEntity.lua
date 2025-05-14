module("modules.logic.versionactivity2_4.pinball.entity.PinballResStoneEntity", package.seeall)

local var_0_0 = class("PinballResStoneEntity", PinballResEntity)

function var_0_0.onHitCount(arg_1_0)
	PinballModel.instance:addGameRes(arg_1_0.resType, arg_1_0.resNum)
	PinballEntityMgr.instance:addNumShow(arg_1_0.resNum, arg_1_0.x + arg_1_0.width, arg_1_0.y + arg_1_0.height)
	PinballEntityMgr.instance:removeEntity(arg_1_0.id)
end

function var_0_0.onInitByCo(arg_2_0)
	arg_2_0.resNum = tonumber(arg_2_0.spData) or 0
end

return var_0_0
