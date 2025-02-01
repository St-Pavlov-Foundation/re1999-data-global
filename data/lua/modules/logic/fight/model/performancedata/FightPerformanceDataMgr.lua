module("modules.logic.fight.model.performancedata.FightPerformanceDataMgr", package.seeall)

slot0 = class("FightPerformanceDataMgr", FightDataMgr)

function slot0.startFight(slot0)
	uv0.super.startFight(slot0)

	slot0.stageMgr = slot0:registModel(FightStageMgr)
	slot0.operateData = slot0:registModel(FightOperateDataMgr)
	slot0.simulateCardData = slot0:registModel(FightSimulateCardDataMgr)
end

function slot0.getOperateDataMgr(slot0)
	return slot0.operateData
end

function slot0.getSimulateCardDataMgr(slot0)
	return slot0.simulateCardData
end

function slot0.getStageMgr(slot0)
	return slot0.stageMgr
end

slot0.instance = slot0.New()

return slot0
