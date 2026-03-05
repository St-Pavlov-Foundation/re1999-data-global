-- chunkname: @modules/configs/excel2json/lua_arcade_floor.lua

module("modules.configs.excel2json.lua_arcade_floor", package.seeall)

local lua_arcade_floor = {}
local fields = {
	limitRound = 8,
	name = 2,
	skill = 4,
	category = 6,
	id = 1,
	icon = 7,
	resPath = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_arcade_floor.onLoad(json)
	lua_arcade_floor.configList, lua_arcade_floor.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_floor
