module("modules.configs.excel2json.lua_activity106_minigame", package.seeall)

slot1 = {
	minBlock = 2,
	blockCount = 4,
	victoryRound = 5,
	randomLength = 6,
	id = 1,
	levelTime = 3,
	matPool = 8,
	pointerSpeed = 7
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
