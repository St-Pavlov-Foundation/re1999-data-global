-- chunkname: @modules/configs/excel2json/lua_character_special_interaction_voice.lua

module("modules.configs.excel2json.lua_character_special_interaction_voice", package.seeall)

local lua_character_special_interaction_voice = {}
local fields = {
	timeoutVoice = 4,
	protectionTime = 5,
	time = 2,
	id = 1,
	statusParams = 6,
	waitVoice = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_special_interaction_voice.onLoad(json)
	lua_character_special_interaction_voice.configList, lua_character_special_interaction_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_special_interaction_voice
