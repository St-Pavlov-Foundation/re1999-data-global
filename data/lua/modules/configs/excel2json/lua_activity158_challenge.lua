module("modules.configs.excel2json.lua_activity158_challenge", package.seeall)

slot1 = {
	instructionDesc = 8,
	difficulty = 3,
	unlockCondition = 6,
	episodeId = 9,
	heroId = 7,
	id = 1,
	stage = 5,
	activityId = 2,
	sort = 4
}
slot2 = {
	"id"
}
slot3 = {
	instructionDesc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
