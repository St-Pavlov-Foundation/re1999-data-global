module("modules.configs.excel2json.lua_fight_asfd", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	replaceRule = 3,
	priority = 10,
	sampleMinHeight = 8,
	audio = 6,
	res = 4,
	sceneEmitterId = 5,
	id = 1,
	unit = 2,
	scale = 7,
	flyPath = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
