module("modules.configs.excel2json.lua_critter_hero_preference", package.seeall)

slot1 = {
	preferenceValue = 3,
	attachEventId = 8,
	attachAttribute = 10,
	preferenceType = 2,
	attachStoryId = 11,
	addIncrRate = 6,
	desc = 7,
	attachOption = 9,
	heroId = 1,
	spEventId = 12,
	critterIcon = 4,
	effectAttribute = 5
}
slot2 = {
	"heroId"
}
slot3 = {
	attachOption = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
