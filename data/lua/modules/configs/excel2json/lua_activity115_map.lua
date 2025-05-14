module("modules.configs.excel2json.lua_activity115_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bgPath = 6,
	height = 4,
	ambientAudio = 5,
	activityId = 1,
	objects = 9,
	offset = 7,
	tilebase = 8,
	id = 2,
	width = 3
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
