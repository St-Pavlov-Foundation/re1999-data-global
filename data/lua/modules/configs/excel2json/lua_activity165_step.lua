module("modules.configs.excel2json.lua_activity165_step", package.seeall)

slot1 = {
	text = 6,
	stepId = 1,
	answersKeywordIds = 4,
	nextStepConditionIds = 5,
	optionalKeywordIds = 3,
	pic = 7,
	belongStoryId = 2
}
slot2 = {
	"stepId"
}
slot3 = {
	text = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
