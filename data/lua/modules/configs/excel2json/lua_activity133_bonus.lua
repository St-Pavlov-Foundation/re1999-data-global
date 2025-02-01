module("modules.configs.excel2json.lua_activity133_bonus", package.seeall)

slot1 = {
	finalBonus = 9,
	title = 3,
	pos = 8,
	desc = 4,
	needTokens = 7,
	id = 2,
	icon = 5,
	activityId = 1,
	bonus = 6
}
slot2 = {
	"activityId",
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
