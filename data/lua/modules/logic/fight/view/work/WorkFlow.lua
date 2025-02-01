module("modules.logic.fight.view.work.WorkFlow", package.seeall)

slot0 = class("WorkFlow", BaseFlow)

function slot0.ctor(slot0)
	slot0._work = nil
end

function slot0.deserialize(slot0, slot1)
	if slot1 then
		slot0:addChild(slot0:_parse(slot1))
	end
end

function slot0._parse(slot0, slot1)
	if _G[slot1.type] then
		slot4 = slot0:_parse(slot1)

		slot0:addChild(slot2.New(slot1.paramTable))
	end
end

function slot0.addWork(slot0, slot1)
	uv0.super.addWork(slot0, slot1)

	slot0._work = slot1
end

function slot0.onWorkDone(slot0, slot1)
	slot0:onDone(slot0._work.isSuccess)
	slot0._work:onResetInternal()
end

function slot0.onStartInternal(slot0, slot1)
	uv0.super.onStartInternal(slot0, slot1)
	slot0._work:onStartInternal(slot0.context)
end

function slot0.onStopInternal(slot0)
	uv0.super.onStopInternal(slot0)

	if slot0._work.status == WorkStatus.Running then
		slot0._work:onStopInternal()
	end
end

function slot0.onResumeInternal(slot0)
	uv0.super.onResumeInternal(slot0)

	if slot0._work.status == WorkStatus.Stopped then
		slot0._work:onResumeInternal()
	end
end

function slot0.onResetInternal(slot0)
	uv0.super.onResetInternal(slot0)

	if slot0._work.status == WorkStatus.Running or slot0._work.status == WorkStatus.Stopped then
		slot0._work:onResetInternal()
	end
end

function slot0.onDestroyInternal(slot0)
	uv0.super.onDestroyInternal(slot0)

	if slot0._work.status == WorkStatus.Running then
		slot0._work:onStopInternal()
	end

	slot0._work:onResetInternal()

	slot0._work = nil
end

return slot0
