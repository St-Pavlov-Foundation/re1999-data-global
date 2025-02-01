module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114KeyDayFlow", package.seeall)

slot0 = class("Activity114KeyDayFlow", Activity114BaseFlow)

function slot0.addEventWork(slot0)
	if Activity114Model.instance.serverData.checkEventId <= 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		slot0:addWork(Activity114KeyDayReqWork.New())
	end

	if slot0.context.eventCo.config.testId > 0 then
		slot0:addWork(Activity114AnswerWork.New())
	end

	if slot0.context.eventCo.config.isCheckEvent == 1 then
		slot0:addWork(Activity114DelayWork.New(0.2))
		slot0:addWork(Activity114CheckWork.New())
		slot0:addWork(Activity114DiceViewWork.New())
		slot0:addWork(Activity114KeyDayCheckResultWork.New())
	else
		slot0:addWork(Activity114StopStoryWork.New())

		if slot0.context.eventCo.config.testId > 0 then
			slot0:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
		end
	end
end

return slot0
