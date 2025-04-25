module("modules.configs.excel2json.lua_actvity186_daily_group", package.seeall)

slot1 = {
	acceptInterval = 5,
	bonus = 6,
	rewardId = 2,
	groupId = 1,
	acceptTime = 3,
	isLoopBonus = 4
}
slot2 = {
	"groupId",
	"rewardId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
