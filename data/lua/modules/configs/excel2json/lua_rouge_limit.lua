module("modules.configs.excel2json.lua_rouge_limit", package.seeall)

slot1 = {
	group = 3,
	startView = 8,
	riskValue = 7,
	title = 5,
	desc = 6,
	initCollections = 9,
	id = 1,
	version = 2,
	level = 4
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
