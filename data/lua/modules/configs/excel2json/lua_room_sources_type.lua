module("modules.configs.excel2json.lua_room_sources_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	showType = 7,
	name = 2,
	bgColor = 6,
	nameColor = 5,
	id = 1,
	bgIcon = 4,
	order = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
