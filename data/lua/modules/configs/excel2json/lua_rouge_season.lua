module("modules.configs.excel2json.lua_rouge_season", package.seeall)

slot1 = {
	season = 2,
	name = 4,
	desc = 6,
	id = 1,
	version = 3,
	enName = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 3,
	name = 1,
	enName = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
