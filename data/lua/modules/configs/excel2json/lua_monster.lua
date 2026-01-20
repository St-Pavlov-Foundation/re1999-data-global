-- chunkname: @modules/configs/excel2json/lua_monster.lua

module("modules.configs.excel2json.lua_monster", package.seeall)

local lua_monster = {}
local fields = {
	heartVariantId = 7,
	highPriorityName = 19,
	levelEasy = 23,
	uniqueSkillLevel = 11,
	skillTemplate = 3,
	initial_uniqueSkill_point = 10,
	career = 6,
	level_true = 9,
	label = 5,
	highPriorityNameEng = 20,
	hpSign = 15,
	highPriorityDes = 21,
	effectHangPoint = 18,
	templateEasy = 22,
	skinId = 4,
	level = 8,
	effect = 17,
	passiveSkillsEx = 13,
	energySign = 16,
	uiFilterSkill = 14,
	passiveSkillCount = 12,
	template = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	highPriorityDes = 2,
	highPriorityName = 1
}

function lua_monster.onLoad(json)
	lua_monster.configList, lua_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster
