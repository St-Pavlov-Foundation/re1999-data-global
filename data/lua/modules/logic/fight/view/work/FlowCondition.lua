module("modules.logic.fight.view.work.FlowCondition", package.seeall)

slot0 = class("FlowCondition", BaseFlow)

function slot0.ctor(slot0)
	slot0._conditionWork = nil
	slot0._trueWork = nil
	slot0._falseWork = nil
end

function slot0.addWork(slot0, slot1, slot2, slot3)
	uv0.super.addWork(slot0, slot1)
	uv0.super.addWork(slot0, slot2)
	uv0.super.addWork(slot0, slot3)

	slot0._conditionWork = slot1
	slot0._trueWork = slot2
	slot0._falseWork = slot3
end

function slot0.onWorkDone(slot0, slot1)
	if slot1 == slot0._conditionWork then
		if slot1.isSuccess then
			slot0._trueWork:onStartInternal(slot0.context)
		else
			slot0._falseWork:onStartInternal(slot0.context)
		end
	else
		slot0.status = slot1.status

		slot0:onDone(slot1.isSuccess)
	end

	slot1:onResetInternal()
end

function slot0.onStartInternal(slot0, slot1)
	uv0.super.onStartInternal(slot0, slot1)
	slot0._conditionWork:onStartInternal(slot0.context)
end

function slot0.onStopInternal(slot0)
	uv0.super.onStopInternal(slot0)

	if slot0._trueWork.status == WorkStatus.Running then
		slot0._trueWork:onStopInternal()
	elseif slot0._falseWork.status == WorkStatus.Running then
		slot0._falseWork:onStopInternal()
	end
end

function slot0.onResumeInternal(slot0)
	uv0.super.onResumeInternal(slot0)

	if slot0._trueWork.status == WorkStatus.Stopped then
		slot0._trueWork:onResumeInternal()
	elseif slot0._falseWork.status == WorkStatus.Stopped then
		slot0._falseWork:onResumeInternal()
	end
end

function slot0.onResetInternal(slot0)
	uv0.super.onResetInternal(slot0)

	if slot0._trueWork.status == WorkStatus.Running or slot0._trueWork.status == WorkStatus.Stopped then
		slot0._trueWork:onResumeInternal()
	elseif slot0._falseWork.status == WorkStatus.Running or slot0._falseWork.status == WorkStatus.Stopped then
		slot0._falseWork:onResumeInternal()
	end
end

function slot0.onDestroyInternal(slot0)
	uv0.super.onDestroyInternal(slot0)

	if slot0._trueWork.status == WorkStatus.Running then
		slot0._trueWork:onStopInternal()
	elseif slot0._falseWork.status == WorkStatus.Running then
		slot0._falseWork:onStopInternal()
	end

	if slot0._trueWork.status == WorkStatus.Stopped then
		slot0._trueWork:onResetInternal()
	elseif slot0._falseWork.status == WorkStatus.Stopped then
		slot0._falseWork:onResetInternal()
	end

	slot0._conditionWork:onDestroyInternal()
	slot0._trueWork:onDestroyInternal()
	slot0._falseWork:onDestroyInternal()

	slot0._conditionWork = nil
	slot0._trueWork = nil
	slot0._falseWork = nil
end

return slot0
