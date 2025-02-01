module("modules.configs.excel2json.lua_activity123_retail", package.seeall)

slot1 = {
	desc = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	episodeId = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
