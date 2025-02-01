module("modules.configs.excel2json.lua_fight_buff_layer_effect_nana", package.seeall)

slot1 = {
	effectRoot = 4,
	effect = 3,
	effectAudio = 5,
	id = 1,
	duration = 6,
	layer = 2
}
slot2 = {
	"id",
	"layer"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
