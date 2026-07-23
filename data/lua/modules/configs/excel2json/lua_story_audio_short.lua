-- chunkname: @modules/configs/excel2json/lua_story_audio_short.lua

module("modules.configs.excel2json.lua_story_audio_short", package.seeall)

local lua_story_audio_short = {}
local fields = {
	bankName = 3,
	eventName_Overseas = 4,
	bankName_Overseas = 5,
	eventName = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_short.onLoad(json)
	lua_story_audio_short.configList, lua_story_audio_short.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_short
