module("modules.logic.fight.system.work.FightWorkCardDissolveDone", package.seeall)

slot0 = class("FightWorkCardDissolveDone", BaseWork)

function slot0.onStart(slot0)
	if FightCardModel.instance:isDissolving() then
		TaskDispatcher.runDelay(slot0._timeOut, slot0, 10)
		TaskDispatcher.runRepeat(slot0._frameCheck, slot0, 0.01, 300)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._frameCheck(slot0)
	if not FightCardModel.instance:isDissolving() then
		slot0:onDone(true)
	end
end

function slot0._onCombineCardEnd(slot0)
	slot0:onDone(true)
end

function slot0._timeOut(slot0)
	logNormal("FightWorkCardDissolveDone 奇怪，超时结束 done")
	FightCardModel.instance:setDissolving(false)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.cancelTask(slot0._timeOut, slot0)
	TaskDispatcher.cancelTask(slot0._frameCheck, slot0)
end

return slot0
