module("modules.common.utils.SortUtil", package.seeall)

return {
	keyLower = function(arg_1_0)
		return function(arg_2_0, arg_2_1)
			return arg_2_0[arg_1_0] < arg_2_1[arg_1_0]
		end
	end,
	keyUpper = function(arg_3_0)
		return function(arg_4_0, arg_4_1)
			return arg_4_0[arg_3_0] > arg_4_1[arg_3_0]
		end
	end,
	tableKeyLower = function(arg_5_0)
		return function(arg_6_0, arg_6_1)
			for iter_6_0, iter_6_1 in ipairs(arg_5_0) do
				if arg_6_0[iter_6_1] ~= arg_6_1[iter_6_1] then
					return arg_6_0[iter_6_1] < arg_6_1[iter_6_1]
				end
			end

			return false
		end
	end,
	tableKeyUpper = function(arg_7_0)
		return function(arg_8_0, arg_8_1)
			for iter_8_0, iter_8_1 in ipairs(arg_7_0) do
				if arg_8_0[iter_8_1] ~= arg_8_1[iter_8_1] then
					return arg_8_0[iter_8_1] > arg_8_1[iter_8_1]
				end
			end

			return false
		end
	end
}
