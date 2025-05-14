module("modules.configs.excel2json.lua_manufacture_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tradeGroupId = 6,
	placeTradeLevel = 2,
	id = 1,
	buildIcon = 8,
	taskIcon = 9,
	upgradeGroupId = 5,
	cameraIds = 7,
	placeCost = 4,
	placeNoCost = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
