module("modules.configs.JsonToLuaParser", package.seeall)

return {
	parse = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = {}
		local var_1_1 = arg_1_0
		local var_1_2 = {
			__index = function(arg_2_0, arg_2_1)
				local var_2_0 = arg_1_1[arg_2_1]
				local var_2_1 = rawget(arg_2_0, var_2_0)

				if arg_1_3 and arg_1_3[arg_2_1] then
					return lang(var_2_1)
				end

				return var_2_1
			end,
			__newindex = function(arg_3_0, arg_3_1, arg_3_2)
				logError("Can't modify config field: " .. arg_3_1)
			end
		}

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = iter_1_1.name

			setmetatable(iter_1_1, var_1_2)

			local var_1_4 = var_1_0

			for iter_1_2, iter_1_3 in ipairs(arg_1_2) do
				local var_1_5 = iter_1_1[iter_1_3]

				if iter_1_2 == #arg_1_2 then
					var_1_4[var_1_5] = iter_1_1
				else
					if not var_1_4[var_1_5] then
						var_1_4[var_1_5] = {}
					end

					var_1_4 = var_1_4[var_1_5]
				end
			end
		end

		return var_1_1, var_1_0
	end
}
