module("modules.configs.excel2json.lua_balance_umbrella", package.seeall)

slot1 = {
	players = 5,
	name = 3,
	id = 1,
	episode = 2,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	players = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
