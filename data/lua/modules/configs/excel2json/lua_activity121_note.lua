module("modules.configs.excel2json.lua_activity121_note", package.seeall)

slot1 = {
	name = 3,
	unlockType = 4,
	noteId = 1,
	fightId = 6,
	desc = 7,
	content = 8,
	activityId = 2,
	episodeId = 5
}
slot2 = {
	"noteId",
	"activityId"
}
slot3 = {
	name = 1,
	content = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
