module("modules.logic.rouge.map.work.WaitRougeInteractDoneWork", package.seeall)

slot0 = class("WaitRougeInteractDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if string.nilorempty(RougeMapModel.instance:getCurInteractive()) then
		return slot0:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onClearInteract, slot0.onClearInteract, slot0)
	RougeMapInteractHelper.triggerInteractive()
end

function slot0.onClearInteract(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, slot0.onClearInteract, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, slot0.onClearInteract, slot0)
end

return slot0
