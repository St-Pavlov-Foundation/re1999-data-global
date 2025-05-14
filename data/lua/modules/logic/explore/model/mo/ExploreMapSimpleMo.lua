module("modules.logic.explore.model.mo.ExploreMapSimpleMo", package.seeall)

local var_0_0 = pureTable("ExploreMapSimpleMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.bonusNum = 0
	arg_1_0.goldCoin = 0
	arg_1_0.purpleCoin = 0
	arg_1_0.bonusNumTotal = 0
	arg_1_0.goldCoinTotal = 0
	arg_1_0.purpleCoinTotal = 0
	arg_1_0.bonusIds = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.bonusNum = arg_2_1.bonusNum
	arg_2_0.goldCoin = arg_2_1.goldCoin
	arg_2_0.purpleCoin = arg_2_1.purpleCoin
	arg_2_0.bonusNumTotal = arg_2_1.bonusNumTotal
	arg_2_0.goldCoinTotal = arg_2_1.goldCoinTotal
	arg_2_0.purpleCoinTotal = arg_2_1.purpleCoinTotal
	arg_2_0.bonusIds = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_1.bonusIds) do
		arg_2_0.bonusIds[iter_2_1] = true
	end
end

function var_0_0.onGetCoin(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ExploreEnum.CoinType.Bonus then
		arg_3_0.bonusNum = arg_3_2
	elseif arg_3_1 == ExploreEnum.CoinType.GoldCoin then
		arg_3_0.goldCoin = arg_3_2
	elseif arg_3_1 == ExploreEnum.CoinType.PurpleCoin then
		arg_3_0.purpleCoin = arg_3_2
	end
end

return var_0_0
