module("framework.core.workflow.flow.BaseFlow", package.seeall)

slot0 = class("BaseFlow", BaseWork)

function slot0.start(slot0, slot1)
	slot0:onStartInternal(slot1)
end

function slot0.stop(slot0)
	slot0:onStopInternal()
end

function slot0.resume(slot0)
	slot0:onResumeInternal()
end

function slot0.destroy(slot0)
	slot0:onDestroyInternal()
end

function slot0.reset(slot0)
	slot0:onResetInternal()
end

function slot0.addWork(slot0, slot1)
	slot1:initInternal()

	slot1.flowName = slot0.flowName

	slot1:setParentInternal(slot0)
end

function slot0.onWorkDone(slot0, slot1)
	slot1:onResetInternal()
end

return slot0
