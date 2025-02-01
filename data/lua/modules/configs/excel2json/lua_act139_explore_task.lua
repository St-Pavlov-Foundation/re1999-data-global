module("modules.configs.excel2json.lua_act139_explore_task", package.seeall)

slot1 = {
	storyId = 4,
	unlockParam = 12,
	unlockDesc = 13,
	type = 3,
	unlockToastDesc = 14,
	title = 5,
	pos = 9,
	desc = 7,
	unlockLineNumbers = 15,
	unlockType = 11,
	areaPos = 8,
	titleEn = 6,
	id = 1,
	activityId = 2,
	elementIds = 10
}
slot2 = {
	"id"
}
slot3 = {
	unlockDesc = 3,
	title = 1,
	unlockToastDesc = 4,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
