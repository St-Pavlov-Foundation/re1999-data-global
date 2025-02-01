module("modules.logic.fight.model.data.FightDataMgr", package.seeall)

slot0 = class("FightDataMgr", BaseModel)

function slot0.registModel(slot0, slot1)
	slot2 = slot1.New()
	slot2.dataMgr = slot0

	return slot2
end

function slot0.startFight(slot0)
	slot0.calculateDataMgr = slot0:registModel(FightCalculateDataMgr)
	slot0.entityData = slot0:registModel(FightEntityDataMgr)
	slot0.entityExData = slot0:registModel(FightEntityEXDataMgr)
	slot0.handCardData = slot0:registModel(FightHandCardDataMgr)
	slot0.fieldData = slot0:registModel(FightFieldDataMgr)
	slot0.cacheFightData = slot0:registModel(FightCacheFightDataMgr)
end

function slot0.getEntityEXDataMgr(slot0)
	return slot0.entityExData
end

function slot0.updateFightData(slot0, slot1)
	slot0.entityData:addEntityMOListByFightMsg(slot1)
end

function slot0.getEntityDataMgr(slot0)
	return slot0.entityData
end

function slot0.getEntityMO(slot0, slot1)
	return slot0.entityData:getEntityMO(slot1)
end

function slot0.getCalculateDataMgr(slot0)
	return slot0.calculateDataMgr
end

function slot0.getCacheFightDataMgr(slot0)
	return slot0.cacheFightData
end

function slot0.getHandCardDataMgr(slot0)
	return slot0.handCardData
end

function slot0.getFieldDataMgr(slot0)
	return slot0.fieldData
end

function slot0.cacheRoundProto(slot0, slot1)
	slot0.handCardData:cacheDistributeCard(slot1)
end

function slot0.dealRoundProto(slot0, slot1)
	slot0.calculateDataMgr:playStepProto(slot1.fightStep)
	slot0.calculateDataMgr:playStepProto(slot1.nextRoundBeginStep)
	slot0.calculateDataMgr:afterPlayStepProto(slot1)
	slot0.calculateDataMgr:dealExPointInfo(slot1.exPointInfo)
end

slot0.instance = slot0.New()

return slot0
