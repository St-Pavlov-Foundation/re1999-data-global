-- chunkname: @modules/configs/excel2json/lua_activity1001.lua

module("modules.configs.excel2json.lua_activity1001", package.seeall)

local lua_activity1001 = {}
local fields = {
	desc = 4,
	sort = 5,
	id = 2,
	activityId = 1,
	mailId = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity1001.onLoad(json)
	lua_activity1001.configList, lua_activity1001.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity1001
