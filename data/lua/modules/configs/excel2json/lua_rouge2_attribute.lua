-- chunkname: @modules/configs/excel2json/lua_rouge2_attribute.lua

module("modules.configs.excel2json.lua_rouge2_attribute", package.seeall)

local lua_rouge2_attribute = {}
local fields = {
	showMax = 8,
	careerDesc = 3,
	min = 7,
	type = 5,
	id = 1,
	icon = 4,
	name = 2,
	level = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerDesc = 2,
	name = 1
}

function lua_rouge2_attribute.onLoad(json)
	lua_rouge2_attribute.configList, lua_rouge2_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_attribute
