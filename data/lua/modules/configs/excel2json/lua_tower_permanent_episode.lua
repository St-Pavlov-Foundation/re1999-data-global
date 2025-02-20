module("modules.configs.excel2json.lua_tower_permanent_episode", package.seeall)

slot1 = {
	stageId = 2,
	firstReward = 6,
	index = 8,
	preLayerId = 3,
	isElite = 4,
	layerId = 1,
	episodeIds = 5,
	spReward = 7
}
slot2 = {
	"layerId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
