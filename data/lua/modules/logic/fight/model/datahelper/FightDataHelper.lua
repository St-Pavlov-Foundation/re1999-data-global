module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

slot0 = {}

setmetatable(slot0, {
	__index = function (slot0, slot1)
		if slot1 == "calMgr" then
			return FightPerformanceDataMgr.instance:getCalculateDataMgr()
		elseif slot1 == "entityMgr" then
			return FightPerformanceDataMgr.instance:getEntityDataMgr()
		elseif slot1 == "handCardMgr" then
			return FightPerformanceDataMgr.instance:getHandCardDataMgr()
		elseif slot1 == "fieldMgr" then
			return FightPerformanceDataMgr.instance:getFieldDataMgr()
		elseif slot1 == "operateMgr" then
			return FightPerformanceDataMgr.instance:getOperateDataMgr()
		elseif slot1 == "simulateMgr" then
			return FightPerformanceDataMgr.instance:getSimulateCardDataMgr()
		elseif slot1 == "stageMgr" then
			return FightPerformanceDataMgr.instance:getStageMgr()
		end
	end
})

function slot0.startFight(slot0)
	FightDataMgr.instance:startFight()
	FightPerformanceDataMgr.instance:startFight()

	if not slot0 then
		uv0.stageMgr:enterStage(FightStageMgr.StageType.Normal)

		return
	end

	FightDataMgr.instance:updateFightData(slot0.fight)
	FightPerformanceDataMgr.instance:updateFightData(slot0.fight)

	slot1 = FightStageMgr.StageType.Normal

	if (FightModel.GMForceVersion or slot0.fight.version or 0) >= 1 then
		if slot0.fight.isRecord then
			slot1 = FightStageMgr.StageType.Replay
		end
	elseif FightModel.instance:getFightParam() and slot4.isReplay then
		slot1 = FightStageMgr.StageType.Replay
	elseif FightReplayModel.instance:isReconnectReplay() then
		slot1 = FightStageMgr.StageType.Replay
	end

	uv0.stageMgr:enterStage(slot1)
	uv0.stageMgr:enterStage(FightStageMgr.StageType.Enter)
end

function slot0.cacheFightWavePush(slot0)
	FightDataMgr.instance:getCacheFightDataMgr():cacheFightWavePush(slot0.fight)
	FightPerformanceDataMgr.instance:getCacheFightDataMgr():cacheFightWavePush(slot0.fight)
end

function slot0.playEffectData(slot0)
end

FightDataMgr.instance:startFight()
FightPerformanceDataMgr.instance:startFight()

return slot0
