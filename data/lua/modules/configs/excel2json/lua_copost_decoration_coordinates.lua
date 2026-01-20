-- chunkname: @modules/configs/excel2json/lua_copost_decoration_coordinates.lua

module("modules.configs.excel2json.lua_copost_decoration_coordinates", package.seeall)

local lua_copost_decoration_coordinates = {}
local fields = {
	id = 1,
	decorationId = 3,
	coordinates = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_decoration_coordinates.onLoad(json)
	lua_copost_decoration_coordinates.configList, lua_copost_decoration_coordinates.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_decoration_coordinates
