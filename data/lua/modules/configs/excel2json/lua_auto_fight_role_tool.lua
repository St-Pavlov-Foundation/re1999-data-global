-- chunkname: @modules/configs/excel2json/lua_auto_fight_role_tool.lua

module("modules.configs.excel2json.lua_auto_fight_role_tool", package.seeall)

local lua_auto_fight_role_tool = {}
local fields = {
	roleId = 1,
	exLv = 3,
	equipLv = 5,
	talentLv = 7,
	destiny = 9,
	talentStyle = 8,
	equip = 4,
	equipExLv = 6,
	lv = 2
}
local primaryKey = {
	"roleId"
}
local mlStringKey = {}

function lua_auto_fight_role_tool.onLoad(json)
	lua_auto_fight_role_tool.configList, lua_auto_fight_role_tool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_fight_role_tool
