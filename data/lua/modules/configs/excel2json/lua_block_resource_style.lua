module("modules.configs.excel2json.lua_block_resource_style", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	c3tc = 11,
	name = 3,
	c4tb = 14,
	c5ta = 16,
	c4ta = 13,
	c2ta = 6,
	c3ta = 9,
	path = 4,
	c6ta = 17,
	c3tb = 10,
	c2tb = 7,
	resourceId = 2,
	c3td = 12,
	c1ta = 5,
	id = 1,
	c4tc = 15,
	c2tc = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
