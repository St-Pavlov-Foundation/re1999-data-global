-- chunkname: @modules/configs/excel2json/lua_copost_character_camp.lua

module("modules.configs.excel2json.lua_copost_character_camp", package.seeall)

local lua_copost_character_camp = {}
local fields = {
	id = 1,
	camp = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	camp = 1
}

function lua_copost_character_camp.onLoad(json)
	lua_copost_character_camp.configList, lua_copost_character_camp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character_camp
