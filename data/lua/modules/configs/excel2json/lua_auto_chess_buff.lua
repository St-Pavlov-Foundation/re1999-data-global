module("modules.configs.excel2json.lua_auto_chess_buff", package.seeall)

slot1 = {
	durationDeduction = 7,
	effect = 4,
	triggerPoint = 3,
	type = 5,
	buffeffectID = 8,
	condition = 2,
	id = 1,
	cover = 6,
	downline = 9
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
