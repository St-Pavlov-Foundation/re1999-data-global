-- chunkname: @modules/configs/excel2json/lua_activity107.lua

module("modules.configs.excel2json.lua_activity107", package.seeall)

local lua_activity107 = {}
local fields = {
	cost = 5,
	name = 8,
	tag = 6,
	maxBuyCount = 4,
	group = 12,
	order = 11,
	isOnline = 9,
	bigImg = 7,
	product = 3,
	id = 2,
	activityId = 1,
	preGoodsId = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity107.onLoad(json)
	lua_activity107.configList, lua_activity107.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity107
