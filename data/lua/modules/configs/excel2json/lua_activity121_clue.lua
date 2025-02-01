module("modules.configs.excel2json.lua_activity121_clue", package.seeall)

slot1 = {
	storyTag = 5,
	name = 3,
	clueId = 1,
	tagType = 4,
	activityId = 2
}
slot2 = {
	"clueId",
	"activityId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
