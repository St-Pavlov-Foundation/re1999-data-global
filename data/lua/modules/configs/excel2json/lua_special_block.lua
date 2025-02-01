module("modules.configs.excel2json.lua_special_block", package.seeall)

slot1 = {
	name = 2,
	sources = 8,
	useDesc = 3,
	duplicateItem = 11,
	age = 10,
	rare = 6,
	desc = 4,
	heroId = 9,
	id = 1,
	icon = 5,
	nameEn = 7
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
