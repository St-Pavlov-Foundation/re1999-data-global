-- chunkname: @modules/configs/excel2json/lua_monster_skill_template.lua

module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

local lua_monster_skill_template = {}
local fields = {
	gender = 7,
	name = 2,
	career = 8,
	baseStress = 18,
	uniqueSkill = 12,
	uniqueSkill_point = 13,
	nameEng = 3,
	identity = 20,
	race = 21,
	camp = 17,
	dmgType = 9,
	activeSkill = 11,
	powerMax = 15,
	des = 4,
	passiveSkill = 10,
	instance = 6,
	property = 16,
	resistance = 14,
	template = 5,
	id = 1,
	maxStress = 19
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	property = 3,
	name = 1,
	des = 2
}

function lua_monster_skill_template.onLoad(json)
	lua_monster_skill_template.configList, lua_monster_skill_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_skill_template
