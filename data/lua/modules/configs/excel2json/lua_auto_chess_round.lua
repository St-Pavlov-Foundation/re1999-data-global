module("modules.configs.excel2json.lua_auto_chess_round", package.seeall)

slot1 = {
	activityId = 1,
	assess = 5,
	maxdamage = 4,
	starReward = 6,
	round = 2,
	previewCost = 3
}
slot2 = {
	"activityId",
	"round"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
