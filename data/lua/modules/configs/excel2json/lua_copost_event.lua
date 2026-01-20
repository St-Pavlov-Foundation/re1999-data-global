-- chunkname: @modules/configs/excel2json/lua_copost_event.lua

module("modules.configs.excel2json.lua_copost_event", package.seeall)

local lua_copost_event = {}
local fields = {
	needchaText = 9,
	eventTextId = 5,
	chaId = 10,
	allTime = 7,
	reduceTime = 11,
	eventCoordinate = 3,
	eventType = 2,
	charaProfile = 8,
	eventTitleId = 4,
	id = 1,
	chaNum = 6,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	needchaText = 2,
	eventTitleId = 1
}

function lua_copost_event.onLoad(json)
	lua_copost_event.configList, lua_copost_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_event
