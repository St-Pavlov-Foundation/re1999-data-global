module("modules.configs.excel2json.lua_activity175", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	res_gif1 = 3,
	res_pic = 2,
	activityId = 1,
	res_gif2 = 4
}
local var_0_2 = {
	"activityId",
	"res_pic"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
