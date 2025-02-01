module("modules.configs.excel2json.lua_activity170", package.seeall)

slot1 = {
	summonTimes = 4,
	itemId = 2,
	constId = 6,
	heroExtraDesc = 7,
	initWeight = 3,
	activityId = 1,
	poolId = 5
}
slot2 = {
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
