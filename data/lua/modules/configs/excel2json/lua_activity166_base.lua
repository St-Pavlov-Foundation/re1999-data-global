module("modules.configs.excel2json.lua_activity166_base", package.seeall)

slot1 = {
	talentId = 4,
	name = 5,
	desc = 6,
	level = 7,
	baseId = 2,
	strategy = 8,
	activityId = 1,
	episodeId = 3
}
slot2 = {
	"activityId",
	"baseId"
}
slot3 = {
	strategy = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
