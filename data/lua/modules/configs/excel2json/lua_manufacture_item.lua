module("modules.configs.excel2json.lua_manufacture_item", package.seeall)

slot1 = {
	itemId = 3,
	needMat = 2,
	criProductionCount = 5,
	batchName = 6,
	showInAdvancedOrder = 10,
	orderPrice = 11,
	unitCount = 9,
	batchIcon = 7,
	needTime = 8,
	id = 1,
	criProductionId = 4,
	wholesalePrice = 12
}
slot2 = {
	"id"
}
slot3 = {
	batchName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
