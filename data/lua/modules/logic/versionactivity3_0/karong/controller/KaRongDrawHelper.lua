module("modules.logic.versionactivity3_0.karong.controller.KaRongDrawHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = KaRongDrawEnum.dir.left
local var_0_2 = KaRongDrawEnum.dir.right
local var_0_3 = KaRongDrawEnum.dir.down
local var_0_4 = KaRongDrawEnum.dir.up

function var_0_0.formatPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_2 < arg_1_0 then
		arg_1_0, arg_1_2 = arg_1_2, arg_1_0
	end

	if arg_1_3 < arg_1_1 then
		arg_1_1, arg_1_3 = arg_1_3, arg_1_1
	end

	return arg_1_0, arg_1_1, arg_1_2, arg_1_3
end

function var_0_0.getFromToDir(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0 ~= arg_2_2 then
		if arg_2_1 ~= arg_2_3 then
			return nil
		end

		return arg_2_0 < arg_2_2 and var_0_2 or var_0_1
	else
		return arg_2_1 < arg_2_3 and var_0_4 or var_0_3
	end
end

function var_0_0.getPosKey(arg_3_0, arg_3_1)
	return string.format("%s_%s", arg_3_0, arg_3_1)
end

function var_0_0.getLineKey(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0, var_4_1, var_4_2, var_4_3 = var_0_0.formatPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)

	return string.format("%s_%s_%s_%s", var_4_0, var_4_1, var_4_2, var_4_3)
end

return var_0_0
