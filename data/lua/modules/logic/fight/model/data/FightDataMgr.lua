module("modules.logic.fight.model.data.FightDataMgr", package.seeall)

slot0 = class("FightDataMgr", BaseModel)

function slot0.registMgr(slot0, slot1)
	slot2 = slot1.New()
	slot2.dataMgr = slot0

	return slot2
end

function slot0.initDataMgr(slot0)
	slot0:initTrueDataMgr()
	slot0:initTempDataMgr()
end

function slot0.initTrueDataMgr(slot0)
	slot0.calMgr = slot0:registMgr(FightCalculateDataMgr)
	slot0.cacheFightMgr = slot0:registMgr(FightCacheFightDataMgr)
	slot0.entityMgr = slot0:registMgr(FightEntityDataMgr)
	slot0.entityExMgr = slot0:registMgr(FightEntityEXDataMgr)
	slot0.handCardMgr = slot0:registMgr(FightHandCardDataMgr)
	slot0.fieldMgr = slot0:registMgr(FightFieldDataMgr)
	slot0.paTaMgr = slot0:registMgr(FightPaTaDataMgr)
	slot0.playCardMgr = slot0:registMgr(FightPlayCardDataMgr)
end

function slot0.initTempDataMgr(slot0)
	slot0.stageMgr = slot0:registMgr(FightStageMgr)
	slot0.operateMgr = slot0:registMgr(FightOperateDataMgr)
	slot0.simulateMgr = slot0:registMgr(FightSimulateCardDataMgr)
	slot0.tempMgr = slot0:registMgr(FightTempDataMgr)
end

function slot0.updateFightData(slot0, slot1)
	slot0.calMgr:updateFightData(slot1)
end

function slot0.getEntityById(slot0, slot1)
	return slot0.entityMgr:getById(slot1)
end

function slot0.cacheRoundProto(slot0, slot1)
	slot0.handCardMgr:cacheDistributeCard(slot1)
end

function slot0.dealRoundProto(slot0, slot1)
	slot0.calMgr:playStepProto(slot1.fightStep)
	slot0.calMgr:playStepProto(slot1.nextRoundBeginStep)
	slot0.calMgr:afterPlayStepProto(slot1)
	slot0.calMgr:dealExPointInfo(slot1.exPointInfo)
end

slot0.instance = slot0.New()

slot0.instance:initDataMgr()

return slot0
