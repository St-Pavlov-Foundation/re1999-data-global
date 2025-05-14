module("modules.logic.optionpackage.utils.OptionPackageHelper", package.seeall)

return {
	formatLangPackName = function(arg_1_0, arg_1_1)
		return string.format("%s-%s", arg_1_0, arg_1_1)
	end,
	getLeftSizeMBorGB = function(arg_2_0, arg_2_1)
		arg_2_1 = arg_2_1 or 0

		local var_2_0 = math.max(0, arg_2_0 - arg_2_1)
		local var_2_1 = 1073741824
		local var_2_2 = var_2_0 / var_2_1
		local var_2_3 = "GB"

		if var_2_2 < 0.1 then
			var_2_1 = 1048576
			var_2_2 = var_2_0 / var_2_1
			var_2_3 = "MB"

			if var_2_2 < 0.01 then
				var_2_2 = 0.01
			end
		end

		return var_2_2, math.max(0.01, arg_2_0 / var_2_1), var_2_3
	end,
	getLeftSizeMBNum = function(arg_3_0, arg_3_1)
		arg_3_1 = arg_3_1 or 0

		local var_3_0 = math.max(0, arg_3_0 - arg_3_1) / 1048576

		if var_3_0 < 0.01 then
			var_3_0 = 0.01
		end

		return var_3_0
	end
}
