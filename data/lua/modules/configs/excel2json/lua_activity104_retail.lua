module("modules.configs.excel2json.lua_activity104_retail", package.seeall)

slot1 = {
	retailEpisodeIdPool = 3,
	equipRareWeight = 6,
	activityId = 1,
	stage = 2,
	enemyTag = 4,
	level = 5
}
slot2 = {
	"activityId",
	"stage"
}
slot3 = {
	enemyTag = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
