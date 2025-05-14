module("modules.configs.excel2json.lua_dialog_step", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	name = 5,
	avatar = 6,
	type = 3,
	groupId = 1,
	chessId = 7,
	content = 4
}
local var_0_2 = {
	"groupId",
	"id"
}
local var_0_3 = {
	content = 1,
	name = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
