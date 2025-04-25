module("modules.configs.excel2json.lua_item", package.seeall)

slot1 = {
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
	clienttag = 6,
	id = 1,
	isStackable = 10,
	isDynamic = 13,
	highQuality = 9
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
