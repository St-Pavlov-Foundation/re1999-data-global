module("modules.configs.excel2json.lua_activity122_character", package.seeall)

slot1 = {
	activityId = 1,
	pushOverObstacle = 7,
	fireDecrHp = 6,
	trapDecrHp = 5,
	destroyObstacle = 4,
	moveObstacle = 3,
	characterType = 2
}
slot2 = {
	"activityId",
	"characterType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
