module("modules.configs.excel2json.lua_manufacture_building_trade_level", package.seeall)

slot1 = {
	maxCritterCount = 3,
	tradeGroupId = 1,
	tradeLevel = 2
}
slot2 = {
	"tradeGroupId",
	"tradeLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
