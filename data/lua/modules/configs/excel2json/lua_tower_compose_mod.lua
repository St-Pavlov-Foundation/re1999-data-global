-- chunkname: @modules/configs/excel2json/lua_tower_compose_mod.lua

module("modules.configs.excel2json.lua_tower_compose_mod", package.seeall)

local lua_tower_compose_mod = {}
local fields = {
	monsterChange = 10,
	name = 6,
	slotPart = 9,
	skillChange = 11,
	isUnlock = 7,
	careerChange = 15,
	type = 4,
	desc = 8,
	themeId = 2,
	icon = 16,
	level = 3,
	ruleAdd = 13,
	image = 17,
	ruleChange = 14,
	slot = 5,
	passiveSkillAdd = 12,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_tower_compose_mod.onLoad(json)
	lua_tower_compose_mod.configList, lua_tower_compose_mod.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_mod
