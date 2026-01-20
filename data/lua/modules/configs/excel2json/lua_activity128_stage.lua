-- chunkname: @modules/configs/excel2json/lua_activity128_stage.lua

module("modules.configs.excel2json.lua_activity128_stage", package.seeall)

local lua_activity128_stage = {}
local fields = {
	skinIds = 15,
	name = 4,
	bossRushLevelDetailFullBgSimage = 12,
	type = 6,
	maxPoints = 7,
	name_en = 5,
	bossRushMainBg = 11,
	bossRushMainItemBossSprite = 10,
	skinOffsetXYs = 17,
	resultViewNameSImage = 14,
	layer4MaxPoints = 8,
	stage = 2,
	activityId = 1,
	openDay = 9,
	skinScales = 16,
	resultViewFullBgSImage = 13,
	version = 3
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	name = 1
}

function lua_activity128_stage.onLoad(json)
	lua_activity128_stage.configList, lua_activity128_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_stage
