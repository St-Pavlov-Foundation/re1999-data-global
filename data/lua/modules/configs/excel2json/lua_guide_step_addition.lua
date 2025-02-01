module("modules.configs.excel2json.lua_guide_step_addition", package.seeall)

slot1 = {
	desc = 3,
	exception = 24,
	storyContent = 12,
	stepId = 2,
	tipsHead = 7,
	stat = 5,
	tipsTalker = 9,
	uiOffset = 15,
	keyStep = 4,
	maskId = 14,
	goPath = 17,
	againSteps = 23,
	uiInfo = 16,
	tipsContent = 10,
	exceptionDelay = 25,
	notForce = 18,
	action = 21,
	audio = 13,
	delay = 20,
	additionCmd = 22,
	touchGOPath = 19,
	portraitPos = 8,
	tipsPos = 6,
	id = 1,
	tipsDir = 11
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	storyContent = 3,
	tipsTalker = 1,
	tipsContent = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
