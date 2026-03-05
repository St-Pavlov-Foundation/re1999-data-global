-- chunkname: @modules/configs/excel2json/lua_rouge2_system.lua

module("modules.configs.excel2json.lua_rouge2_system", package.seeall)

local lua_rouge2_system = {}
local fields = {
	id = 1,
	visible = 5,
	color = 4,
	icon = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	color = 2,
	desc = 1
}

function lua_rouge2_system.onLoad(json)
	lua_rouge2_system.configList, lua_rouge2_system.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_system
