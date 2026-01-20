-- chunkname: @modules/configs/excel2json/lua_activity125.lua

module("modules.configs.excel2json.lua_activity125", package.seeall)

local lua_activity125 = {}
local fields = {
	targetFrequency = 7,
	name = 8,
	preId = 3,
	musictime = 12,
	clientbonus = 11,
	openDay = 4,
	time = 13,
	sourceid = 15,
	text = 9,
	key = 14,
	initFrequency = 6,
	id = 2,
	frequency = 5,
	activityId = 1,
	bonus = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}

function lua_activity125.onLoad(json)
	lua_activity125.configList, lua_activity125.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity125
