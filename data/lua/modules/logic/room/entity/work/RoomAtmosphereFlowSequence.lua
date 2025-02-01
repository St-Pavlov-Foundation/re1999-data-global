module("modules.logic.room.entity.work.RoomAtmosphereFlowSequence", package.seeall)

slot0 = class("RoomAtmosphereFlowSequence", FlowSequence)
slot1 = "done"

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._doneParam = slot1
end

function slot0.setAllWorkAudioIsFade(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._workList) do
		slot6:setAudioIsFade(slot1)
	end
end

function slot0.onDone(slot0, slot1)
	slot0.isSuccess = slot1
	slot0.status = WorkStatus.Done

	slot0:clearWork()

	if slot0.parent then
		slot0.parent:onWorkDone(slot0)
	end

	if slot0._dispatcher then
		slot0._dispatcher:dispatchEvent(uv0, slot1, slot0._doneParam)
	end
end

return slot0
