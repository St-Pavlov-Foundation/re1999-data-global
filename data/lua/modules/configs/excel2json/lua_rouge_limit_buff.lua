module("modules.configs.excel2json.lua_rouge_limit_buff", package.seeall)

slot1 = {
	needEmblem = 8,
	buffType = 5,
	cd = 9,
	startView = 6,
	blank = 10,
	title = 3,
	icon = 11,
	desc = 4,
	initCollections = 7,
	id = 1,
	version = 2
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
