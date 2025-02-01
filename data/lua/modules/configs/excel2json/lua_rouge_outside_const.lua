module("modules.configs.excel2json.lua_rouge_outside_const", package.seeall)

slot1 = {
	id = 2,
	season = 1,
	value = 3,
	desc = 4
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
