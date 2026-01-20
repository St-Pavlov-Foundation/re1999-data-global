-- chunkname: @modules/configs/excel2json/lua_survival_decree.lua

module("modules.configs.excel2json.lua_survival_decree", package.seeall)

local lua_survival_decree = {}
local fields = {
	versions = 4,
	name = 6,
	tags = 11,
	type = 2,
	group = 3,
	stageVotes = 8,
	condition = 9,
	desc = 7,
	limit = 12,
	getTalents = 13,
	seasons = 5,
	id = 1,
	icon = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_decree.onLoad(json)
	lua_survival_decree.configList, lua_survival_decree.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_decree
