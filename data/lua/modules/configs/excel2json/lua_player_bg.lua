module("modules.configs.excel2json.lua_player_bg", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bg = 6,
	name = 2,
	item = 4,
	chatbg = 8,
	bgEffect = 7,
	desc = 3,
	infobg = 9,
	id = 1,
	lockdesc = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	lockdesc = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
