module("modules.configs.excel2json.lua_rogue_layer", package.seeall)

slot1 = {
	attr = 3,
	difficulty = 1,
	layer = 2
}
slot2 = {
	"difficulty",
	"layer"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
