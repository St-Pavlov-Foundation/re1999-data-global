module("modules.configs.excel2json.lua_cloth_level", package.seeall)

slot1 = {
	usePower1 = 14,
	passiveSkills = 12,
	usePower3 = 22,
	id = 1,
	death = 10,
	recover = 7,
	compose = 6,
	move = 5,
	skill2 = 17,
	maxPower = 3,
	cd2 = 19,
	desc = 11,
	allLimit3 = 24,
	defeat = 9,
	use = 4,
	level = 2,
	allLimit1 = 16,
	allLimit2 = 20,
	exp = 25,
	skill3 = 21,
	usePower2 = 18,
	skill1 = 13,
	cd3 = 23,
	initial = 8,
	cd1 = 15
}
slot2 = {
	"id",
	"level"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
