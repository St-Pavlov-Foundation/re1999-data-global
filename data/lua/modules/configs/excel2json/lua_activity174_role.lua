module("modules.configs.excel2json.lua_activity174_role", package.seeall)

slot1 = {
	heroId = 8,
	name = 9,
	quality = 6,
	skinId = 5,
	season = 2,
	gender = 10,
	career = 11,
	activeSkill2 = 16,
	type = 3,
	activeSkill1 = 15,
	dmgType = 12,
	uniqueSkill = 17,
	coinValue = 20,
	uniqueSkill_point = 18,
	powerMax = 19,
	passiveSkill = 13,
	rare = 7,
	template = 4,
	id = 1,
	replacePassiveSkill = 14
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
