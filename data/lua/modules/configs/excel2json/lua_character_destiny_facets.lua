-- chunkname: @modules/configs/excel2json/lua_character_destiny_facets.lua

module("modules.configs.excel2json.lua_character_destiny_facets", package.seeall)

local lua_character_destiny_facets = {}
local fields = {
	ex_level_exchange = 6,
	desc = 5,
	powerAdd = 3,
	facetsId = 1,
	level = 2,
	exchangeSkills = 4
}
local primaryKey = {
	"facetsId",
	"level"
}
local mlStringKey = {
	desc = 1
}

function lua_character_destiny_facets.onLoad(json)
	lua_character_destiny_facets.configList, lua_character_destiny_facets.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_destiny_facets
