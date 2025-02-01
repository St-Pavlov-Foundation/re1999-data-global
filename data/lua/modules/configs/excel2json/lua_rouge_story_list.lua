module("modules.configs.excel2json.lua_rouge_story_list", package.seeall)

slot1 = {
	stageId = 4,
	name = 7,
	levelIdDict = 6,
	id = 2,
	season = 1,
	image = 5,
	storyIdList = 3,
	desc = 8
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
