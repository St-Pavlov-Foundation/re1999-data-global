-- chunkname: @modules/configs/excel2json/lua_activity1001_ext.lua

module("modules.configs.excel2json.lua_activity1001_ext", package.seeall)

local lua_activity1001_ext = {}
local fields = {
	sort = 5,
	rewards = 4,
	id = 2,
	title = 6,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	title = 2,
	desc = 1
}

function lua_activity1001_ext.onLoad(json)
	lua_activity1001_ext.configList, lua_activity1001_ext.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity1001_ext
