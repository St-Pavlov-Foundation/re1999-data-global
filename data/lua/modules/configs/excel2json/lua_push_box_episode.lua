module("modules.configs.excel2json.lua_push_box_episode", package.seeall)

slot1 = {
	fan_duration = 8,
	name = 2,
	enemy_alarm = 7,
	layout = 3,
	light_alarm = 9,
	enemy_act = 6,
	id = 1,
	wall = 4,
	step = 5
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
