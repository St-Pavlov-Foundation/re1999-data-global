module("modules.configs.excel2json.lua_chapter_map", package.seeall)

slot1 = {
	areaAudio = 8,
	effectAudio = 7,
	unlockCondition = 3,
	chapterId = 2,
	mapState = 9,
	initPos = 6,
	desc = 5,
	res = 4,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
