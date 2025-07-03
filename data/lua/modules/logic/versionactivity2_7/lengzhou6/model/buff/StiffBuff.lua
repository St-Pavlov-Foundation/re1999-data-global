module("modules.logic.versionactivity2_7.lengzhou6.model.buff.StiffBuff", package.seeall)

local var_0_0 = class("StiffBuff", BuffBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_0.execute(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return false
	end

	if arg_2_0._layerCount == 0 then
		return false
	end

	arg_2_0:addCount(-1)

	return true
end

return var_0_0
