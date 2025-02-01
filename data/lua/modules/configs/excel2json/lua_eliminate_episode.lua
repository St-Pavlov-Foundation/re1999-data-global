module("modules.configs.excel2json.lua_eliminate_episode", package.seeall)

slot1 = {
	eliminateLevelId = 7,
	name = 2,
	chapterId = 5,
	preEpisode = 6,
	dialogueId = 9,
	posIndex = 4,
	levelPosition = 3,
	warChessId = 8,
	id = 1,
	aniPos = 10
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
