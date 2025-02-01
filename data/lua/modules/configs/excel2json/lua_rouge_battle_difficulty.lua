module("modules.configs.excel2json.lua_rouge_battle_difficulty", package.seeall)

slot1 = {
	difficultyFix1 = 2,
	attrChange8 = 17,
	layerChange5 = 24,
	attrChange1 = 3,
	layerChange4 = 23,
	attrChange2 = 5,
	layerChange2 = 21,
	attrChange3 = 7,
	difficultyFix7 = 14,
	attrChange4 = 9,
	layerChange1 = 20,
	difficultyFix9 = 18,
	difficultyFix3 = 6,
	difficultyFix6 = 12,
	attrChange9 = 19,
	difficultyFix5 = 10,
	difficultyFix8 = 16,
	layerChange3 = 22,
	difficultyFix2 = 4,
	attrChange5 = 11,
	id = 1,
	attrChange6 = 13,
	difficultyFix4 = 8,
	attrChange7 = 15
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
