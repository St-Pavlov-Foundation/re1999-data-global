module("modules.configs.excel2json.lua_card_heat", package.seeall)

slot1 = {
	id = 1,
	desc = 3,
	descParam = 4,
	type = 2
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
