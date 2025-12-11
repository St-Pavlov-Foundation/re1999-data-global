local var_0_0 = _G.type
local var_0_1 = _G.assert
local var_0_2 = _G.setmetatable
local var_0_3 = _G.tostring
local var_0_4 = _G.next
local var_0_5 = string.format

local function var_0_6(arg_1_0, arg_1_1, arg_1_2)
	var_0_1(false, var_0_5("readonly !! k=%s, v=%s", var_0_3(arg_1_1), var_0_3(arg_1_2)))
end

return function(arg_2_0)
	var_0_1(var_0_0(arg_2_0) == "table")

	local function var_2_0(arg_3_0)
		return var_0_4, arg_2_0, nil
	end

	local function var_2_1()
		var_0_3(arg_2_0)
	end

	local function var_2_2()
		return #arg_2_0
	end

	local var_2_3 = getmetatable(arg_2_0)

	if var_2_3 then
		var_2_0 = var_2_3.__pairs
		var_2_1 = var_2_3.__tostring
		var_2_2 = var_2_3.__len
	end

	local var_2_4 = {
		__index = arg_2_0,
		__newindex = var_0_6,
		__pairs = var_2_0,
		__tostring = var_2_1,
		__len = var_2_2
	}

	return var_0_2({}, var_2_4)
end
