module("modules.logic.scene.summon.comp.SummonSceneViewComp", package.seeall)

slot0 = class("SummonSceneViewComp", BaseSceneComp)

function slot0.openView(slot0)
	slot0._param = SummonController.instance.summonViewParam
	slot0._viewOpenFromEnterScene = false

	slot0:startOpenMainView()
end

function slot0.needWaitForViewOpen(slot0)
	return not SummonController.instance:isInSummonGuide()
end

function slot0.startOpenMainView(slot0)
	if slot0:needWaitForViewOpen() then
		if not ViewMgr.instance:isOpen(ViewName.SummonADView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpened, slot0)

			slot0._viewOpenFromEnterScene = true

			SummonMainController.instance:openSummonView(slot0._param, true)
		else
			TaskDispatcher.runDelay(slot0.delayDispatchOpenViewFinish, slot0, 0.001)
		end
	else
		TaskDispatcher.runDelay(slot0.delayDispatchOpenViewFinish, slot0, 0.001)
	end
end

function slot0.delayDispatchOpenViewFinish(slot0)
	slot0:dispatchEvent(SummonSceneEvent.OnViewFinish)
end

function slot0.onViewOpened(slot0, slot1)
	if slot1 == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpened, slot0)
		slot0:dispatchEvent(SummonSceneEvent.OnViewFinish)
	end
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	if slot0._viewOpenFromEnterScene then
		-- Nothing
	end
end

function slot0.onSceneClose(slot0)
	slot0._viewOpenFromEnterScene = false

	TaskDispatcher.cancelTask(slot0.delayDispatchOpenViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpened, slot0)
	ViewMgr.instance:closeView(ViewName.SummonView)

	if SummonController.instance:isInSummonGuide() then
		ViewMgr.instance:closeView(ViewName.SummonADView)
	end
end

function slot0.onSceneHide(slot0)
	slot0:onSceneClose()
end

return slot0
