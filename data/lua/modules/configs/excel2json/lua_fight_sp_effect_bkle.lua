module("modules.configs.excel2json.lua_fight_sp_effect_bkle", package.seeall)

slot1 = {
	audio = 5,
	buffId = 2,
	hangPoint = 4,
	id = 1,
	path = 3
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
