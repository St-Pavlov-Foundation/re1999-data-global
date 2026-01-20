-- chunkname: @modules/configs/excel2json/lua_activity123_stage.lua

module("modules.configs.excel2json.lua_activity123_stage", package.seeall)

local lua_activity123_stage = {}
local fields = {
	recommendSchool = 12,
	name = 4,
	preCondition = 3,
	finalScale = 9,
	initPos = 6,
	initScale = 7,
	stageCondition = 11,
	res = 5,
	finalPos = 8,
	stage = 2,
	activityId = 1,
	recommend = 10
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	name = 1
}

function lua_activity123_stage.onLoad(json)
	lua_activity123_stage.configList, lua_activity123_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_stage
