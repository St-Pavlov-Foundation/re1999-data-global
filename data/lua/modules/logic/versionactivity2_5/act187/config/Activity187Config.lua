module("modules.logic.versionactivity2_5.act187.config.Activity187Config", package.seeall)

local var_0_0 = class("Activity187Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity187_const",
		"activity187",
		"activity187_blessing"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.getAct187ConstCfg(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lua_activity187_const.configDict[arg_4_1]

	if not var_4_0 and arg_4_2 then
		logError(string.format("Activity187Config:getAct187ConstCfg error, cfg is nil, constId:%s", arg_4_1))
	end

	return var_4_0
end

function var_0_0.getAct187Const(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = arg_5_0:getAct187ConstCfg(arg_5_1, true)

	if var_5_1 then
		var_5_0 = var_5_1.value
	end

	return var_5_0
end

function var_0_0.getAct187AccrueRewardCfg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = lua_activity187.configDict[arg_6_1] and lua_activity187.configDict[arg_6_1][arg_6_2]

	if not var_6_0 and arg_6_3 then
		logError(string.format("Activity187Config:getAct187AccrueRewardCfg error, cfg is nil, actId:%s, accrueId:%s", arg_6_1, arg_6_2))
	end

	return var_6_0
end

function var_0_0.getAccrueRewardIdList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = lua_activity187.configDict[arg_7_1]

	if var_7_1 then
		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			var_7_0[#var_7_0 + 1] = iter_7_0
		end
	end

	return var_7_0
end

function var_0_0.getAccrueRewards(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getAct187AccrueRewardCfg(arg_8_1, arg_8_2, true)

	if var_8_1 then
		local var_8_2 = GameUtil.splitString2(var_8_1.bonus, true)

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			local var_8_3 = {
				accrueId = arg_8_2,
				materilType = iter_8_1[1],
				materilId = iter_8_1[2],
				quantity = iter_8_1[3]
			}

			var_8_0[#var_8_0 + 1] = var_8_3
		end
	end

	return var_8_0
end

function var_0_0.getAct187BlessingCfg(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = activity187_blessing.configDict[arg_9_1] and activity187_blessing.configDict[arg_9_1][arg_9_2]

	if not var_9_0 and arg_9_3 then
		logError(string.format("Activity187Config:getAct187BlessingCfg error, cfg is nil, actId:%s, rewardId:%s", arg_9_1, arg_9_2))
	end

	return var_9_0
end

function var_0_0.getLantern(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = ""
	local var_10_1 = arg_10_0:getAct187BlessingCfg(arg_10_1, arg_10_2)

	if var_10_1 then
		var_10_0 = var_10_1.lantern
	end

	return var_10_0
end

function var_0_0.getLanternRibbon(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = ""
	local var_11_1 = arg_11_0:getAct187BlessingCfg(arg_11_1, arg_11_2)

	if var_11_1 then
		var_11_0 = var_11_1.lanternRibbon
	end

	return var_11_0
end

function var_0_0.getLanternImg(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1 = arg_12_0:getAct187BlessingCfg(arg_12_1, arg_12_2)

	if var_12_1 then
		var_12_0 = var_12_1.lanternImg
	end

	return var_12_0
end

function var_0_0.getLanternImgBg(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1 = arg_13_0:getAct187BlessingCfg(arg_13_1, arg_13_2)

	if var_13_1 then
		var_13_0 = var_13_1.lanternImgBg
	end

	return var_13_0
end

function var_0_0.getBlessing(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ""
	local var_14_1 = arg_14_0:getAct187BlessingCfg(arg_14_1, arg_14_2)

	if var_14_1 then
		var_14_0 = var_14_1.blessing
	end

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
