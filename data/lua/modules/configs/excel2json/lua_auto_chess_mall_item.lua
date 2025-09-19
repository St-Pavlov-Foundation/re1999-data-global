module("modules.configs.excel2json.lua_auto_chess_mall_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	context = 4,
	id = 1,
	goodsId = 2,
	cost = 5,
	group = 3,
	weight = 6,
	order = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
