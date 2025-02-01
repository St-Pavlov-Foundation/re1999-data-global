module("modules.configs.excel2json.lua_activity126_buff", package.seeall)

slot1 = {
	cost = 9,
	name = 4,
	dreamlandCard = 7,
	type = 3,
	taskId = 10,
	bigIcon = 12,
	desc = 5,
	preBuffId = 8,
	skillId = 6,
	id = 1,
	icon = 11,
	activityId = 2
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
