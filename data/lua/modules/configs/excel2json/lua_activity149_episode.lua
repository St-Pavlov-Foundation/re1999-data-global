module("modules.configs.excel2json.lua_activity149_episode", package.seeall)

slot1 = {
	order = 4,
	multi = 5,
	firstPassScore = 6,
	id = 1,
	effectCondition = 7,
	activityId = 2,
	episodeId = 3
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
