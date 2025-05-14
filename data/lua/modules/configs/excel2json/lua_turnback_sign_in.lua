module("modules.configs.excel2json.lua_turnback_sign_in", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bonus = 3,
	name = 5,
	characterId = 4,
	turnbackId = 1,
	content = 6,
	day = 2
}
local var_0_2 = {
	"turnbackId",
	"day"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
