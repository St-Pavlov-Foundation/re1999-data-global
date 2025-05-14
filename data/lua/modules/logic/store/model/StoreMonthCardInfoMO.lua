module("modules.logic.store.model.StoreMonthCardInfoMO", package.seeall)

local var_0_0 = pureTable("StoreMonthCardInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:update(arg_1_1)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.expiredTime = arg_2_1.expireTime
	arg_2_0.hasGetBonus = arg_2_1.hasGetBonus
	arg_2_0.config = StoreConfig.instance:getChargeGoodsConfig(arg_2_0.id)
end

function var_0_0.getRemainDay(arg_3_0)
	local var_3_0 = arg_3_0.expiredTime - ServerTime.now()

	if var_3_0 < 0 then
		return StoreEnum.MonthCardStatus.NotPurchase
	elseif var_3_0 < TimeUtil.OneDaySecond then
		return StoreEnum.MonthCardStatus.NotEnoughOneDay
	else
		return math.floor(var_3_0 / TimeUtil.OneDaySecond)
	end
end

function var_0_0.hasExpired(arg_4_0)
	return arg_4_0.expiredTime < ServerTime.now()
end

return var_0_0
