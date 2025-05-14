module("modules.logic.signin.model.SignInInfoMo", package.seeall)

local var_0_0 = pureTable("SignInInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.hasSignInDays = {}
	arg_1_0.addupSignInDay = 0
	arg_1_0.hasGetAddupBonus = {}
	arg_1_0.openFunctionTime = 0
	arg_1_0.hasMonthCardDays = {}
	arg_1_0.monthCardHistory = {}
	arg_1_0.birthdayHeroIds = {}
	arg_1_0.rewardMark = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.hasSignInDays = arg_2_0:_getListInfo(arg_2_1.hasSignInDays)
	arg_2_0.addupSignInDay = arg_2_1.addupSignInDay
	arg_2_0.hasGetAddupBonus = arg_2_0:_getListInfo(arg_2_1.hasGetAddupBonus)
	arg_2_0.openFunctionTime = arg_2_1.openFunctionTime
	arg_2_0.hasMonthCardDays = arg_2_0:_getListInfo(arg_2_1.hasMonthCardDays)
	arg_2_0.monthCardHistory = arg_2_0:_getListInfo(arg_2_1.monthCardHistory, SignInMonthCardHistoryMo)
	arg_2_0.birthdayHeroIds = arg_2_0:_getListInfo(arg_2_1.birthdayHeroIds)

	arg_2_0:setRewardMark(arg_2_1.rewardMark)
end

function var_0_0._getListInfo(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = arg_3_1 and #arg_3_1 or 0

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = arg_3_1[iter_3_0]

		if arg_3_2 then
			var_3_2 = arg_3_2.New()

			var_3_2:init(arg_3_1[iter_3_0])
		end

		table.insert(var_3_0, var_3_2)
	end

	return var_3_0
end

function var_0_0.addSignInfo(arg_4_0, arg_4_1)
	table.insert(arg_4_0.hasSignInDays, arg_4_1.day)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.birthdayHeroIds) do
		table.insert(arg_4_0.birthdayHeroIds, iter_4_1)
	end
end

function var_0_0.getSignDays(arg_5_0)
	return arg_5_0.hasSignInDays
end

function var_0_0.clearSignInDays(arg_6_0)
	arg_6_0.hasSignInDays = {}
end

function var_0_0.addSignTotalIds(arg_7_0, arg_7_1)
	table.insert(arg_7_0.hasGetAddupBonus, arg_7_1)
end

function var_0_0.addBirthdayHero(arg_8_0, arg_8_1)
	table.insert(arg_8_0.birthdayHeroIds, arg_8_1)
end

function var_0_0.setRewardMark(arg_9_0, arg_9_1)
	arg_9_0.rewardMark = arg_9_1
end

function var_0_0.isClaimedAccumulateReward(arg_10_0, arg_10_1)
	local var_10_0 = Bitwise["<<"](1, arg_10_1)

	return Bitwise.has(arg_10_0.rewardMark, var_10_0)
end

function var_0_0.isClaimableAccumulateReward(arg_11_0, arg_11_1)
	local var_11_0 = PlayerModel.instance:getPlayinfo().totalLoginDays or 0

	if arg_11_1 then
		return var_11_0 >= SignInConfig.instance:getSignInLifeTimeBonusCO(arg_11_1).logindaysid and not arg_11_0:isClaimedAccumulateReward(arg_11_1)
	else
		for iter_11_0, iter_11_1 in ipairs(lua_sign_in_lifetime_bonus.configList) do
			local var_11_1 = iter_11_1.logindaysid
			local var_11_2 = iter_11_1.stageid

			if var_11_1 <= var_11_0 and not arg_11_0:isClaimedAccumulateReward(var_11_2) then
				return true
			end
		end

		return false
	end
end

return var_0_0
