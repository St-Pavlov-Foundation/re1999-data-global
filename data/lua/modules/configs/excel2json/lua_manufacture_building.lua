module("modules.configs.excel2json.lua_manufacture_building", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
