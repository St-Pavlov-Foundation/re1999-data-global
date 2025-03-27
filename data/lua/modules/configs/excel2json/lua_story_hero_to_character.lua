module("modules.configs.excel2json.lua_story_hero_to_character", package.seeall)

slot1 = {
	heroIndex = 1,
	heroId = 2
}
slot2 = {
	"heroIndex"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
