module("modules.configs.excel2json.lua_character_motion_cut", package.seeall)

slot1 = {
	onlyStopCut = 3,
	heroId = 1,
	motion = 2
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
