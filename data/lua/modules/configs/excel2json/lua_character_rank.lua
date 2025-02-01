module("modules.configs.excel2json.lua_character_rank", package.seeall)

slot1 = {
	requirement = 4,
	heroId = 1,
	rank = 2,
	consume = 3,
	effect = 5
}
slot2 = {
	"heroId",
	"rank"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
