module("modules.logic.fight.system.work.FightWorkOpenLoadingBlackView", package.seeall)

slot0 = class("FightWorkOpenLoadingBlackView", BaseWork)
slot1 = 0.5

function slot0.onStart(slot0, slot1)
	if GameGlobalMgr.instance:getLoadingState():getLoadingType() == GameLoadingState.LoadingBlackView then
		slot0._openViewTime = BaseViewContainer.openViewTime
		BaseViewContainer.openViewTime = uv0

		TaskDispatcher.runDelay(slot0._delayDone, slot0, uv0)
		ViewMgr.instance:openView(ViewName.LoadingBlackView)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	BaseViewContainer.openViewTime = slot0._openViewTime

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
