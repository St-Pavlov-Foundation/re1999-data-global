module("modules.logic.sp01.act208.config.Act208Config", package.seeall)

local var_0_0 = class("Act208Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity208_bonus"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._bonusListDic = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity208_bonus" then
		arg_3_0._activityConfig = arg_3_2
	end
end

function var_0_0.getBonusById(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._activityConfig == nil or arg_4_0._activityConfig.configDict[arg_4_1] == nil then
		return nil
	end

	return arg_4_0._activityConfig.configDict[arg_4_1][arg_4_2]
end

function var_0_0.getBonusListById(arg_5_0, arg_5_1)
	if not arg_5_0._activityConfig.configDict[arg_5_1] then
		return nil
	end

	if not arg_5_0._bonusListDic[arg_5_1] then
		local var_5_0 = arg_5_0._activityConfig.configDict[arg_5_1]
		local var_5_1 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			table.insert(var_5_1, iter_5_1)
		end

		table.sort(var_5_1, arg_5_0.sortBonus)

		arg_5_0._bonusListDic[arg_5_1] = var_5_1
	end

	return arg_5_0._bonusListDic[arg_5_1]
end

function var_0_0.sortBonus(arg_6_0, arg_6_1)
	return arg_6_0.id >= arg_6_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
