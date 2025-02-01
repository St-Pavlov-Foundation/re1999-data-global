module("modules.configs.excel2json.lua_rogue_event_life", package.seeall)

slot1 = {
	id = 1,
	num = 2,
	lifeAdd = 3
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
