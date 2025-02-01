module("modules.configs.excel2json.lua_activity139_hero_task", package.seeall)

slot1 = {
	ringIds = 4,
	heroId = 3,
	id = 1,
	finalReward = 5,
	activityId = 2
}
slot2 = {
	"id"
}
slot3 = {
	ringIds = 1,
	finalReward = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
