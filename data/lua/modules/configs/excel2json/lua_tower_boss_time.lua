module("modules.configs.excel2json.lua_tower_boss_time", package.seeall)

slot1 = {
	startTime = 4,
	isOnline = 7,
	isPermanent = 3,
	endTime = 5,
	taskGroupId = 6,
	round = 2,
	towerId = 1
}
slot2 = {
	"towerId",
	"round"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
