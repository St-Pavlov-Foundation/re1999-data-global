module("modules.logic.dispatch.controller.DispatchController", package.seeall)

slot0 = class("DispatchController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openDispatchView(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot1 then
		slot4 = DispatchEnum.ActId2View[slot1]
	end

	if not slot4 then
		logError(string.format("DispatchController:openDispatchView error,DispatchEnum.ActId2View not have view, actId:%s", slot1))

		return
	end

	if DispatchModel.instance:getDispatchStatus(slot2, slot3) == DispatchEnum.DispatchStatus.Finished then
		return
	end

	DispatchModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(slot4, {
		elementId = slot2,
		dispatchId = slot3
	})
end

slot0.instance = slot0.New()

return slot0
