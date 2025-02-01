module("modules.configs.excel2json.lua_story_pictxt", package.seeall)

slot1 = {
	kr = 6,
	de = 8,
	zh = 3,
	tw = 4,
	fontType = 2,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	thai = 10
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
