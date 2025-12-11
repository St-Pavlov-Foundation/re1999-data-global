module("modules.configs.excel2json.lua_survival_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc2 = 6,
	name = 2,
	sellPrice = 8,
	type = 10,
	desc1 = 5,
	worth = 16,
	overlayLimit = 17,
	isDestroy = 18,
	versions = 3,
	subType = 11,
	enhanceCond = 21,
	copyItem = 23,
	icon = 9,
	cost = 15,
	effect = 20,
	deposit = 12,
	maxLimit = 22,
	exchange = 19,
	rare = 13,
	seasons = 4,
	id = 1,
	disposable = 7,
	mass = 14
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
