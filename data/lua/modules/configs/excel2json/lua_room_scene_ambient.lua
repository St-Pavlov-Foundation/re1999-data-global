module("modules.configs.excel2json.lua_room_scene_ambient", package.seeall)

local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.confgData = arg_1_0
	var_0_0.configList, var_0_0.configDict = var_0_0.json_parse(arg_1_0)
end

function var_0_0.json_parse(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_0, iter_2_1)

		var_2_1[iter_2_1.id] = iter_2_1
	end

	return var_2_0, var_2_1
end

return var_0_0
