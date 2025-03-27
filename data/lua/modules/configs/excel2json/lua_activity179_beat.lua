module("modules.configs.excel2json.lua_activity179_beat", package.seeall)

slot1 = {
	targetId = 3,
	time = 6,
	noteGroupId = 4,
	id = 2,
	resouce = 5,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
