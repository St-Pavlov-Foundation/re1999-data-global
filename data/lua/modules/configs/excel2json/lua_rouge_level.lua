module("modules.configs.excel2json.lua_rouge_level", package.seeall)

slot1 = {
	season = 1,
	exp = 3,
	level = 2
}
slot2 = {
	"season",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
