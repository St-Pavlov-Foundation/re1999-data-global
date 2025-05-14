module("modules.configs.excel2json.lua_skin_ui_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	delayVisible = 5,
	effect = 2,
	id = 1,
	changeVisible = 4,
	realtime = 7,
	scale = 3,
	frameVisible = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
