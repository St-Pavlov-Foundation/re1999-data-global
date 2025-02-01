module("modules.logic.rouge.map.work.WaitRougeActorMoveToEndDoneWork", package.seeall)

slot0 = class("WaitRougeActorMoveToEndDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not RougeMapModel.instance:needPlayMoveToEndAnim() then
		return slot0:onDone(true)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
	RougeMapController.instance:registerCallback(RougeMapEvent.onEndActorMoveToEnd, slot0.onEndActorMoveToEnd, slot0)
end

function slot0.onEndActorMoveToEnd(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, slot0.onEndActorMoveToEnd, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, slot0.onEndActorMoveToEnd, slot0)
end

return slot0
