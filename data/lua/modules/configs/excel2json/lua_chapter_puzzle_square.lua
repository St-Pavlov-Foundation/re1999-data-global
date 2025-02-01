module("modules.configs.excel2json.lua_chapter_puzzle_square", package.seeall)

slot1 = {
	id = 1,
	shape = 2,
	count = 3,
	group = 4
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
