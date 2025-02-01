module("modules.configs.excel2json.lua_rouge_genius_overview", package.seeall)

slot1 = {
	name = 2,
	ismul = 4,
	id = 1,
	value = 3,
	icon = 5
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
