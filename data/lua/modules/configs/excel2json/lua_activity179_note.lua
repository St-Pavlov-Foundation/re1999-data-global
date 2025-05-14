module("modules.configs.excel2json.lua_activity179_note", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	musicId = 2,
	time = 5,
	eventName = 4,
	id = 1,
	buttonId = 3
}
local var_0_2 = {
	"id",
	"musicId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
