module("modules.logic.room.utils.RoomDistributionHelper", package.seeall)

local var_0_0 = {}

function var_0_0.matchType(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 0

	local var_1_0 = RoomDistributionEnum.DistributionTypeValue[arg_1_0]

	for iter_1_0 = 1, 6 do
		local var_1_1 = RoomRotateHelper.rotateDirection(iter_1_0, arg_1_2)
		local var_1_2 = true

		for iter_1_1 = 1, 6 do
			if arg_1_1[RoomRotateHelper.rotateDirection(iter_1_1, arg_1_2)] ~= var_1_0[iter_1_1] then
				var_1_2 = false

				break
			end
		end

		if var_1_2 then
			return true, var_1_1
		end

		arg_1_1 = var_0_0._moveForward(arg_1_1)
	end

	return false, 0
end

function var_0_0._moveForward(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 1, 6 do
		var_2_0[iter_2_0] = arg_2_0[RoomRotateHelper.rotateDirection(iter_2_0, 1)]
	end

	return var_2_0
end

function var_0_0.getIndex(arg_3_0, arg_3_1)
	local var_3_0 = 0

	for iter_3_0 = 1, 6 do
		local var_3_1 = RoomRotateHelper.rotateDirection(iter_3_0, arg_3_1)

		var_3_0 = var_3_1

		if not arg_3_0[var_3_1] then
			break
		end
	end

	return var_3_0
end

return var_0_0
