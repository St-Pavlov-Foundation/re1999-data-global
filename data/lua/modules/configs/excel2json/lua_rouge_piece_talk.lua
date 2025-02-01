module("modules.configs.excel2json.lua_rouge_piece_talk", package.seeall)

slot1 = {
	title = 2,
	exitDesc = 5,
	id = 1,
	selectIds = 4,
	content = 3
}
slot2 = {
	"id"
}
slot3 = {
	title = 1,
	content = 2,
	exitDesc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
