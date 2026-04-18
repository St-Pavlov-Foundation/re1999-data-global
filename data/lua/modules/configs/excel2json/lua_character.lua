-- chunkname: @modules/configs/excel2json/lua_character.lua

module("modules.configs.excel2json.lua_character", package.seeall)

local lua_character = {}
local fields = {
	resistance = 21,
	name = 2,
	characterTag = 23,
	skinId = 4,
	duplicateItemSpecial = 17,
	uniqueSkill_point = 12,
	nameEng = 24,
	career = 5,
	signature = 25,
	desc2 = 35,
	skill = 19,
	battleTag = 9,
	ai = 14,
	trust = 31,
	powerMax = 13,
	duplicateItem = 16,
	roleBirthday = 30,
	mvskinId = 36,
	useDesc = 34,
	heroType = 28,
	stat = 37,
	rare = 6,
	actor = 29,
	duplicateItem2 = 18,
	initials = 3,
	id = 1,
	gender = 8,
	desc = 33,
	equipRec = 10,
	dmgType = 7,
	birthdayBonus = 32,
	exSkill = 20,
	isOnline = 27,
	firstItem = 15,
	photoFrameBg = 26,
	school = 22,
	rank = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 5,
	name = 1,
	useDesc = 4,
	characterTag = 2,
	desc = 3
}

function lua_character.onLoad(json)
	lua_character.configList, lua_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character
