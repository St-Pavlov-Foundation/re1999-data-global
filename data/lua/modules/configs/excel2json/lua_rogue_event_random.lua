module("modules.configs.excel2json.lua_rogue_event_random", package.seeall)

slot1 = {
	event = 2,
	id = 1,
	weights = 3
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
