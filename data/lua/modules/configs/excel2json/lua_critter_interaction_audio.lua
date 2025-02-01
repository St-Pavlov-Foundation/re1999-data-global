module("modules.configs.excel2json.lua_critter_interaction_audio", package.seeall)

slot1 = {
	animName = 2,
	critterId = 1,
	audioId = 3
}
slot2 = {
	"critterId",
	"animName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
