module("modules.configs.excel2json.lua_rogue_difficulty", package.seeall)

slot1 = {
	effect1 = 15,
	initRoom = 5,
	effectDesc1 = 14,
	scoreAdd = 11,
	effect3 = 19,
	title = 2,
	initHeroCount = 12,
	effect2 = 17,
	effectDesc3 = 18,
	initCurrency = 6,
	initHeart = 7,
	difficulty = 1,
	preDifficulty = 3,
	attrAdd = 10,
	rule = 8,
	effectDesc2 = 16,
	showDifficulty = 9,
	retries = 13,
	initLevel = 4
}
slot2 = {
	"difficulty"
}
slot3 = {
	effectDesc1 = 2,
	title = 1,
	effectDesc3 = 4,
	effectDesc2 = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
