module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenDungeonMapView", package.seeall)

slot0 = class("WaitGuideActionOpenDungeonMapView", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._viewName = ViewName.DungeonMapView

	if not ViewMgr.instance:isOpen(slot0._viewName) then
		slot0:onDone(true)

		return
	end

	if not gohelper.isNil(ViewMgr.instance:getContainer(slot0._viewName):getMapScene() and slot3:getSceneGo()) then
		slot0:onDone(true)

		return
	end

	DungeonController.instance:registerCallback(DungeonEvent.OnShowMap, slot0._onShowMap, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 2)
end

function slot0._onShowMap(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowMap, slot0._onShowMap, slot0)
end

return slot0
