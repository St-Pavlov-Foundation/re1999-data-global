module("modules.configs.excel2json.lua_scene_effect_settings", package.seeall)

slot1 = {
	tag = 4,
	lightColor3 = 8,
	path = 3,
	sceneId = 1,
	lightColor2 = 7,
	colorKey = 5,
	id = 2,
	lightColor4 = 9,
	lightColor1 = 6
}
slot2 = {
	"sceneId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
