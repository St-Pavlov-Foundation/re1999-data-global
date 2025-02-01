module("modules.configs.excel2json.lua_character_motion_play_cut", package.seeall)

slot1 = {
	whenNotStopped = 4,
	heroId = 1,
	motion = 2,
	whenStopped = 3
}
slot2 = {
	"heroId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
