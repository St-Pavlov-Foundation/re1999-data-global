module("modules.configs.excel2json.lua_explore_unit", package.seeall)

slot1 = {
	mapIcon2 = 6,
	asset = 9,
	type = 1,
	mapIconShow = 8,
	mapIcon = 5,
	icon2 = 4,
	icon = 3,
	mapActiveIcon = 7,
	isShow = 2
}
slot2 = {
	"type"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
