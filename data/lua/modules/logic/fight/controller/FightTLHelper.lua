module("modules.logic.fight.controller.FightTLHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getTableParam(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 then
		return FightStrUtil.instance:getSplitToNumberCache(arg_1_0, arg_1_1)
	else
		return FightStrUtil.instance:getSplitCache(arg_1_0, arg_1_1)
	end
end

function var_0_0.getBoolParam(arg_2_0)
	return arg_2_0 == "1"
end

function var_0_0.getNumberParam(arg_3_0)
	return tonumber(arg_3_0)
end

return var_0_0
