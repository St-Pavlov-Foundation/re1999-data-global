module("modules.configs.excel2json.lua_fight_sp_effect_ly", package.seeall)

slot1 = {
	spine1EffectRes = 5,
	spine2Res = 6,
	fadeAudioId = 9,
	spine1Res = 4,
	pos = 3,
	path = 2,
	audioId = 8,
	spine2EffectRes = 7,
	id = 1
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
