module("modules.logic.fight.FightTimerItem", package.seeall)

local var_0_0 = class("FightTimerItem")
local var_0_1 = xpcall
local var_0_2 = __G__TRACKBACK__

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.time = arg_1_1
	arg_1_0.originRepeatCount = arg_1_2
	arg_1_0.repeatCount = arg_1_2
	arg_1_0.callback = arg_1_3
	arg_1_0.handle = arg_1_4
	arg_1_0.param = arg_1_5
	arg_1_0.updateTime = 0
end

function var_0_0.restart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.updateTime = 0
	arg_2_0.time = arg_2_1 or arg_2_0.time
	arg_2_0.repeatCount = arg_2_2 or arg_2_0.originRepeatCount
	arg_2_0.param = arg_2_3 or arg_2_0.param
	arg_2_0.isDone = false
end

function var_0_0.update(arg_3_0, arg_3_1)
	if arg_3_0.isDone then
		return
	end

	arg_3_0.updateTime = arg_3_0.updateTime + arg_3_1

	if arg_3_0.updateTime >= arg_3_0.time then
		arg_3_0.updateTime = 0

		if arg_3_0.repeatCount ~= -1 then
			arg_3_0.repeatCount = arg_3_0.repeatCount - 1
		end

		var_0_1(arg_3_0.callback, var_0_2, arg_3_0.handle, arg_3_0.param)

		if arg_3_0.repeatCount == 0 then
			arg_3_0.isDone = true
		end
	end
end

return var_0_0
