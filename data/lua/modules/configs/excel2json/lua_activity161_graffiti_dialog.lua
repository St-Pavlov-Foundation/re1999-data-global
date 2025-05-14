module("modules.configs.excel2json.lua_activity161_graffiti_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stepId = 2,
	dialogId = 1,
	chessId = 3,
	dialog = 4
}
local var_0_2 = {
	"dialogId",
	"stepId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
