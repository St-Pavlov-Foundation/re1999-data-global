module("modules.configs.excel2json.lua_activity174_match", package.seeall)

slot1 = {
	score = 4,
	rank = 2,
	count = 3,
	matchRule = 5,
	robotRate = 9,
	matchRuleLimit = 6,
	lostValue = 8,
	activityId = 1,
	winValue = 7
}
slot2 = {
	"activityId",
	"rank",
	"count"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
