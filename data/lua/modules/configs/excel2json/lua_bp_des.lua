-- chunkname: @modules/configs/excel2json/lua_bp_des.lua

module("modules.configs.excel2json.lua_bp_des", package.seeall)

local lua_bp_des = {}
local fields = {
	iconType = 4,
	bpId = 2,
	type = 3,
	id = 1,
	icon = 6,
	items = 5,
	des = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 1
}

function lua_bp_des.onLoad(json)
	lua_bp_des.configList, lua_bp_des.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_des
