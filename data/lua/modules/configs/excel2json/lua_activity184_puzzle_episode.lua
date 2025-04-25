module("modules.configs.excel2json.lua_activity184_puzzle_episode", package.seeall)

slot1 = {
	titile = 10,
	titleTxt = 7,
	date = 6,
	txt = 9,
	target = 5,
	illustrationCount = 8,
	staticShape = 4,
	id = 2,
	size = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	txt = 2,
	titleTxt = 1,
	titile = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
