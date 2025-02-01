module("modules.configs.excel2json.lua_activity153_extra_bonus", package.seeall)

slot1 = {
	chapterId = 3,
	extraBonus = 4,
	activityId = 1,
	episodeId = 2
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
