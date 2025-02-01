module("modules.logic.fight.system.work.FightWorkShowRoundView", package.seeall)

slot0 = class("FightWorkShowRoundView", BaseWork)

function slot0.onStart(slot0)
	if FightModel.instance.hasNextWave and FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		FightController.instance:openRoundView()
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 1 / FightModel.instance:getUISpeed())
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
