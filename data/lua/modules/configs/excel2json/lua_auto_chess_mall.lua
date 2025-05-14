module("modules.configs.excel2json.lua_auto_chess_mall", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	groups = 5,
	capacity = 6,
	showLevel = 4,
	type = 2,
	id = 1,
	canRefresh = 7,
	round = 3,
	isFree = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
