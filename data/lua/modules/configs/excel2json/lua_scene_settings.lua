module("modules.configs.excel2json.lua_scene_settings", package.seeall)

slot1 = {
	spineOffset = 2,
	lightColor2 = 4,
	prefabLightStartRotation = 7,
	lightColor3 = 5,
	id = 1,
	lightColor4 = 6,
	effectLightStartRotation = 8,
	lightColor1 = 3
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
