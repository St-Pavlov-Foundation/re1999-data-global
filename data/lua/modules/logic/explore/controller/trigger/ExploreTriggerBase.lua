module("modules.logic.explore.controller.trigger.ExploreTriggerBase", package.seeall)

slot0 = class("ExploreTriggerBase", BaseWork)

function slot0.onStart(slot0)
	if slot0.isCancel then
		slot0:cancel(slot0._param, slot0._unit)
	else
		slot0:handle(slot0._param, slot0._unit)
	end
end

function slot0.setParam(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._recordLen = 0
	slot0._param = slot1
	slot0._unit = slot2
	slot0.unitId = slot2.id
	slot0.unitType = slot0._unit:getUnitType()
	slot0.stepIndex = slot3
	slot0.clientOnly = slot4
	slot0.isCancel = slot5
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	slot0:onDone(true)
end

function slot0.sendTriggerRequest(slot0, slot1)
	if not slot0.stepIndex then
		slot0:onDone(false)

		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(slot0.unitId, slot0.stepIndex, slot1 or "", slot0.onRequestCallBack, slot0)
end

function slot0.onRequestCallBack(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:onReply(slot1, slot2, slot3)
	else
		slot0:onDone(false)
	end
end

function slot0.onStepDone(slot0, slot1)
	slot0:onDone(slot1)
end

function slot0.handle(slot0)
	slot0:onDone(true)
end

function slot0.cancel(slot0)
	slot0:onDone(true)
end

return slot0
