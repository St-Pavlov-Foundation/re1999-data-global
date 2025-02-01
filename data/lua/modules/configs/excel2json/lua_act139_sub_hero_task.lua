module("modules.configs.excel2json.lua_act139_sub_hero_task", package.seeall)

slot1 = {
	reward = 8,
	descSuffix = 7,
	desc = 6,
	storyId = 3,
	title = 4,
	image = 5,
	unlockParam = 11,
	taskId = 2,
	lockDesc = 12,
	unlockType = 10,
	id = 1,
	elementIds = 9
}
slot2 = {
	"id"
}
slot3 = {
	descSuffix = 3,
	title = 1,
	lockDesc = 4,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
