module("modules.core.workflow.flow.FlowParallel", package.seeall)

slot0 = class("FlowParallel", BaseFlow)

function slot0.ctor(slot0)
	slot0._workList = {}
	slot0._doneCount = 0
	slot0._succCount = 0
end

function slot0.addWork(slot0, slot1)
	uv0.super.addWork(slot0, slot1)
	table.insert(slot0._workList, slot1)
end

function slot0.onWorkDone(slot0, slot1)
	slot0._doneCount = slot0._doneCount + 1

	if slot1.isSuccess then
		slot0._succCount = slot0._succCount + 1
	end

	slot1:onResetInternal()

	if slot0._doneCount == #slot0._workList then
		if slot0._doneCount == slot0._succCount then
			return slot0:onDone(true)
		else
			return slot0:onDone(false)
		end
	end
end

function slot0.getWorkList(slot0)
	return slot0._workList
end

function slot0.onStartInternal(slot0, slot1)
	uv0.super.onStartInternal(slot0, slot1)

	if #slot0._workList == 0 then
		slot0:onDone(true)

		return
	end

	slot0._doneCount = 0
	slot0._succCount = 0

	for slot5, slot6 in ipairs(slot0._workList) do
		slot6:onStartInternal(slot1)
	end
end

function slot0.onStopInternal(slot0)
	uv0.super.onStopInternal(slot0)

	for slot4, slot5 in ipairs(slot0._workList) do
		if slot5.status == WorkStatus.Running then
			slot5:onStopInternal()
		end
	end
end

function slot0.onResumeInternal(slot0)
	uv0.super.onResumeInternal(slot0)

	for slot4, slot5 in ipairs(slot0._workList) do
		if slot5.status == WorkStatus.Stopped then
			slot5:onResumeInternal()
		end
	end
end

function slot0.onResetInternal(slot0)
	uv0.super.onResetInternal(slot0)

	if slot0.status == WorkStatus.Running or slot0.status == WorkStatus.Stopped then
		for slot4, slot5 in ipairs(slot0._workList) do
			if slot5.status == WorkStatus.Running or slot5.status == WorkStatus.Stopped then
				slot5:onResetInternal()
			end
		end
	end

	slot0._doneCount = 0
	slot0._succCount = 0
end

function slot0.onDestroyInternal(slot0)
	uv0.super.onDestroyInternal(slot0)

	if not slot0._workList then
		return
	end

	for slot4, slot5 in ipairs(slot0._workList) do
		slot5:onStopInternal()
		slot5:onResetInternal()
	end

	for slot4, slot5 in ipairs(slot0._workList) do
		slot5:onDestroyInternal()
	end

	slot0._workList = nil
end

return slot0
