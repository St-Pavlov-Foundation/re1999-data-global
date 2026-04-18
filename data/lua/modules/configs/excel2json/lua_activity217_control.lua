-- chunkname: @modules/configs/excel2json/lua_activity217_control.lua

module("modules.configs.excel2json.lua_activity217_control", package.seeall)

local lua_activity217_control = {}
local fields = {
	limit = 4,
	dailyLimit = 5,
	type = 2,
	activityId = 1,
	magnification = 3
}
local primaryKey = {
	"activityId",
	"type"
}
local mlStringKey = {}

function lua_activity217_control.onLoad(json)
	lua_activity217_control.configList, lua_activity217_control.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity217_control
