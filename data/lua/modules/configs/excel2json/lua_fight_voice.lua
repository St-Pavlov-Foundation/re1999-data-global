module("modules.configs.excel2json.lua_fight_voice", package.seeall)

slot1 = {
	audio_type3 = 4,
	audio_type9 = 10,
	audio_type4 = 5,
	skinId = 1,
	audio_type1 = 2,
	audio_type10 = 11,
	audio_type2 = 3,
	audio_type7 = 8,
	audio_type8 = 9,
	audio_type5 = 6,
	audio_type6 = 7
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
