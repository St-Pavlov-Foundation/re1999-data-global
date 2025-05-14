module("modules.logic.gm.controller.sequencework.DoStringActionWork", package.seeall)

local var_0_0 = class("DoStringActionWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._actionStr = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = loadstring(arg_2_0._actionStr)

	if var_2_0 then
		var_2_0()
	end

	arg_2_0:onDone(true)
end

return var_0_0
