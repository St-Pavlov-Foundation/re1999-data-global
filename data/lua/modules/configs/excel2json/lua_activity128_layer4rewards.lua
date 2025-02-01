module("modules.configs.excel2json.lua_activity128_layer4rewards", package.seeall)

slot1 = {
	reward = 5,
	display = 6,
	rewardPointNum = 4,
	id = 2,
	stage = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
