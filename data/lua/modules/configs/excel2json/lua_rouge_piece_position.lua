module("modules.configs.excel2json.lua_rouge_piece_position", package.seeall)

slot1 = {
	layerId = 3,
	unlockParam = 5,
	version = 2,
	pieceRes = 8,
	talkId = 11,
	entrustType = 7,
	title = 9,
	desc = 10,
	unlockType = 4,
	talkView = 12,
	id = 1,
	icon = 6
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
