-- chunkname: @modules/configs/excel2json/lua_arcade_reward.lua

module("modules.configs.excel2json.lua_arcade_reward", package.seeall)

local lua_arcade_reward = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_reward.onLoad(json)
	lua_arcade_reward.configList, lua_arcade_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_reward
