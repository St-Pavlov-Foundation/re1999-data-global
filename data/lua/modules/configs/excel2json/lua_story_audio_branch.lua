-- chunkname: @modules/configs/excel2json/lua_story_audio_branch.lua

module("modules.configs.excel2json.lua_story_audio_branch", package.seeall)

local lua_story_audio_branch = {}
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

function lua_story_audio_branch.onLoad(json)
	lua_story_audio_branch.configList, lua_story_audio_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_branch
