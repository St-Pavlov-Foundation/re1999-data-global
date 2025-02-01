module("modules.configs.excel2json.lua_scene_switch", package.seeall)

slot1 = {
	itemId = 3,
	previews = 7,
	resName = 6,
	storyId = 8,
	id = 1,
	icon = 4,
	previewIcon = 5,
	defaultUnlock = 2
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
