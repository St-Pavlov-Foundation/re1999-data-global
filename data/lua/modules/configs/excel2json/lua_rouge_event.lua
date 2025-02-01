module("modules.configs.excel2json.lua_rouge_event", package.seeall)

slot1 = {
	desc = 7,
	name = 5,
	type = 2,
	id = 1,
	version = 3,
	specialUI = 4,
	nameEn = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
