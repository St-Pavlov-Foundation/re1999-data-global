module("modules.logic.fight.model.mo.FightCardMO", package.seeall)

slot0 = pureTable("FightCardMO")

function slot0.ctor(slot0)
	slot0.cardGroup = {}
	slot0.actPoint = 0
	slot0.moveNum = 0
	slot0.dealCardGroup = {}
	slot0.beforeCards = {}
	slot0.extraMoveAct = 0
	slot0.playCanAddExpoint = nil
	slot0.combineCanAddExpoint = nil
	slot0.moveCanAddExpoint = nil
end

function slot0.init(slot0, slot1)
	slot0.cardGroup = slot0:_buildCards(slot1.cardGroup)
	slot0.actPoint = slot1.actPoint
	slot0.moveNum = slot1.moveNum
	slot0.dealCardGroup = slot0:_buildCards(slot1.dealCardGroup)
	slot0.beforeCards = slot0:_buildCards(slot1.beforeCards)
	slot0.extraMoveAct = slot1.extraMoveAct
end

function slot0.setExtraMoveAct(slot0, slot1)
	slot0.extraMoveAct = slot1
end

function slot0.setCards(slot0, slot1)
	slot0.cardGroup = slot1
end

function slot0.reset(slot0)
	slot0.cardGroup = {}
	slot0.actPoint = 0
	slot0.moveNum = 0
end

function slot0._buildCards(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightCardInfoMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0.isUnlimitMoveCard(slot0)
	return slot0.extraMoveAct == -1
end

return slot0
