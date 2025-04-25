module("modules.configs.excel2json.lua_actvity186_stage", package.seeall)

slot1 = {
	stageId = 2,
	globalTaskId = 6,
	globalTaskActivityId = 5,
	endTime = 4,
	activityId = 1,
	startTime = 3
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
