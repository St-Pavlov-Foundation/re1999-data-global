module("modules.logic.versionactivity2_7.lengzhou6.model.EliminateModelUtils", package.seeall)

local var_0_0 = class("EliminateModelUtils")

function var_0_0.mergePointArray(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_0 do
		table.insert(var_1_0, arg_1_0[iter_1_0])
	end

	local var_1_1 = {}

	for iter_1_1 = 1, #arg_1_1 do
		local var_1_2 = arg_1_1[iter_1_1]
		local var_1_3 = false

		for iter_1_2 = 1, #var_1_0 do
			local var_1_4 = var_1_0[iter_1_2]

			if var_1_2.x == var_1_4.x and var_1_2.y == var_1_4.y then
				var_1_3 = true

				break
			end
		end

		if not var_1_3 then
			table.insert(var_1_1, var_1_2)
		end
	end

	for iter_1_3 = 1, #var_1_1 do
		table.insert(var_1_0, var_1_1[iter_1_3])
	end

	return var_1_0
end

function var_0_0.exclusivePoint(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0 = 1, #arg_2_0 do
		local var_2_1 = arg_2_0[iter_2_0]

		if var_2_1.x ~= arg_2_1.x or var_2_1.y ~= arg_2_1.y then
			table.insert(var_2_0, var_2_1)
		end
	end

	return var_2_0
end

function var_0_0.getRandomNumberByWeight(arg_3_0)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_3_0 = var_3_0 + iter_3_1
	end

	local var_3_1 = math.random() * var_3_0
	local var_3_2 = 0

	for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
		var_3_2 = var_3_2 + iter_3_3

		if var_3_1 <= var_3_2 then
			return iter_3_2
		end
	end
end

return var_0_0
