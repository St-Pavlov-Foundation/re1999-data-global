module("modules.logic.explore.model.mo.ExploreMapSimpleMo", package.seeall)

slot0 = pureTable("ExploreMapSimpleMo")

function slot0.ctor(slot0)
	slot0.bonusNum = 0
	slot0.goldCoin = 0
	slot0.purpleCoin = 0
	slot0.bonusNumTotal = 0
	slot0.goldCoinTotal = 0
	slot0.purpleCoinTotal = 0
	slot0.bonusIds = {}
end

function slot0.init(slot0, slot1)
	slot0.bonusNum = slot1.bonusNum
	slot0.goldCoin = slot1.goldCoin
	slot0.purpleCoin = slot1.purpleCoin
	slot0.bonusNumTotal = slot1.bonusNumTotal
	slot0.goldCoinTotal = slot1.goldCoinTotal
	slot0.purpleCoinTotal = slot1.purpleCoinTotal
	slot0.bonusIds = {}

	for slot5, slot6 in pairs(slot1.bonusIds) do
		slot0.bonusIds[slot6] = true
	end
end

function slot0.onGetCoin(slot0, slot1, slot2)
	if slot1 == ExploreEnum.CoinType.Bonus then
		slot0.bonusNum = slot2
	elseif slot1 == ExploreEnum.CoinType.GoldCoin then
		slot0.goldCoin = slot2
	elseif slot1 == ExploreEnum.CoinType.PurpleCoin then
		slot0.purpleCoin = slot2
	end
end

return slot0
