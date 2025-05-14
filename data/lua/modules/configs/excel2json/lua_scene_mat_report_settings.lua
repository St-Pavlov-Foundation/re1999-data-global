module("modules.configs.excel2json.lua_scene_mat_report_settings", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	sceneId = 1,
	lightmap = 4,
	mat = 3
}
local var_0_2 = {
	"sceneId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
