module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

slot0 = FightDataBase("FightHandCardDataMgr")

function slot0.ctor(slot0)
	slot0.handCard = {}
	slot0.redealCardProto = {}
end

function slot0.updateHandCardByProto(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightCardInfoMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	FightDataHelper.coverData(slot2, slot0.handCard)
end

function slot0.cacheDistributeCard(slot0, slot1)
	slot0.beforeCards1 = slot1.beforeCards1
	slot0.teamACards1 = slot1.teamACards1
	slot0.beforeCards2 = slot1.beforeCards2
	slot0.teamACards2 = slot1.teamACards2
end

function slot0.cacheRedealProto(slot0, slot1)
	table.insert(slot0.redealCardProto, slot1)
end

function slot0.getRedealProto(slot0)
	return table.remove(slot0.redealCardProto, 1)
end

function slot0.getHandCard(slot0)
	return slot0.handCard
end

function slot0.distribute(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = FightCardInfoMO.New()

		slot9:init(slot8)
		table.insert(slot3, slot9)
	end

	FightDataHelper.coverData(slot3, slot0.handCard)

	for slot7, slot8 in ipairs(slot2) do
		slot9 = FightCardInfoMO.New()

		slot9:init(slot8)
		table.insert(slot0.handCard, slot9)
	end

	FightCardDataHelper.combineCardList(slot0.handCard)
end

return slot0
