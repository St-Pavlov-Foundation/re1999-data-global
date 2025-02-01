module("modules.configs.excel2json.lua_season_buff", package.seeall)

slot1 = {
	param = 4,
	name = 5,
	buffId = 1,
	type = 3,
	group = 8,
	desc = 7,
	rare = 9,
	poolId = 2,
	score = 10,
	unlock = 11,
	icon = 6
}
slot2 = {
	"buffId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
