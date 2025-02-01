module("modules.configs.excel2json.lua_bp_lv_bonus", package.seeall)

slot1 = {
	selfSelectPayItem = 9,
	spFreeBonus = 6,
	selfSelectPayBonus = 8,
	payBonus = 4,
	keyBonus = 5,
	bpId = 1,
	spPayBonus = 7,
	freeBonus = 3,
	level = 2
}
slot2 = {
	"bpId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
