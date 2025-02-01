module("modules.configs.excel2json.lua_fight_camera_player_turn_offset", package.seeall)

slot1 = {
	id = 1,
	offset = 2
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
