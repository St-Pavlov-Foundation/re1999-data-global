module("modules.configs.excel2json.lua_store_decorate", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	productType = 3,
	video = 11,
	smalllmg = 8,
	decorateskinOffset = 17,
	biglmg = 9,
	typeName = 5,
	maxbuycountType = 7,
	decorateskinl2dOffset = 18,
	originalCost1 = 14,
	subType = 4,
	tag1 = 13,
	storeld = 2,
	showskinId = 20,
	buylmg = 10,
	offTag = 16,
	rare = 6,
	effectbiglmg = 19,
	originalCost2 = 15,
	onlineTag = 12,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tag1 = 2,
	typeName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
