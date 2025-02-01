module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114BaseWork", package.seeall)

slot0 = class("Activity114BaseWork", BaseWork)

function slot0.forceEndStory(slot0)
	if slot0._flow then
		if not slot0._flow._workList[slot0._flow._curIndex] then
			return
		end

		slot1:forceEndStory()
	end
end

function slot0.getFlow(slot0)
	if not slot0._flow then
		slot0._flow = FlowSequence.New()
	end

	return slot0._flow
end

function slot0.startFlow(slot0)
	if slot0._flow then
		slot0._flow:registerDoneListener(slot0.onDone, slot0)
		slot0._flow:start(slot0.context)
	else
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:onDestroy()

		slot0._flow = nil
	end
end

return slot0
