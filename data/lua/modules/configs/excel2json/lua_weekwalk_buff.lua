module("modules.configs.excel2json.lua_weekwalk_buff", package.seeall)

slot1 = {
	param = 4,
	name = 7,
	rare = 9,
	type = 3,
	preBuff = 5,
	desc = 8,
	replaceBuff = 6,
	id = 1,
	icon = 2
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
