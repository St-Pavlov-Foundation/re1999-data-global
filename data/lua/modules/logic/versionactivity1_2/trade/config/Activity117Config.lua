module("modules.logic.versionactivity1_2.trade.config.Activity117Config", package.seeall)

local var_0_0 = class("Activity117Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._actAllBonus = nil
	arg_1_0._act117Bonus = nil
	arg_1_0._act117Order = nil
	arg_1_0._act117Talk = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity117_bonus",
		"activity117_order",
		"activity117_talk"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity117_bonus" then
		arg_3_0._act117Bonus = arg_3_2
	elseif arg_3_1 == "activity117_order" then
		arg_3_0._act117Order = arg_3_2
	elseif arg_3_1 == "activity117_talk" then
		arg_3_0._act117Talk = arg_3_2
	end
end

function var_0_0.getOrderConfig(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._act117Order.configDict[arg_4_1] then
		return arg_4_0._act117Order.configDict[arg_4_1][arg_4_2]
	end

	return nil
end

function var_0_0.getAllBonusConfig(arg_5_0, arg_5_1)
	arg_5_0._actAllBonus = arg_5_0._actAllBonus or {}

	if not arg_5_0._actAllBonus[arg_5_1] then
		arg_5_0._actAllBonus[arg_5_1] = {}

		local var_5_0 = arg_5_0._act117Bonus.configDict[arg_5_1]

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			table.insert(arg_5_0._actAllBonus[arg_5_1], iter_5_1)
		end
	end

	return arg_5_0._actAllBonus[arg_5_1]
end

function var_0_0.getBonusConfig(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._act117Bonus.configDict[arg_6_1]

	if not var_6_0 then
		return
	end

	return var_6_0[arg_6_2]
end

function var_0_0.getTotalActivityDays(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._act117Order.configDict[arg_7_1]
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		var_7_1 = math.max(iter_7_1.openDay, var_7_1)
	end

	return var_7_1
end

function var_0_0.getTalkCo(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._act117Talk.configDict[arg_8_1] then
		return arg_8_0._act117Talk.configDict[arg_8_1][arg_8_2]
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
