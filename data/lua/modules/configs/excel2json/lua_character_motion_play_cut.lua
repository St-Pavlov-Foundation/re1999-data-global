module("modules.configs.excel2json.lua_character_motion_play_cut", package.seeall)

slot1 = {
	whenStopped = 4,
	heroId = 1,
	skinId = 2,
	whenNotStopped = 5,
	motion = 3
}
slot2 = {
	"heroId",
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
