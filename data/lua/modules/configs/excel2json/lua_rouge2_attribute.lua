-- chunkname: @modules/configs/excel2json/lua_rouge2_attribute.lua

module("modules.configs.excel2json.lua_rouge2_attribute", package.seeall)

local lua_rouge2_attribute = {}
local fields = {
	careerDesc = 3,
	spriteIndex = 5,
	name = 2,
	type = 6,
	showMax = 9,
	min = 8,
	id = 1,
	icon = 4,
	level = 7
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
