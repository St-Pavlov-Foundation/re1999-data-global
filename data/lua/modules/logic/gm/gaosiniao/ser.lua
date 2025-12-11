local var_0_0 = pairs
local var_0_1 = ipairs
local var_0_2 = tostring
local var_0_3 = type
local var_0_4 = table.concat
local var_0_5 = string.dump
local var_0_6 = math.floor
local var_0_7 = string.format

local function var_0_8(arg_1_0)
	return "\\" .. arg_1_0:byte()
end

local function var_0_9(arg_2_0)
	return ("%q"):format(arg_2_0):gsub("\n", "n"):gsub("[\x80-\xFF]", var_0_8)
end

local var_0_10 = {
	[var_0_2(1 / 0)] = "1/0",
	[var_0_2(-1 / 0)] = "-1/0",
	[var_0_2(-(0 / 0))] = "-(0/0)",
	[var_0_2(0 / 0)] = "0/0"
}

local function var_0_11(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_3(arg_3_0)

	if var_3_0 == "number" then
		arg_3_0 = var_0_7("%.17g", arg_3_0)

		return var_0_10[arg_3_0] or arg_3_0
	elseif var_3_0 == "boolean" or var_3_0 == "nil" then
		return var_0_2(arg_3_0)
	elseif var_3_0 == "string" then
		return var_0_9(arg_3_0)
	elseif var_3_0 == "table" or var_3_0 == "function" then
		if not arg_3_1[arg_3_0] then
			local var_3_1 = #arg_3_2 + 1

			arg_3_1[arg_3_0] = var_3_1
			arg_3_2[var_3_1] = arg_3_0
		end

		return "_[" .. arg_3_1[arg_3_0] .. "]"
	else
		error("Trying to serialize unsupported type " .. var_3_0)
	end
end

local var_0_12 = {
	["in"] = true,
	["end"] = true,
	["function"] = true,
	["true"] = true,
	["elseif"] = true,
	["repeat"] = true,
	goto = true,
	["then"] = true,
	["and"] = true,
	["until"] = true,
	["nil"] = true,
	["while"] = true,
	["or"] = true,
	["do"] = true,
	["for"] = true,
	["return"] = true,
	["if"] = true,
	["not"] = true,
	["local"] = true,
	["else"] = true,
	["break"] = true,
	["false"] = true
}

local function var_0_13(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if var_0_3(arg_4_0) == "string" and arg_4_0:match("^[_%a][_%w]*$") and not var_0_12[arg_4_0] then
		return (arg_4_4 and arg_4_4 .. "." or "") .. arg_4_0 .. "=" .. var_0_11(arg_4_1, arg_4_2, arg_4_3)
	else
		return (arg_4_4 or "") .. "[" .. var_0_11(arg_4_0, arg_4_2, arg_4_3) .. "]=" .. var_0_11(arg_4_1, arg_4_2, arg_4_3)
	end
end

local function var_0_14(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0[arg_5_1]
	local var_5_1 = arg_5_0[arg_5_2]

	return var_5_0 and var_5_1 and var_5_0 < var_5_1
end

local function var_0_15(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if var_0_3(arg_6_0) == "function" then
		return "_[" .. arg_6_4 .. "]=loadstring" .. var_0_9(var_0_5(arg_6_0))
	end

	local var_6_0 = {}
	local var_6_1 = 1

	for iter_6_0 = 1, #arg_6_0 do
		local var_6_2 = arg_6_0[iter_6_0]

		if var_6_2 == arg_6_0 or var_0_14(arg_6_1, var_6_2, arg_6_0) then
			arg_6_3[#arg_6_3 + 1] = {
				arg_6_4,
				iter_6_0,
				var_6_2
			}
			var_6_0[var_6_1] = "nil"
			var_6_1 = var_6_1 + 1
		else
			var_6_0[var_6_1] = var_0_11(var_6_2, arg_6_1, arg_6_2)
			var_6_1 = var_6_1 + 1
		end
	end

	for iter_6_1, iter_6_2 in var_0_0(arg_6_0) do
		if var_0_3(iter_6_1) ~= "number" or var_0_6(iter_6_1) ~= iter_6_1 or iter_6_1 < 1 or iter_6_1 > #arg_6_0 then
			if iter_6_2 == arg_6_0 or iter_6_1 == arg_6_0 or var_0_14(arg_6_1, iter_6_2, arg_6_0) or var_0_14(arg_6_1, iter_6_1, arg_6_0) then
				arg_6_3[#arg_6_3 + 1] = {
					arg_6_4,
					iter_6_1,
					iter_6_2
				}
			else
				var_6_0[var_6_1] = var_0_13(iter_6_1, iter_6_2, arg_6_1, arg_6_2)
				var_6_1 = var_6_1 + 1
			end
		end
	end

	return "_[" .. arg_6_4 .. "]={" .. var_0_4(var_6_0, ",") .. "}"
end

return function(arg_7_0)
	local var_7_0 = {
		[arg_7_0] = 0
	}
	local var_7_1 = {
		[0] = arg_7_0
	}
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = 0

	while var_7_1[var_7_4] do
		var_7_3[var_7_4 + 1] = var_0_15(var_7_1[var_7_4], var_7_0, var_7_1, var_7_2, var_7_4)
		var_7_4 = var_7_4 + 1
	end

	for iter_7_0 = 1, var_7_4 * 0.5 do
		local var_7_5 = var_7_4 - iter_7_0 + 1

		var_7_3[iter_7_0], var_7_3[var_7_5] = var_7_3[var_7_5], var_7_3[iter_7_0]
	end

	for iter_7_1, iter_7_2 in var_0_1(var_7_2) do
		var_7_4 = var_7_4 + 1
		var_7_3[var_7_4] = var_0_13(iter_7_2[2], iter_7_2[3], var_7_0, var_7_1, "_[" .. iter_7_2[1] .. "]")
	end

	if var_7_3[var_7_4]:sub(1, 5) == "_[0]=" then
		var_7_3[var_7_4] = "return " .. var_7_3[var_7_4]:sub(6)
	else
		var_7_3[var_7_4 + 1] = "return _[0]"
	end

	local var_7_6 = var_0_4(var_7_3, "\n")

	return var_7_4 > 1 and "local _={}\n" .. var_7_6 or var_7_6
end
