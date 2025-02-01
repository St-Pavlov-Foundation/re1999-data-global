module("modules.logic.battlepass.flow.BpWaitBonusAnimWork", package.seeall)

slot0 = class("BpWaitBonusAnimWork", BaseWork)

function slot0.onStart(slot0)
	if not BpModel.instance.preStatus or not ViewMgr.instance:isOpen(ViewName.BpView) then
		slot0:onDone(true)
	else
		BpController.instance:registerCallback(BpEvent.BonusAnimEnd, slot0.onAnimDone, slot0)
		BpController.instance:dispatchEvent(BpEvent.ForcePlayBonusAnim)
	end
end

function slot0.onAnimDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	BpController.instance:unregisterCallback(BpEvent.BonusAnimEnd, slot0.onAnimDone, slot0)
end

return slot0
