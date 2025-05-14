module("modules.configs.excel2json.lua_scene_eggs", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	parallel = 5,
	actionClass = 3,
	id = 1,
	actionParams = 4,
	path = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
