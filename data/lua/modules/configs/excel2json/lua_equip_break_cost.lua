module("modules.configs.excel2json.lua_equip_break_cost", package.seeall)

slot1 = {
	cost = 4,
	scoreCost = 5,
	breakLevel = 2,
	rare = 1,
	level = 3
}
slot2 = {
	"rare",
	"breakLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
