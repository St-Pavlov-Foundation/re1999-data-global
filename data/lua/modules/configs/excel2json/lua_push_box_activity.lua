module("modules.configs.excel2json.lua_push_box_activity", package.seeall)

slot1 = {
	stageId = 2,
	episodeIds = 3,
	activityId = 1,
	openDay = 4
}
slot2 = {
	"activityId",
	"stageId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
