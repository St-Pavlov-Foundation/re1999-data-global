module("modules.configs.excel2json.lua_rouge_style_talent", package.seeall)

slot1 = {
	interactive = 4,
	unlockType = 8,
	desc = 7,
	type = 2,
	id = 1,
	version = 3,
	ban = 6,
	attribute = 5
}
slot2 = {
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
