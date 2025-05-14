module("modules.configs.excel2json.lua_activity174_enhance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effects = 7,
	icon = 6,
	season = 2,
	coinValue = 8,
	id = 1,
	title = 4,
	rare = 3,
	desc = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
