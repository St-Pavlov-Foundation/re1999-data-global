module("modules.logic.rouge.map.work.WaitPopViewDoneWork", package.seeall)

slot0 = class("WaitPopViewDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not RougePopController.instance:hadPopView() then
		return slot0:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onPopViewDone, slot0.onPopViewDone, slot0)
	RougePopController.instance:tryPopView()
end

function slot0.onPopViewDone(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, slot0.onPopViewDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPopViewDone, slot0.onPopViewDone, slot0)
end

return slot0
