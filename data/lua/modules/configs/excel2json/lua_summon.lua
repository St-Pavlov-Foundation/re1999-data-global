module("modules.configs.excel2json.lua_summon", package.seeall)

slot1 = {
	id = 1,
	summonId = 3,
	rare = 2,
	luckyBagId = 4
}
slot2 = {
	"id",
	"rare"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
