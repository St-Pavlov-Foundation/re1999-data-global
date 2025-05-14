module("modules.configs.excel2json.lua_activity108_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	pos = 9,
	conditionParam = 4,
	type = 5,
	group = 6,
	title = 8,
	condition = 3,
	episodeId = 2,
	interactParam = 7,
	model = 10,
	id = 1,
	modelPos = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
