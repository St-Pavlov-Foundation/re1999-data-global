module("modules.configs.excel2json.lua_activity128_counttask", package.seeall)

slot1 = {
	task = 3,
	stage = 1,
	activityId = 2,
	taskPoint = 4
}
slot2 = {
	"stage",
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
