module("modules.configs.excel2json.lua_critter_rare", package.seeall)

slot1 = {
	cardRes = 2,
	incubateCost = 4,
	rare = 1,
	eggRes = 3
}
slot2 = {
	"rare"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
