module("modules.logic.fight.model.data.FightPlayCardDataMgr", package.seeall)

slot0 = FightDataClass("FightPlayCardDataMgr")

function slot0.onConstructor(slot0)
	slot0.playCard = {}
	slot0.enemyPlayCard = {}
	slot0.enemyAct174PlayCard = {}
end

function slot0.setAct174EnemyCard(slot0, slot1)
	FightDataHelper.coverData(FightCardDataHelper.newPlayCardList(slot1), slot0.enemyAct174PlayCard)
end

return slot0
