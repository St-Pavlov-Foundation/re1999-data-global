module("modules.configs.excel2json.lua_handbook_story_group", package.seeall)

slot1 = {
	nameEn = 6,
	name = 5,
	time = 8,
	date = 7,
	episodeId = 4,
	image = 13,
	fragmentIdList = 12,
	storyChapterId = 3,
	storyIdList = 10,
	levelIdDict = 11,
	year = 9,
	id = 1,
	order = 2
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
