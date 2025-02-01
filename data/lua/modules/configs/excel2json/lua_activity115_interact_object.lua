module("modules.configs.excel2json.lua_activity115_interact_object", package.seeall)

slot1 = {
	alertType = 8,
	name = 3,
	id = 2,
	param = 5,
	battleDesc = 11,
	alertParam = 9,
	showParam = 7,
	battleName = 10,
	recommendLevel = 12,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	battleDesc = 3,
	name = 1,
	battleName = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
