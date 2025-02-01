module("modules.configs.excel2json.lua_activity144_option", package.seeall)

slot1 = {
	activityId = 1,
	name = 5,
	optionResults = 4,
	conditionDesc = 3,
	optionDesc = 6,
	optionId = 2
}
slot2 = {
	"activityId",
	"optionId"
}
slot3 = {
	conditionDesc = 1,
	name = 2,
	optionDesc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
