module("modules.configs.excel2json.lua_rouge_piece", package.seeall)

slot1 = {
	version = 2,
	title = 5,
	talkId = 7,
	pieceRes = 4,
	id = 1,
	entrustType = 3,
	bossEffect = 8,
	desc = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
