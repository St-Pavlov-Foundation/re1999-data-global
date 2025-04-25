module("modules.configs.excel2json.lua_critter_tag", package.seeall)

slot1 = {
	id = 1,
	name = 7,
	inheritance = 10,
	type = 2,
	group = 3,
	luckyItemIds = 12,
	luckyItemType = 11,
	desc = 8,
	effects = 9,
	needAttributeLevel = 4,
	skillIcon = 5,
	filterTag = 6
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
