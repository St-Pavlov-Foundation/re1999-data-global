module("modules.configs.excel2json.lua_rouge_talent_branch", package.seeall)

slot1 = {
	cost = 8,
	name = 3,
	isOrigin = 9,
	before = 4,
	pos = 5,
	desc = 10,
	talent = 2,
	special = 7,
	id = 1,
	icon = 11,
	attribute = 6
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
