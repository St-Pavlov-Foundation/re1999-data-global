-- chunkname: @modules/configs/excel2json/lua_rouge2_active_skill.lua

module("modules.configs.excel2json.lua_rouge2_active_skill", package.seeall)

local lua_rouge2_active_skill = {}
local fields = {
	passiveSkillId = 9,
	name = 2,
	isOff = 3,
	outUnlock = 5,
	isHide = 7,
	unlock = 14,
	career = 12,
	desc = 15,
	narrativeDesc = 19,
	descSimply = 16,
	updateAttri = 26,
	skillId = 8,
	tag = 10,
	icon = 13,
	attributeTag = 11,
	useLimit = 21,
	sortId = 4,
	battleTag = 23,
	skillTypeName = 24,
	outUnlockDesc = 6,
	updateSkill = 25,
	cost = 22,
	rare = 18,
	newDesc = 27,
	keyWord = 17,
	countTitle = 28,
	coolDown = 20,
	countParam = 29,
	id = 1,
	hero_trial = 30,
	assembleCost = 31
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	keyWord = 5,
	descSimply = 4,
	name = 1,
	outUnlockDesc = 2,
	narrativeDesc = 6,
	newDesc = 7,
	countTitle = 8,
	desc = 3
}

function lua_rouge2_active_skill.onLoad(json)
	lua_rouge2_active_skill.configList, lua_rouge2_active_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_active_skill
