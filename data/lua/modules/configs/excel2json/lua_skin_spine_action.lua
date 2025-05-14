module("modules.configs.excel2json.lua_skin_spine_action", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 6,
	effect = 3,
	effectRemoveTime = 5,
	skinId = 1,
	effectHangPoint = 4,
	dieAnim = 7,
	actionName = 2
}
local var_0_2 = {
	"skinId",
	"actionName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
