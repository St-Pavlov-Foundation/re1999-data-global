module("modules.configs.excel2json.lua_scene_switch", package.seeall)

slot1 = {
	eggSwitchTime = 8,
	initReportId = 9,
	itemId = 3,
	storyId = 12,
	reportSwitchTime = 10,
	previewIcon = 5,
	eggList = 7,
	resName = 6,
	previews = 11,
	id = 1,
	icon = 4,
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
