module("modules.configs.excel2json.lua_scene_ctrl", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	resName = 1,
	param2 = 4,
	param1 = 3,
	param4 = 6,
	ctrlName = 2,
	param3 = 5
}
local var_0_2 = {
	"resName",
	"ctrlName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
