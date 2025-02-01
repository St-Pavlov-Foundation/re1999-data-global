module("modules.configs.excel2json.lua_character_motion_special", package.seeall)

slot1 = {
	heroResName = 1,
	skipStopMouth = 2
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
