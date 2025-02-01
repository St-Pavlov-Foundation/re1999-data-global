module("modules.configs.excel2json.lua_equip_strengthen_cost", package.seeall)

slot1 = {
	scoreCost = 4,
	attributeRate = 5,
	exp = 3,
	rare = 1,
	level = 2
}
slot2 = {
	"rare",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
