module("modules.configs.excel2json.lua_chapter_point_reward", package.seeall)

slot1 = {
	reward = 4,
	display = 6,
	unlockChapter = 5,
	chapterId = 2,
	id = 1,
	rewardPointNum = 3
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
