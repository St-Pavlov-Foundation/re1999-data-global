module("modules.configs.excel2json.lua_siege_battle", package.seeall)

slot1 = {
	stage = 2,
	heroId = 5,
	instructionDesc = 6,
	episodeId = 7,
	id = 1,
	unlockCondition = 4,
	sort = 3
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
