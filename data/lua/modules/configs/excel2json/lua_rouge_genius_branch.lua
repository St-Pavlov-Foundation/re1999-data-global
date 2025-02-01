module("modules.configs.excel2json.lua_rouge_genius_branch", package.seeall)

slot1 = {
	cost = 11,
	openDesc = 8,
	isOrigin = 14,
	startView = 13,
	season = 1,
	show = 12,
	pos = 6,
	desc = 15,
	effects = 9,
	talent = 3,
	initialCollection = 10,
	name = 4,
	id = 2,
	icon = 16,
	before = 5,
	attribute = 7
}
slot2 = {
	"season",
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
