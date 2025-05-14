module("modules.configs.excel2json.lua_scene_effect_settings", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tag = 4,
	lightColor3 = 8,
	path = 3,
	sceneId = 1,
	lightColor2 = 7,
	colorKey = 5,
	id = 2,
	lightColor4 = 9,
	lightColor1 = 6
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
