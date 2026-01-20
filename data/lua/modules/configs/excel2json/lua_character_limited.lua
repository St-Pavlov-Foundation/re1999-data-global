-- chunkname: @modules/configs/excel2json/lua_character_limited.lua

module("modules.configs.excel2json.lua_character_limited", package.seeall)

local lua_character_limited = {}
local fields = {
	entranceEffect = 8,
	spineParam = 3,
	mvtime = 5,
	spine = 2,
	actionTime = 7,
	entranceMv = 4,
	specialInsightDesc = 12,
	voice = 6,
	audio = 10,
	stopAudio = 11,
	effectDuration = 9,
	specialLive2d = 13,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	specialInsightDesc = 1
}

function lua_character_limited.onLoad(json)
	lua_character_limited.configList, lua_character_limited.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_limited
