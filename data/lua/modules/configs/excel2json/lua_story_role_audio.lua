-- chunkname: @modules/configs/excel2json/lua_story_role_audio.lua

module("modules.configs.excel2json.lua_story_role_audio", package.seeall)

local lua_story_role_audio = {}
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

function lua_story_role_audio.onLoad(json)
	lua_story_role_audio.configList, lua_story_role_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_role_audio
