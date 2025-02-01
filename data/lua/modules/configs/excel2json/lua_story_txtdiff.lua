module("modules.configs.excel2json.lua_story_txtdiff", package.seeall)

slot1 = {
	kr = 6,
	de = 8,
	cn = 3,
	tw = 4,
	thai = 10,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	lanType = 2
}
slot2 = {
	"id",
	"lanType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
