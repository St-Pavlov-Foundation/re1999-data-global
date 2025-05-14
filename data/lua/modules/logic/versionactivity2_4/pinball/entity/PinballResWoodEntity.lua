module("modules.logic.versionactivity2_4.pinball.entity.PinballResWoodEntity", package.seeall)

local var_0_0 = class("PinballResWoodEntity", PinballResEntity)

function var_0_0.isBounce(arg_1_0)
	return false
end

function var_0_0.onHitEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = PinballEntityMgr.instance:getEntity(arg_2_1)

	if not var_2_0 then
		return
	end

	var_2_0.vx = var_2_0.vx * (1 - arg_2_0.decv)
	var_2_0.vy = var_2_0.vy * (1 - arg_2_0.decv)
end

function var_0_0.onHitCount(arg_3_0)
	PinballModel.instance:addGameRes(arg_3_0.resType, arg_3_0.resNum)
	PinballEntityMgr.instance:addNumShow(arg_3_0.resNum, arg_3_0.x + arg_3_0.width, arg_3_0.y + arg_3_0.height)
	arg_3_0:markDead()
end

function var_0_0.onInitByCo(arg_4_0)
	local var_4_0 = string.splitToNumber(arg_4_0.spData, "#") or {}

	arg_4_0.resNum = var_4_0[1] or 0
	arg_4_0.decv = (var_4_0[2] or 0) / 1000
	arg_4_0.decv = Mathf.Clamp(arg_4_0.decv, 0, 1)
end

return var_0_0
