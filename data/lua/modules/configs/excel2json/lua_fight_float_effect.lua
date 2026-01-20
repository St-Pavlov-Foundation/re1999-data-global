-- chunkname: @modules/configs/excel2json/lua_fight_float_effect.lua

module("modules.configs.excel2json.lua_fight_float_effect", package.seeall)

local lua_fight_float_effect = {}
local fields = {
	prefabPath = 2,
	priority = 5,
	endTime = 4,
	id = 1,
	startTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_float_effect.onLoad(json)
	lua_fight_float_effect.configList, lua_fight_float_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_float_effect
