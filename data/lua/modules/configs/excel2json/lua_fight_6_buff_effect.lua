module("modules.configs.excel2json.lua_fight_6_buff_effect", package.seeall)

slot1 = {
	audioId = 5,
	effectHang = 4,
	buffId = 2,
	effect = 3,
	id = 1
}
slot2 = {
	"id",
	"buffId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
