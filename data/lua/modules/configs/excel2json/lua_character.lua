module("modules.configs.excel2json.lua_character", package.seeall)

slot1 = {
	actor = 28,
	name = 2,
	signature = 24,
	skinId = 4,
	career = 5,
	uniqueSkill_point = 12,
	nameEng = 23,
	characterTag = 22,
	heroType = 27,
	desc2 = 34,
	skill = 18,
	battleTag = 9,
	ai = 14,
	trust = 30,
	powerMax = 13,
	mvskinId = 35,
	roleBirthday = 29,
	useDesc = 33,
	duplicateItem = 16,
	rare = 6,
	resistance = 20,
	duplicateItem2 = 17,
	initials = 3,
	id = 1,
	gender = 8,
	desc = 32,
	equipRec = 10,
	dmgType = 7,
	birthdayBonus = 31,
	exSkill = 19,
	isOnline = 26,
	firstItem = 15,
	photoFrameBg = 25,
	school = 21,
	rank = 11
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
