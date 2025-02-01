module("modules.configs.excel2json.lua_explore_hero_effect", package.seeall)

slot1 = {
	audioId = 5,
	status = 1,
	index = 2,
	effectPath = 3,
	hangPath = 4
}
slot2 = {
	"status",
	"index"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
