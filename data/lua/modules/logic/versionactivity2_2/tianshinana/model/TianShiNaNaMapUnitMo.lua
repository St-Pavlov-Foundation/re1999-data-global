module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitMo", package.seeall)

local var_0_0 = class("TianShiNaNaMapUnitMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.co = arg_1_1
	arg_1_0.x = arg_1_1.x
	arg_1_0.y = arg_1_1.y
	arg_1_0.dir = arg_1_1.dir
	arg_1_0.isActive = false
end

function var_0_0.updatePos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.x = arg_2_1
	arg_2_0.y = arg_2_2
	arg_2_0.dir = arg_2_3
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	arg_3_0.isActive = arg_3_1
end

function var_0_0.canWalk(arg_4_0)
	return arg_4_0.co.walkable
end

function var_0_0.isPosEqual(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_1 == arg_5_0.x and arg_5_2 == arg_5_0.y
end

return var_0_0
