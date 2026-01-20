-- chunkname: @modules/configs/excel2json/lua_copost_const.lua

module("modules.configs.excel2json.lua_copost_const", package.seeall)

local lua_copost_const = {}
local fields = {
	value = 2,
	value3 = 4,
	value2 = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_const.onLoad(json)
	lua_copost_const.configList, lua_copost_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_const
