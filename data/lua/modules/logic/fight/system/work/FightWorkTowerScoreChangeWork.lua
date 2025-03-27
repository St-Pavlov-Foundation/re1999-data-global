module("modules.logic.fight.system.work.FightWorkTowerScoreChangeWork", package.seeall)

slot0 = class("FightWorkTowerScoreChangeWork", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.indicatorId = FightEnum.IndicatorId.PaTaScore
	slot0._beforeScore = FightDataHelper.fieldMgr.indicatorDict[slot0.indicatorId] and slot1.num or 0
end

function slot0.onStart(slot0)
	slot0._curScore = FightDataHelper.fieldMgr.indicatorDict[slot0.indicatorId] and slot1.num or 0

	slot0:com_sendFightEvent(FightEvent.OnIndicatorChange, slot0.indicatorId)
	slot0:com_sendFightEvent(FightEvent.OnAssistBossScoreChange, slot0._beforeScore, slot0._curScore)
	slot0:onDone(true)
end

return slot0
