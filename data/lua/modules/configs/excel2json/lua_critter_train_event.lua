module("modules.configs.excel2json.lua_critter_train_event", package.seeall)

slot1 = {
	roomDialogId = 12,
	name = 3,
	skilledStoryId = 11,
	type = 2,
	normalStoryId = 10,
	autoFinish = 14,
	content = 17,
	desc = 8,
	preferenceAttribute = 6,
	computeIncrRate = 13,
	maxCount = 15,
	effectAttribute = 9,
	cost = 16,
	addAttribute = 5,
	condition = 4,
	initStoryId = 7,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	content = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
