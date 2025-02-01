module("modules.configs.excel2json.lua_item", package.seeall)

slot1 = {
	isTimeShow = 11,
	name = 2,
	cd = 14,
	isShow = 10,
	boxOpen = 19,
	sources = 18,
	activityId = 17,
	desc = 4,
	subType = 5,
	icon = 6,
	price = 16,
	expireTime = 15,
	effect = 13,
	useDesc = 3,
	rare = 7,
	id = 1,
	isStackable = 9,
	isDynamic = 12,
	highQuality = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
