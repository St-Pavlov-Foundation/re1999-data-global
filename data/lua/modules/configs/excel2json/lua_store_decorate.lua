module("modules.configs.excel2json.lua_store_decorate", package.seeall)

slot1 = {
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
	buylmg = 10,
	offTag = 16,
	rare = 6,
	effectbiglmg = 19,
	originalCost2 = 15,
	onlineTag = 12,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	tag1 = 2,
	typeName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
