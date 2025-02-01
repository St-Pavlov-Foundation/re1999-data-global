module("modules.configs.excel2json.lua_chapter_map_element_dispatch", package.seeall)

slot1 = {
	desc = 8,
	id = 1,
	time = 4,
	image = 9,
	title = 7,
	unlockLineNumbers = 12,
	extraParam = 6,
	elementId = 10,
	shortType = 5,
	minCount = 2,
	maxCount = 3,
	activityId = 11
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
