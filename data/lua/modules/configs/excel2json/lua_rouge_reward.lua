module("modules.configs.excel2json.lua_rouge_reward", package.seeall)

slot1 = {
	stage = 4,
	value = 6,
	preId = 3,
	type = 7,
	season = 1,
	offset = 11,
	pos = 5,
	rewardName = 9,
	rewardType = 10,
	id = 2,
	icon = 8
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	rewardName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
