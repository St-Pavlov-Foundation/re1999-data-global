module("modules.configs.excel2json.lua_activity135_reward", package.seeall)

slot1 = {
	firstBounsId = 3,
	activityId = 2,
	episodeId = 1
}
slot2 = {
	"episodeId",
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
