-- chunkname: @modules/configs/excel2json/lua_copost_time_point_event.lua

module("modules.configs.excel2json.lua_copost_time_point_event", package.seeall)

local lua_copost_time_point_event = {}
local fields = {
	allTextId = 6,
	fightId = 2,
	chaEventId = 4,
	id = 1,
	eventId = 3,
	coordinatesId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_time_point_event.onLoad(json)
	lua_copost_time_point_event.configList, lua_copost_time_point_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_time_point_event
