module("modules.configs.excel2json.lua_player_level", package.seeall)

slot1 = {
	addUpRecoverPower = 4,
	addBuyRecoverPower = 5,
	bonus = 6,
	exp = 2,
	maxAutoRecoverPower = 3,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
