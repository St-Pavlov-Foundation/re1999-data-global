module("modules.configs.excel2json.lua_rouge_fight_event", package.seeall)

slot1 = {
	interactive = 7,
	title = 2,
	versionInteractive = 9,
	type = 3,
	versionEvent = 10,
	advanceInteractive = 8,
	bossMask = 13,
	episodeId = 4,
	versionEpisode = 5,
	monsterMask = 12,
	id = 1,
	isChangeScene = 11,
	bossDesc = 14,
	episodeIdInstead = 6
}
slot2 = {
	"id"
}
slot3 = {
	bossDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
