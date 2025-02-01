module("modules.configs.excel2json.lua_activity165_ending", package.seeall)

slot1 = {
	text = 5,
	level = 6,
	pic = 7,
	endingText = 4,
	endingId = 1,
	finalStepId = 3,
	belongStoryId = 2
}
slot2 = {
	"endingId"
}
slot3 = {
	text = 2,
	endingText = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
