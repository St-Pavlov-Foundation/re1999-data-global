module("modules.configs.excel2json.lua_activity104_special", package.seeall)

slot1 = {
	episodeId = 3,
	name = 4,
	level = 7,
	nameen = 5,
	desc = 8,
	icon = 6,
	activityId = 1,
	layer = 2
}
slot2 = {
	"activityId",
	"layer"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
