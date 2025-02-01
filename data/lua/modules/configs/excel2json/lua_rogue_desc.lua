module("modules.configs.excel2json.lua_rogue_desc", package.seeall)

slot1 = {
	baseDesc = 10,
	name = 2,
	effectId = 7,
	tag3 = 5,
	tag2 = 4,
	attrDesc = 9,
	desc = 8,
	tag4 = 6,
	tag1 = 3,
	id = 1
}
slot2 = {
	"id",
	"effectId"
}
slot3 = {
	baseDesc = 8,
	name = 1,
	tag4 = 5,
	tag1 = 2,
	tag3 = 4,
	tag2 = 3,
	attrDesc = 7,
	desc = 6
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
