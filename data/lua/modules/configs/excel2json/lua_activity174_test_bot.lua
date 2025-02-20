module("modules.configs.excel2json.lua_activity174_test_bot", package.seeall)

slot1 = {
	collection3 = 9,
	collection4 = 10,
	count = 2,
	collection1 = 7,
	costCoin = 12,
	role3 = 5,
	enhance = 11,
	role1 = 3,
	collection2 = 8,
	role4 = 6,
	robotId = 1,
	role2 = 4
}
slot2 = {
	"robotId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
