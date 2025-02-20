module("modules.logic.fight.system.work.FightWorkProgressChange", package.seeall)

slot0 = class("FightWorkProgressChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._oldValue = FightDataHelper.fieldMgr.progress
end

function slot0.onStart(slot0)
	slot0:com_sendMsg(FightMsgId.FightProgressValueChange)

	slot0._maxValue = FightDataHelper.fieldMgr.progressMax

	if slot0._oldValue < slot0._maxValue and slot0._maxValue <= FightDataHelper.fieldMgr.progress then
		slot0:com_registTimer(slot0._delayAfterPerformance, 0.25 / FightModel.instance:getUISpeed())
	else
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
end

return slot0
