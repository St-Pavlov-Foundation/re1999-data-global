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
	narrativeDesc = 18,
	descSimply = 16,
	cost = 21,
	skillId = 8,
	tag = 10,
	icon = 13,
	attributeTag = 11,
	useLimit = 20,
	sortId = 4,
	assembleCost = 22,
	outUnlockDesc = 6,
	keyWord = 17,
	coolDown = 19,
	id = 1
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
	desc = 3
}

function lua_rouge2_active_skill.onLoad(json)
	lua_rouge2_active_skill.configList, lua_rouge2_active_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_active_skill
