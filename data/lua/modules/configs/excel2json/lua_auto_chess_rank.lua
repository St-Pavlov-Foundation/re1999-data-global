module("modules.configs.excel2json.lua_auto_chess_rank", package.seeall)

slot1 = {
	rankId = 2,
	name = 4,
	protection = 5,
	score = 6,
	reward = 8,
	icon = 3,
	activityId = 1,
	round2Score = 7
}
slot2 = {
	"activityId",
	"rankId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
