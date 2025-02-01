module("modules.configs.excel2json.lua_bossrush_skin_effect", package.seeall)

slot1 = {
	effects = 3,
	scales = 5,
	id = 1,
	stage = 2,
	hangpoints = 4
}
slot2 = {
	"id",
	"stage"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
