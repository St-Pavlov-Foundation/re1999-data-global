module("modules.configs.excel2json.lua_activity211_game", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 5,
	shadowBg = 4,
	groupId = 1,
	targetDesc = 3,
	gameId = 2
}
local var_0_2 = {
	"groupId"
}
local var_0_3 = {
	targetDesc = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
