module("modules.configs.excel2json.lua_open_group", package.seeall)

slot1 = {
	need_finish_guide = 6,
	hero_number = 2,
	need_episode = 4,
	need_enter_episode = 5,
	id = 1,
	showInEpisode = 7,
	need_level = 3,
	lock_desc = 8
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
