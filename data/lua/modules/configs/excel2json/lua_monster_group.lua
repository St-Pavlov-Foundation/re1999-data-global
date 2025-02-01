module("modules.configs.excel2json.lua_monster_group", package.seeall)

slot1 = {
	bossId = 8,
	stanceId = 7,
	bgm = 10,
	appearMonsterId = 11,
	sp2Monster = 5,
	appearTimeline = 12,
	sp2Supporter = 6,
	spMonster = 3,
	appearCameraPos = 13,
	aiId = 9,
	spSupporter = 4,
	id = 1,
	monster = 2
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
