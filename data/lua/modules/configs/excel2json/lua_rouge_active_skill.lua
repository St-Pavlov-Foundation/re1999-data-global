module("modules.configs.excel2json.lua_rouge_active_skill", package.seeall)

slot1 = {
	roundLimit = 5,
	icon = 8,
	coinCost = 4,
	allLimit = 6,
	id = 1,
	version = 2,
	powerCost = 3,
	desc = 7
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
