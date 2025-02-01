module("modules.configs.excel2json.lua_hero_invitation", package.seeall)

slot1 = {
	head = 3,
	rewardDisplayList = 4,
	name = 2,
	storyId = 6,
	id = 1,
	elementId = 5,
	restoryId = 7,
	openTime = 8
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
