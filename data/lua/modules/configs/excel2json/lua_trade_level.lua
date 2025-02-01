module("modules.configs.excel2json.lua_trade_level", package.seeall)

slot1 = {
	maxRestBuildingNum = 2,
	maxTrainSlotCount = 8,
	jobCard = 6,
	job = 5,
	dimension = 4,
	levelUpNeedTask = 7,
	trainsRoundCount = 9,
	unlockId = 10,
	addBlockMax = 3,
	silenceBonus = 11,
	bonus = 12,
	taskName = 13,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {
	dimension = 1,
	taskName = 3,
	job = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
