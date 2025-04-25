module("modules.configs.excel2json.lua_critter_tag_effect", package.seeall)

slot1 = {
	catalogue = 3,
	target = 2,
	previewCondition = 5,
	type = 6,
	id = 1,
	parameter = 7,
	condition = 4
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
