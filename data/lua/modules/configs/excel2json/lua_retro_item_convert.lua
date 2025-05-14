module("modules.configs.excel2json.lua_retro_item_convert", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 2,
	limit = 3,
	version = 5,
	typeId = 1,
	price = 4
}
local var_0_2 = {
	"typeId",
	"itemId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
