module("modules.configs.excel2json.lua_activity157_mission_group", package.seeall)

slot1 = {
	type = 3,
	mapName = 4,
	activityId = 1,
	missionGroupId = 2
}
slot2 = {
	"activityId",
	"missionGroupId"
}
slot3 = {
	mapName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
