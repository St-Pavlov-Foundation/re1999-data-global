module("modules.configs.excel2json.lua_currency", package.seeall)

slot1 = {
	recoverNum = 10,
	name = 2,
	useDesc = 7,
	maxLimit = 13,
	dayRecoverNum = 12,
	sources = 14,
	rare = 3,
	desc = 8,
	recoverTime = 9,
	smallIcon = 6,
	recoverLimit = 11,
	id = 1,
	icon = 5,
	highQuality = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
