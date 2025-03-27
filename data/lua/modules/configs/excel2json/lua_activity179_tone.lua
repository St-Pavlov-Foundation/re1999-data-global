module("modules.configs.excel2json.lua_activity179_tone", package.seeall)

slot1 = {
	id = 1,
	name = 3,
	instrument = 2,
	resource = 4
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
