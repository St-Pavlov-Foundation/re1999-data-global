module("modules.configs.excel2json.lua_assassin_monster", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 3,
	boss = 5,
	scanRate = 4,
	type = 2,
	position = 9,
	icon = 10,
	rule = 7,
	posOrder = 11,
	model = 6,
	id = 1,
	notMove = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
