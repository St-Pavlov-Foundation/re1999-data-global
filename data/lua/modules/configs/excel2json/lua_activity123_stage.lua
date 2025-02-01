module("modules.configs.excel2json.lua_activity123_stage", package.seeall)

slot1 = {
	recommendSchool = 12,
	name = 4,
	preCondition = 3,
	finalScale = 9,
	initPos = 6,
	initScale = 7,
	stageCondition = 11,
	res = 5,
	finalPos = 8,
	stage = 2,
	activityId = 1,
	recommend = 10
}
slot2 = {
	"activityId",
	"stage"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
