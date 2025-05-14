module("modules.logic.room.utils.RoomRotateHelper", package.seeall)

local var_0_0 = {
	getMod = function(arg_1_0, arg_1_1)
		if arg_1_0 > 0 then
			arg_1_0 = arg_1_0 % arg_1_1
		else
			arg_1_0 = arg_1_0 + math.ceil(math.abs(arg_1_0 / arg_1_1)) * arg_1_1
		end

		return arg_1_0
	end
}

function var_0_0.rotateRotate(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_0 + arg_2_1
	arg_2_1 = var_0_0.getMod(arg_2_1, 6)

	return arg_2_1
end

function var_0_0.rotateDirection(arg_3_0, arg_3_1)
	if arg_3_0 == 0 then
		return arg_3_0
	end

	arg_3_0 = var_0_0.rotateRotate(arg_3_0 - 1, arg_3_1)

	return arg_3_0 + 1
end

function var_0_0.rotateDirectionWithCenter(arg_4_0, arg_4_1)
	return var_0_0.getMod(arg_4_0 + arg_4_1, 7)
end

function var_0_0.oppositeDirection(arg_5_0)
	if arg_5_0 == 0 then
		return arg_5_0
	end

	return var_0_0.rotateDirection(arg_5_0, 3)
end

function var_0_0.simpleRotate(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = var_0_0.getMod(arg_6_1, Mathf.PI * 2)
	arg_6_2 = var_0_0.getMod(arg_6_2, Mathf.PI * 2)

	local var_6_0 = 0

	if Mathf.Abs(arg_6_1 - arg_6_2) > Mathf.PI then
		if arg_6_1 > Mathf.PI then
			arg_6_1 = arg_6_1 - Mathf.PI * 2
		elseif arg_6_2 > Mathf.PI then
			arg_6_2 = arg_6_2 - Mathf.PI * 2
		end
	end

	local var_6_1 = (1 - arg_6_0) * arg_6_1 + arg_6_0 * arg_6_2

	return var_0_0.getMod(var_6_1, Mathf.PI * 2)
end

function var_0_0.getCameraNearRotate(arg_7_0)
	arg_7_0 = var_0_0.getMod(Mathf.Round((arg_7_0 - 30) / 60), 6)

	return arg_7_0
end

return var_0_0
