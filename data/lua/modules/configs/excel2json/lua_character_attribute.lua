module("modules.configs.excel2json.lua_character_attribute", package.seeall)

slot1 = {
	showType = 8,
	attrType = 2,
	name = 4,
	type = 3,
	showcolor = 9,
	sortId = 11,
	desc = 5,
	isShowTips = 6,
	id = 1,
	icon = 10,
	isShow = 7
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
