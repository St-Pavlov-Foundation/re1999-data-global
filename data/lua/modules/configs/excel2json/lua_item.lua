module("modules.configs.excel2json.lua_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isTimeShow = 12,
	name = 2,
	cd = 15,
	isShow = 11,
	boxOpen = 20,
	activityId = 18,
	sources = 19,
	desc = 4,
	rare = 8,
	subType = 5,
	icon = 7,
	price = 17,
	expireTime = 16,
	effect = 14,
	useDesc = 3,
	headIconSign = 21,
	clienttag = 6,
	id = 1,
	isStackable = 10,
	isDynamic = 13,
	highQuality = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
