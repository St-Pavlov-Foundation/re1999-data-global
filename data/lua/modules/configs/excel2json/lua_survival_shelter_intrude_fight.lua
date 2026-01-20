-- chunkname: @modules/configs/excel2json/lua_survival_shelter_intrude_fight.lua

module("modules.configs.excel2json.lua_survival_shelter_intrude_fight", package.seeall)

local lua_survival_shelter_intrude_fight = {}
local fields = {
	score = 4,
	gridType = 8,
	battleId = 3,
	smallheadicon = 9,
	name = 10,
	image = 5,
	target = 2,
	desc = 11,
	saveMonster = 13,
	toward = 12,
	model = 6,
	cleanpoint = 14,
	id = 1,
	destructionLevel = 15,
	scale = 7,
	drop = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	target = 1,
	desc = 3
}

function lua_survival_shelter_intrude_fight.onLoad(json)
	lua_survival_shelter_intrude_fight.configList, lua_survival_shelter_intrude_fight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_shelter_intrude_fight
