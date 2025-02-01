module("modules.configs.excel2json.lua_activity129_pool", package.seeall)

slot1 = {
	cost = 6,
	name = 4,
	nameEn = 5,
	type = 3,
	maxDraw = 7,
	activityId = 1,
	poolId = 2
}
slot2 = {
	"activityId",
	"poolId"
}
slot3 = {
	nameEn = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
