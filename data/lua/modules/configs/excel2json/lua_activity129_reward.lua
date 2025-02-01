module("modules.configs.excel2json.lua_activity129_reward", package.seeall)

slot1 = {
	initWeight = 3,
	changeWeight = 4,
	activityId = 1,
	poolId = 2
}
slot2 = {
	"activityId",
	"poolId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
