module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckOrAnswerWork", package.seeall)

slot0 = class("Activity114CheckOrAnswerWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	if slot0.context.eventCo.config.testId > 0 then
		slot0:getFlow():addWork(Activity114AnswerWork.New())
	elseif slot2.config.isCheckEvent == 1 then
		slot0:getFlow():addWork(Activity114DiceViewWork.New())
	else
		slot0.context.result = Activity114Enum.Result.Success
	end

	slot0:getFlow():addWork(Activity114CheckResultWork.New())
	slot0:startFlow()
end

return slot0
