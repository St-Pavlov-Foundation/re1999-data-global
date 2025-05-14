module("modules.logic.signin.config.SignInConfig", package.seeall)

local var_0_0 = class("SignInConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._signMonthRewards = nil
	arg_1_0._signRewards = nil
	arg_1_0._signDesc = nil
	arg_1_0._goldRewards = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"sign_in_addup_bonus",
		"sign_in_bonus",
		"sign_in_word",
		"activity143_bonus",
		"sign_in_lifetime_bonus"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "sign_in_addup_bonus" then
		arg_3_0._signMonthRewards = arg_3_2
	elseif arg_3_1 == "sign_in_bonus" then
		arg_3_0._signRewards = arg_3_2
	elseif arg_3_1 == "sign_in_word" then
		arg_3_0._signDesc = arg_3_2
	elseif arg_3_1 == "activity143_bonus" then
		arg_3_0._goldRewards = arg_3_2
	end
end

function var_0_0.getSignMonthReward(arg_4_0, arg_4_1)
	return arg_4_0._signMonthRewards.configDict[arg_4_1]
end

function var_0_0.getSignMonthRewards(arg_5_0)
	return arg_5_0._signMonthRewards.configDict
end

function var_0_0.getSignRewards(arg_6_0, arg_6_1)
	return arg_6_0._signRewards.configDict[arg_6_1]
end

function var_0_0.getSignDesc(arg_7_0, arg_7_1)
	return arg_7_0._signDesc.configDict[arg_7_1]
end

function var_0_0.getGoldReward(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._goldRewards.configDict[ActivityEnum.Activity.DailyAllowance]) do
		if iter_8_1.day == arg_8_1 then
			return iter_8_1.bonus
		end
	end
end

function var_0_0.getSignDescByDate(arg_9_0, arg_9_1)
	local var_9_0 = os.date("%Y-%m-%d 00:00:00", arg_9_1)

	for iter_9_0, iter_9_1 in pairs(arg_9_0._signDesc.configDict) do
		if iter_9_1.signindate == var_9_0 then
			return iter_9_1.signinword
		end
	end
end

function var_0_0.getSignInLifeTimeBonusCO(arg_10_0, arg_10_1)
	return lua_sign_in_lifetime_bonus.configList[arg_10_1]
end

function var_0_0.getSignInLifeTimeBonusCount(arg_11_0)
	return #lua_sign_in_lifetime_bonus.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
