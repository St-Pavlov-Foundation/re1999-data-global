module("modules.logic.fight.model.data.FightDataMgr", package.seeall)

slot0 = class("FightDataMgr", BaseModel)

function slot0.registMgr(slot0, slot1)
	slot2 = slot1.New()
	slot2.dataMgr = slot0

	table.insert(slot0.mgrList, slot2)

	return slot2
end

function slot0.initDataMgr(slot0)
	slot0.mgrList = {}

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
	slot0.ASFDDataMgr = slot0:registMgr(FightASFDDataMgr)
	slot0.teamDataMgr = slot0:registMgr(FightTeamDataMgr)
end

function slot0.initTempDataMgr(slot0)
	slot0.stageMgr = slot0:registMgr(FightStageMgr)
	slot0.operationMgr = slot0:registMgr(FightOperationDataMgr)
	slot0.simulationMgr = slot0:registMgr(FightSimulationDataMgr)
	slot0.tempMgr = slot0:registMgr(FightTempDataMgr)
	slot0.LYDataMgr = slot0:registMgr(FightLYDataMgr)
end

function slot0.cancelOperation(slot0)
	for slot4, slot5 in ipairs(slot0.mgrList) do
		if slot5.onCancelOperation then
			slot5:onCancelOperation()
		end
	end
end

function slot0.enterStage(slot0, slot1, slot2)
	slot3 = slot0.stageMgr:getCurStage()
	slot7 = slot2

	slot0.stageMgr:enterStage(slot1, slot7)

	for slot7, slot8 in ipairs(slot0.mgrList) do
		if slot8.onEnterStage then
			slot8:onEnterStage(slot1)
		end

		if slot8.onStageChanged then
			slot8:onStageChanged(slot1, slot3)
		end
	end
end

function slot0.exitStage(slot0, slot1)
	slot0.stageMgr:exitStage(slot1)

	for slot5, slot6 in ipairs(slot0.mgrList) do
		if slot6.onExitStage then
			slot6:onExitStage(slot1)
		end

		if slot6.onStageChanged then
			slot6:onStageChanged(slot0.stageMgr:getCurStage(), slot1)
		end
	end
end

function slot0.updateFightData(slot0, slot1)
	slot0.calMgr:updateFightData(slot1)
end

function slot0.getEntityById(slot0, slot1)
	return slot0.entityMgr:getById(slot1)
end

function slot0.beforePlayRoundProto(slot0, slot1)
	FightDataModel.instance.cacheRoundProto = slot1

	slot0.calMgr:beforePlayRoundProto(slot1)
end

function slot0.afterPlayRoundProto(slot0, slot1)
	slot0.calMgr:afterPlayRoundProto(slot1)
end

function slot0.dealRoundProto(slot0, slot1)
	slot0.calMgr:playStepProto(slot1.fightStep)
	slot0.calMgr:playStepProto(slot1.nextRoundBeginStep)
	slot0.calMgr:dealExPointInfo(slot1.exPointInfo)
end

slot0.instance = slot0.New()

slot0.instance:initDataMgr()

return slot0
