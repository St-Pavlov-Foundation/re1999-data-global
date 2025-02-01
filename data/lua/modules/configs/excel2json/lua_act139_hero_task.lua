module("modules.configs.excel2json.lua_act139_hero_task", package.seeall)

slot1 = {
	reward = 8,
	heroId = 3,
	preEpisodeId = 9,
	title = 4,
	toastId = 10,
	desc = 7,
	heroIcon = 6,
	heroTabIcon = 5,
	id = 1,
	activityId = 2
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
