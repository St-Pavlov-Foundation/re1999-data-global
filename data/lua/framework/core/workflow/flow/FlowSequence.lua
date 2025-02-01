module("framework.core.workflow.flow.FlowSequence", package.seeall)

slot0 = class("FlowSequence", BaseFlow)

function slot0.ctor(slot0)
	slot0._workList = {}
	slot0._curIndex = 0
end

function slot0.addWork(slot0, slot1)
	uv0.super.addWork(slot0, slot1)
	table.insert(slot0._workList, slot1)
end

function slot0.onWorkDone(slot0, slot1)
	if slot0._workList[slot0._curIndex] and slot1 ~= slot2 then
		return
	end

	if slot1.isSuccess then
		slot1:onResetInternal()

		return slot0:_runNext()
	else
		slot1:onResetInternal()

		return slot0:onDone(false)
	end
end

function slot0.getWorkList(slot0)
	return slot0._workList
end

function slot0.onStartInternal(slot0, slot1)
	uv0.super.onStartInternal(slot0, slot1)

	slot0._curIndex = 0

	return slot0:_runNext()
end

function slot0.onStopInternal(slot0)
	uv0.super.onStopInternal(slot0)

	if slot0._workList[slot0._curIndex] and slot1.status == WorkStatus.Running then
		slot1:onStopInternal()
	end
end

function slot0.onResumeInternal(slot0)
	uv0.super.onResumeInternal(slot0)

	if slot0._workList[slot0._curIndex] and slot1.status == WorkStatus.Stopped then
		slot1:onResumeInternal()
	end
end

function slot0.onResetInternal(slot0)
	uv0.super.onResetInternal(slot0)

	if (slot0.status == WorkStatus.Running or slot0.status == WorkStatus.Stopped) and slot0._workList[slot0._curIndex] and (slot1.status == WorkStatus.Running or slot1.status == WorkStatus.Stopped) then
		slot1:onResetInternal()
	end

	slot0._curIndex = 0
end

function slot0.onDestroyInternal(slot0)
	uv0.super.onDestroyInternal(slot0)

	if not slot0._workList then
		return
	end

	if (slot0.status == WorkStatus.Running or slot0.status == WorkStatus.Stopped) and slot0._workList[slot0._curIndex] then
		slot1:onStopInternal()
		slot1:onResetInternal()
	end

	for slot4, slot5 in ipairs(slot0._workList) do
		slot5:onDestroyInternal()
	end

	slot0._workList = nil
	slot0._curIndex = nil
end

function slot0._runNext(slot0)
	slot0._curIndex = slot0._curIndex + 1

	if slot0._curIndex <= #slot0._workList then
		return slot0._workList[slot0._curIndex]:onStartInternal(slot0.context)
	else
		return slot0:onDone(true)
	end
end

return slot0
