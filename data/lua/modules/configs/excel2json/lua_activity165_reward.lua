module("modules.configs.excel2json.lua_activity165_reward", package.seeall)

slot1 = {
	bonus = 3,
	showPos = 4,
	endingCount = 2,
	storyId = 1
}
slot2 = {
	"storyId",
	"endingCount"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
