module("modules.logic.fight.system.work.FightWorkTowerScoreChangeWork", package.seeall)

slot0 = class("FightWorkTowerScoreChangeWork", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
end

function slot0.onStart(slot0)
	slot0.beforeScore = FightModel.instance:getIndicatorNum(FightEnum.IndicatorId.PaTaScore) or 0

	FightModel.instance:setIndicatorNum(slot1, slot0.beforeScore + slot0._actEffectMO.effectNum)

	slot0.curScore = FightModel.instance:getIndicatorNum(slot1)

	slot0:com_sendFightEvent(FightEvent.OnAssistBossScoreChange, slot0.beforeScore, slot0.curScore)
	slot0:onDone(true)
end

return slot0
