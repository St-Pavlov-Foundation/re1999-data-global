module("modules.logic.fight.system.work.FightWorkLoadAsset", package.seeall)

local var_0_0 = class("FightWorkLoadAsset", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, ...)
	arg_1_0.url = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.handle = arg_1_3
	arg_1_0.param = {
		...
	}
	arg_1_0.paramCount = select("#", ...)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_loadAsset(arg_2_0.url, arg_2_0.onLoaded)
end

function var_0_0.onLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.callback then
		arg_3_0.callback(arg_3_0.handle, arg_3_1, arg_3_2, unpack(arg_3_0.param, 1, arg_3_0.paramCount))
	end

	arg_3_0:onDone(true)
end

return var_0_0
