module("projbooter.utils.VersionUtil", package.seeall)

local var_0_0 = {
	versionStrToNumber = function(arg_1_0)
		local var_1_0 = string.splitToNumber(arg_1_0, ".")

		return var_1_0[1] * 10000 + var_1_0[2] * 100 + var_1_0[3]
	end
}

function var_0_0.compareVersion(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.versionStrToNumber(arg_2_0)
	local var_2_1 = var_0_0.versionStrToNumber(arg_2_1)

	if var_2_0 < var_2_1 then
		return -1
	elseif var_2_1 < var_2_0 then
		return 1
	end

	return 0
end

function var_0_0.isVersionLarger(arg_3_0)
	local var_3_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_3_0, arg_3_0) > 0
end

function var_0_0.isVersionLargeEqual(arg_4_0)
	local var_4_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_4_0, arg_4_0) >= 0
end

function var_0_0.isVersionLess(arg_5_0)
	local var_5_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_5_0, arg_5_0) < 0
end

function var_0_0.isVersionLessEqual(arg_6_0)
	local var_6_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_6_0, arg_6_0) <= 0
end

function var_0_0.isVersionEqual(arg_7_0)
	local var_7_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_7_0, arg_7_0) == 0
end

function var_0_0.isVersionNotEqual(arg_8_0)
	local var_8_0 = UnityEngine.Application.version

	return var_0_0.compareVersion(var_8_0, arg_8_0) ~= 0
end

return var_0_0
