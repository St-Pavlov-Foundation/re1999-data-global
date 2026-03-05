-- chunkname: @modules/configs/excel2json/lua_arcade_buff.lua

module("modules.configs.excel2json.lua_arcade_buff", package.seeall)

local lua_arcade_buff = {}
local fields = {
	showPriority = 7,
	id = 1,
	addPassiveSkillId = 3,
	round = 5,
	loopEffect = 9,
	gainEffect = 8,
	entityType = 4,
	notSubInRoundBegin = 6,
	effectParam = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_buff.onLoad(json)
	lua_arcade_buff.configList, lua_arcade_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_buff
