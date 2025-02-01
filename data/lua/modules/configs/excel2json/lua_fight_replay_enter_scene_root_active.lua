module("modules.configs.excel2json.lua_fight_replay_enter_scene_root_active", package.seeall)

slot1 = {
	wave = 2,
	id = 1,
	activeRootName = 3,
	switch = 4
}
slot2 = {
	"id",
	"wave"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
