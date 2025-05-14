module("modules.configs.excel2json.lua_rouge_limit_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	needEmblem = 8,
	buffType = 5,
	cd = 9,
	startView = 6,
	blank = 10,
	title = 3,
	icon = 11,
	desc = 4,
	initCollections = 7,
	id = 1,
	version = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
