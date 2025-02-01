module("modules.configs.excel2json.lua_activity157_mission", package.seeall)

slot1 = {
	groupId = 3,
	area = 9,
	storyId = 7,
	linePrefab = 8,
	pos = 6,
	elementId = 5,
	missionId = 2,
	activityId = 1,
	order = 4
}
slot2 = {
	"activityId",
	"missionId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
