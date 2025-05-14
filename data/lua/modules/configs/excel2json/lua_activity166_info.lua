module("modules.configs.excel2json.lua_activity166_info", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	initContent = 10,
	name = 6,
	reportRes = 8,
	unlockParam = 4,
	infoId = 2,
	reportPic = 9,
	unlockType = 3,
	unlockDes = 5,
	activityId = 1,
	nameEn = 7
}
local var_0_2 = {
	"activityId",
	"infoId"
}
local var_0_3 = {
	initContent = 3,
	name = 2,
	unlockDes = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
