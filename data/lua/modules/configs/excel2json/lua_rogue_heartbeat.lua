module("modules.configs.excel2json.lua_rogue_heartbeat", package.seeall)

slot1 = {
	desc = 5,
	range = 2,
	id = 1,
	title = 4,
	rule = 6,
	attr = 3
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
