module("modules.configs.excel2json.lua_antique", package.seeall)

slot1 = {
	sources = 10,
	name = 2,
	storyId = 11,
	nameen = 3,
	effect = 13,
	title = 7,
	desc = 9,
	titleen = 8,
	gifticon = 5,
	sign = 6,
	id = 1,
	icon = 4,
	iconArea = 12
}
slot2 = {
	"id"
}
slot3 = {
	title = 2,
	name = 1,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
