module("modules.configs.excel2json.lua_chapter_puzzle_changecolor", package.seeall)

slot1 = {
	interactbtns = 5,
	name = 2,
	colorsort = 6,
	id = 1,
	initColors = 3,
	finalColors = 4,
	bonus = 7
}
slot2 = {
	"id"
}
slot3 = {
	initColors = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
