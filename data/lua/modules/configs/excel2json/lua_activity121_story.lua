module("modules.configs.excel2json.lua_activity121_story", package.seeall)

slot1 = {
	noteIds = 6,
	name = 3,
	clueIds = 5,
	bonus = 7,
	id = 2,
	icon = 8,
	activityId = 1,
	episodeId = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
