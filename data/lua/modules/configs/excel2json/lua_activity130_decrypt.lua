module("modules.configs.excel2json.lua_activity130_decrypt", package.seeall)

slot1 = {
	puzzleType = 6,
	operGroupId = 4,
	puzzleMapId = 3,
	maxStep = 9,
	extStarDesc = 13,
	errorTip = 10,
	maxOper = 8,
	extStarCondition = 12,
	puzzleTip = 11,
	answer = 7,
	puzzleTxt = 5,
	activityId = 1,
	puzzleId = 2
}
slot2 = {
	"activityId",
	"puzzleId"
}
slot3 = {
	extStarDesc = 2,
	puzzleTxt = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
