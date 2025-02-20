module("modules.configs.excel2json.lua_room_sources_type", package.seeall)

slot1 = {
	showType = 7,
	name = 2,
	bgColor = 6,
	nameColor = 5,
	id = 1,
	bgIcon = 4,
	order = 3
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
