module("modules.common.utils.Base64Util", package.seeall)

local var_0_0 = _M

var_0_0.b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function var_0_0.encode(arg_1_0)
	return (arg_1_0:gsub(".", function(arg_2_0)
		local var_2_0 = ""
		local var_2_1 = arg_2_0:byte()

		for iter_2_0 = 8, 1, -1 do
			var_2_0 = var_2_0 .. (var_2_1 % 2^iter_2_0 - var_2_1 % 2^(iter_2_0 - 1) > 0 and "1" or "0")
		end

		return var_2_0
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg_3_0)
		if #arg_3_0 < 6 then
			return ""
		end

		local var_3_0 = 0

		for iter_3_0 = 1, 6 do
			var_3_0 = var_3_0 + (arg_3_0:sub(iter_3_0, iter_3_0) == "1" and 2^(6 - iter_3_0) or 0)
		end

		return var_0_0.b:sub(var_3_0 + 1, var_3_0 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#arg_1_0 % 3 + 1]
end

function var_0_0.decode(arg_4_0)
	arg_4_0 = string.gsub(arg_4_0, "data:image/jpeg;base64,", "", 1)
	arg_4_0 = string.gsub(arg_4_0, "data:image/png;base64,", "", 1)
	arg_4_0 = string.gsub(arg_4_0, "[^" .. var_0_0.b .. "=]", "")

	return (arg_4_0:gsub(".", function(arg_5_0)
		if arg_5_0 == "=" then
			return ""
		end

		local var_5_0 = ""
		local var_5_1 = var_0_0.b:find(arg_5_0) - 1

		for iter_5_0 = 6, 1, -1 do
			var_5_0 = var_5_0 .. (var_5_1 % 2^iter_5_0 - var_5_1 % 2^(iter_5_0 - 1) > 0 and "1" or "0")
		end

		return var_5_0
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(arg_6_0)
		if #arg_6_0 ~= 8 then
			return ""
		end

		local var_6_0 = 0

		for iter_6_0 = 1, 8 do
			var_6_0 = var_6_0 + (arg_6_0:sub(iter_6_0, iter_6_0) == "1" and 2^(8 - iter_6_0) or 0)
		end

		return string.char(var_6_0)
	end))
end

function var_0_0.saveImage(arg_7_0)
	local var_7_0 = var_0_0.decode(arg_7_0)
	local var_7_1 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local var_7_2 = System.DateTime.Now
	local var_7_3 = string.format("screenshot_%s%s%s_%s%s%s%s.png", var_7_2.Year, var_7_2.Month, var_7_2.Day, var_7_2.Hour, var_7_2.Minute, var_7_2.Second, var_7_2.Millisecond)
	local var_7_4 = System.IO.Path.Combine(var_7_1, var_7_3)

	SLFramework.FileHelper.WriteAllBytesToPath(var_7_4, var_7_0)
	SDKMgr.instance:saveImage(var_7_4)
end

return var_0_0
