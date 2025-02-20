module("modules.configs.excel2json.lua_tower_limited_time", package.seeall)

slot1 = {
	bossPool = 4,
	isOnline = 6,
	endTime = 3,
	season = 1,
	taskGroupId = 5,
	startTime = 2
}
slot2 = {
	"season"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
