module("modules.configs.excel2json.lua_rouge_displace", package.seeall)

slot1 = {
	season = 1,
	quality = 3,
	id = 2,
	upDropGroup = 5,
	dropGroup = 4
}
slot2 = {
	"season",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
