-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_map.lua

module("modules.configs.excel2json.lua_v3a2_chapter_map", package.seeall)

local lua_v3a2_chapter_map = {}
local fields = {
	titleRotation = 4,
	titlePos = 5,
	descOffset = 8,
	descPos = 7,
	id = 1,
	position = 3,
	descRotation = 6,
	locationDesc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	locationDesc = 1
}

function lua_v3a2_chapter_map.onLoad(json)
	lua_v3a2_chapter_map.configList, lua_v3a2_chapter_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a2_chapter_map
