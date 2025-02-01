module("modules.logic.store.model.StoreMonthCardInfoMO", package.seeall)

slot0 = pureTable("StoreMonthCardInfoMO")

function slot0.init(slot0, slot1)
	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot0.id = slot1.id
	slot0.expiredTime = slot1.expireTime
	slot0.hasGetBonus = slot1.hasGetBonus
	slot0.config = StoreConfig.instance:getChargeGoodsConfig(slot0.id)
end

function slot0.getRemainDay(slot0)
	if slot0.expiredTime - ServerTime.now() < 0 then
		return StoreEnum.MonthCardStatus.NotPurchase
	elseif slot1 < TimeUtil.OneDaySecond then
		return StoreEnum.MonthCardStatus.NotEnoughOneDay
	else
		return math.floor(slot1 / TimeUtil.OneDaySecond)
	end
end

function slot0.hasExpired(slot0)
	return slot0.expiredTime < ServerTime.now()
end

return slot0
