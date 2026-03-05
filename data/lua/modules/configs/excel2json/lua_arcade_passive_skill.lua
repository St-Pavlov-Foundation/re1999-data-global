-- chunkname: @modules/configs/excel2json/lua_arcade_passive_skill.lua

module("modules.configs.excel2json.lua_arcade_passive_skill", package.seeall)

local lua_arcade_passive_skill = {}
local fields = {
	effect1 = 5,
	effect5 = 29,
	effectId2 = 13,
	condition5 = 27,
	effect3 = 17,
	triggerPoint2 = 10,
	atkEffectId1 = 6,
	condition3 = 15,
	effectId3 = 19,
	effectId4 = 25,
	atkEffectId3 = 18,
	effectId1 = 7,
	effect2 = 11,
	condition2 = 9,
	skillDesc = 2,
	triggerPoint3 = 16,
	limit3 = 20,
	triggerPoint4 = 22,
	effect4 = 23,
	condition1 = 3,
	atkEffectId2 = 12,
	limit4 = 26,
	triggerPoint1 = 4,
	triggerPoint5 = 28,
	atkEffectId4 = 24,
	condition4 = 21,
	limit2 = 14,
	limit1 = 8,
	id = 1,
	atkEffectId5 = 30,
	effectId5 = 31,
	limit5 = 32
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 1
}

function lua_arcade_passive_skill.onLoad(json)
	lua_arcade_passive_skill.configList, lua_arcade_passive_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_passive_skill
