module("modules.configs.excel2json.lua_activity134_bonus", package.seeall)

slot1 = {
	showTab = 5,
	introduce = 8,
	desc = 7,
	id = 2,
	bonus = 10,
	title = 6,
	number = 3,
	needTokens = 11,
	storyType = 4,
	activityId = 1,
	due = 9
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 3,
	introduce = 4,
	due = 5,
	title = 2,
	number = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
