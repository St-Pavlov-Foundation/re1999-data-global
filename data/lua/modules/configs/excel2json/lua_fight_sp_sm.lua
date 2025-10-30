module("modules.configs.excel2json.lua_fight_sp_sm", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 5,
	action = 3,
	buffId = 2,
	skinId = 1,
	duration = 6,
	nextActionName = 7,
	actionName = 4
}
local var_0_2 = {
	"skinId",
	"buffId",
	"action"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
