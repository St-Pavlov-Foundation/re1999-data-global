module("modules.configs.excel2json.lua_character", package.seeall)

slot1 = {
	resistance = 19,
	name = 2,
	signature = 23,
	skinId = 4,
	career = 5,
	uniqueSkill_point = 11,
	nameEng = 22,
	characterTag = 21,
	duplicateItem = 15,
	desc2 = 33,
	skill = 17,
	battleTag = 9,
	ai = 13,
	trust = 29,
	powerMax = 12,
	mvskinId = 34,
	roleBirthday = 28,
	useDesc = 32,
	heroType = 26,
	rare = 6,
	actor = 27,
	duplicateItem2 = 16,
	initials = 3,
	id = 1,
	gender = 8,
	desc = 31,
	dmgType = 7,
	birthdayBonus = 30,
	exSkill = 18,
	isOnline = 25,
	firstItem = 14,
	photoFrameBg = 24,
	school = 20,
	rank = 10
}
slot2 = {
	"id"
}
slot3 = {
	desc2 = 5,
	name = 1,
	useDesc = 4,
	characterTag = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
