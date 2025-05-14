module("modules.configs.excel2json.lua_bossrush_skin_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effects = 3,
	scales = 5,
	id = 1,
	stage = 2,
	hangpoints = 4
}
local var_0_2 = {
	"id",
	"stage"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
