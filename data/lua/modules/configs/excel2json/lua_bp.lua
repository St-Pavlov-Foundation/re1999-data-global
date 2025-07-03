module("modules.configs.excel2json.lua_bp", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isSp = 17,
	name = 7,
	chargeId2 = 3,
	bpSkinEnNametxt = 12,
	bpviewicon = 13,
	payStatus2Bonus = 6,
	chargeId1 = 2,
	bpId = 1,
	showBonusDate = 16,
	chargeId1to2 = 4,
	bpviewpos = 14,
	showBonus = 15,
	weekLimitTimes = 18,
	bpSkinDesc = 10,
	bpSkinNametxt = 11,
	expLevelUp = 9,
	payStatus1Bonus = 5,
	payStatus2AddLevel = 8,
	expUpShow = 19
}
local var_0_2 = {
	"bpId"
}
local var_0_3 = {
	bpSkinNametxt = 3,
	name = 1,
	bpSkinDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
