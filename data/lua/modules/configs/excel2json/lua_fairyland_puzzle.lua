module("modules.configs.excel2json.lua_fairyland_puzzle", package.seeall)

slot1 = {
	id = 1,
	afterTalkId = 5,
	errorTalkId = 8,
	beforeTalkId = 4,
	storyTalkId = 9,
	elementId = 3,
	successTalkId = 6,
	tipsTalkId = 7,
	answer = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
