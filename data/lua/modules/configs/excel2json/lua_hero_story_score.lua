module("modules.configs.excel2json.lua_hero_story_score", package.seeall)

slot1 = {
	id = 1,
	wave = 3,
	score = 4,
	storyId = 2
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
