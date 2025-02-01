module("modules.logic.scene.fight.preloadwork.FightPreloadCardInitWork", package.seeall)

slot0 = class("FightPreloadCardInitWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if ViewMgr.instance:isOpenFinish(ViewName.FightView) then
		slot0:_updateCards()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.FightView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
		slot0:_updateCards()
	end
end

function slot0._updateCards(slot0)
	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, FightCardModel.instance:getHandCards())

	slot3 = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.FightView).viewGO, "root/handcards/handcards")

	gohelper.setActive(slot3, true)

	if gohelper.onceAddComponent(slot3, gohelper.Type_CanvasGroup) then
		slot4.alpha = 0
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.01)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

return slot0
