module("modules.configs.excel2json.lua_activity160_mission", package.seeall)

slot1 = {
	bonus = 5,
	desc = 6,
	preId = 4,
	sort = 7,
	id = 2,
	episodeId = 8,
	activityId = 1,
	mailId = 3
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
