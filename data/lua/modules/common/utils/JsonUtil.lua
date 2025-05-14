module("modules.common.utils.JsonUtil", package.seeall)

local var_0_0 = {}

var_0_0.emptyArrayPlaceholder = "empty_array_placeholder_202205171648"

function var_0_0.encode(arg_1_0)
	var_0_0._add_placeholder(arg_1_0)

	local var_1_0 = cjson.encode(arg_1_0)

	if not string.nilorempty(var_1_0) then
		var_1_0 = string.gsub(var_1_0, "%[\"" .. var_0_0.emptyArrayPlaceholder .. "\"]", "[]")
	end

	return var_1_0
end

function var_0_0.markAsArray(arg_2_0)
	local var_2_0 = getmetatable(arg_2_0) or {}

	var_2_0.__jsontype = "array"

	setmetatable(arg_2_0, var_2_0)
end

function var_0_0._is_marked_as_array(arg_3_0)
	local var_3_0 = getmetatable(arg_3_0)

	return var_3_0 and var_3_0.__jsontype == "array"
end

function var_0_0._add_placeholder(arg_4_0, arg_4_1)
	if not arg_4_0 or not LuaUtil.isTable(arg_4_0) then
		return
	end

	local var_4_0 = true

	arg_4_1 = arg_4_1 or {}
	arg_4_1[arg_4_0] = true

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if not arg_4_1[iter_4_1] and LuaUtil.isTable(iter_4_1) then
			var_0_0._add_placeholder(iter_4_1, arg_4_1)
		end

		var_4_0 = false
	end

	if var_0_0._is_marked_as_array(arg_4_0) and var_4_0 then
		table.insert(arg_4_0, var_0_0.emptyArrayPlaceholder)
	end
end

return var_0_0
