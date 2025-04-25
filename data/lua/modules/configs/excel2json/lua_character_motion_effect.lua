module("modules.configs.excel2json.lua_character_motion_effect", package.seeall)

slot1 = {
	node = 4,
	everNode = 5,
	motion = 3,
	heroResName = 1,
	effectCompName = 2
}
slot2 = {
	"heroResName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
