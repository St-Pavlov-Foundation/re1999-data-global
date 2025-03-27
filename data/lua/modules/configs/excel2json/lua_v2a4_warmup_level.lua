module("modules.configs.excel2json.lua_v2a4_warmup_level", package.seeall)

slot1 = {
	askCount = 2,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
