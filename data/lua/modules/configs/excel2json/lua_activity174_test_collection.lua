module("modules.configs.excel2json.lua_activity174_test_collection", package.seeall)

slot1 = {
	icon = 5,
	unique = 6,
	costCoin = 7,
	id = 1,
	title = 3,
	rare = 2,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
