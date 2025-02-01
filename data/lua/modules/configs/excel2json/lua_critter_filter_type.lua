module("modules.configs.excel2json.lua_critter_filter_type", package.seeall)

slot1 = {
	tabIcon = 6,
	name = 2,
	tabName = 5,
	id = 1,
	filterTab = 4,
	nameEn = 3
}
slot2 = {
	"id"
}
slot3 = {
	tabName = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
