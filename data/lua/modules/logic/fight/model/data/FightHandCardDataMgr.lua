module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

slot0 = FightDataClass("FightHandCardDataMgr")

function slot0.onConstructor(slot0)
	slot0.handCard = {}
	slot0.originCard = {}
	slot0.redealCard = {}
end

function slot0.setOriginCard(slot0)
	FightDataHelper.coverData(slot0.handCard, slot0.originCard)
end

function slot0.updateHandCardByProto(slot0, slot1)
	FightDataHelper.coverData(FightCardDataHelper.newCardList(slot1), slot0.handCard)
end

function slot0.cacheDistributeCard(slot0, slot1)
	slot0.beforeCards1 = FightCardDataHelper.newCardList(slot1.beforeCards1)
	slot0.teamACards1 = FightCardDataHelper.newCardList(slot1.teamACards1)
	slot0.beforeCards2 = FightCardDataHelper.newCardList(slot1.beforeCards2)
	slot0.teamACards2 = FightCardDataHelper.newCardList(slot1.teamACards2)
end

function slot0.cacheRedealCard(slot0, slot1)
	table.insert(slot0.redealCard, FightCardDataHelper.newCardList(slot1))
end

function slot0.getRedealCard(slot0)
	return table.remove(slot0.redealCard, 1)
end

function slot0.getHandCard(slot0)
	return slot0.handCard
end

function slot0.distribute(slot0, slot1, slot2)
	FightDataHelper.coverData(slot1, slot0.handCard)
	tabletool.addValues(slot0.handCard, FightDataHelper.coverData(slot2))
	FightCardDataHelper.combineCardListForLocal(slot0.handCard)
end

return slot0
