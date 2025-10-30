module("modules.logic.fight.FightUpdateItem", package.seeall)

local var_0_0 = class("FightUpdateItem")
local var_0_1 = xpcall
local var_0_2 = __G__TRACKBACK__

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.func = arg_1_1
	arg_1_0.handle = arg_1_2
	arg_1_0.param = arg_1_3
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.isDone then
		return
	end

	var_0_1(arg_2_0.func, var_0_2, arg_2_0.handle, arg_2_1, arg_2_0.param)
end

return var_0_0
