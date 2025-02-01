module("modules.configs.excel2json.lua_story_text_reflect", package.seeall)

slot1 = {
	id = 1,
	normalText = 3,
	magicText = 2
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
