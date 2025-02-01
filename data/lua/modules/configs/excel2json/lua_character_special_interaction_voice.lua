module("modules.configs.excel2json.lua_character_special_interaction_voice", package.seeall)

slot1 = {
	id = 1,
	timeoutVoice = 4,
	time = 2,
	waitVoice = 3
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
