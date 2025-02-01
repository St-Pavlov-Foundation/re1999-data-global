module("modules.configs.excel2json.lua_activity154", package.seeall)

slot1 = {
	puzzleTitle = 4,
	puzzleDesc = 5,
	puzzleId = 3,
	puzzleIcon = 6,
	answerId = 7,
	bonus = 8,
	activityId = 1,
	day = 2
}
slot2 = {
	"activityId",
	"day"
}
slot3 = {
	puzzleTitle = 1,
	puzzleDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
