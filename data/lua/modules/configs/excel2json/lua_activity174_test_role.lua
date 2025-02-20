module("modules.configs.excel2json.lua_activity174_test_role", package.seeall)

slot1 = {
	heroId = 7,
	name = 8,
	costCoin = 19,
	type = 2,
	uniqueSkill = 16,
	gender = 9,
	career = 10,
	activeSkill2 = 15,
	quality = 5,
	activeSkill1 = 14,
	dmgType = 11,
	uniqueSkill_point = 17,
	skinId = 4,
	powerMax = 18,
	passiveSkill = 12,
	rare = 6,
	template = 3,
	id = 1,
	replacePassiveSkill = 13
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
